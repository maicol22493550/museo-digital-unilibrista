"""Capa de datos: lee y escribe en las 27 tablas del modelo ER (v2.0).

La interfaz web trabaja con un "contenido plano" (title, kind, year, category,
protagonist, tags, image, extra...). Aquí se traduce ese contenido plano a las tablas
normalizadas (contenidos + subtipos, personas, etiquetas, evidencias...) y viceversa.
"""

import json
import re

MONTHS = {"ene": 1, "feb": 2, "mar": 3, "abr": 4, "may": 5, "jun": 6, "jul": 7,
          "ago": 8, "sep": 9, "oct": 10, "nov": 11, "dic": 12}
KIND_TO_TIPO = {"historia": "acontecimiento"}
TIPO_TO_KIND = {"acontecimiento": "historia"}
PERSON_CATEGORIES = ("docente", "estudiante", "egresado", "pionero")
REG_API = {"pendiente": "pending", "aprobado": "approved", "rechazado": "rejected"}
MEDIA_TO_DB = {"foto": "imagen", "video": "video", "documento": "documento"}
MEDIA_FROM_DB = {v: k for k, v in MEDIA_TO_DB.items()}
SUBTYPE_TABLES = ("acontecimientos", "premios", "eventos", "hall_fama", "proyectos", "investigaciones")

# Campos de "extra" que se guardan como personas relacionadas (tabla participaciones)
PEOPLE_FIELDS = {"participants": "participante", "team": "integrante", "authors": "autor"}


def tipo_of(kind):
    return KIND_TO_TIPO.get(kind, kind)


def kind_of(tipo):
    return TIPO_TO_KIND.get(tipo, tipo)


def _marks(items):
    return ",".join("?" for _ in items)


# ======================================================================= usuarios
def user_public(row):
    return {"id": row["id"], "name": row["nombre"], "email": row["email"],
            "role": row["rol"], "active": row["activo"]}


POINTS_PER_PUBLICATION = 50


def award_points(db, user_id, action, points):
    """Suma puntos (registro_puntos) y entrega las insignias cuyo mínimo ya se alcanzó (usuario_insignias)."""
    db.execute("INSERT INTO registro_puntos (usuario_id, accion, puntos) VALUES (?, ?, ?)", (user_id, action, points))
    total = db.execute("SELECT COALESCE(SUM(puntos), 0) AS n FROM registro_puntos WHERE usuario_id = ?",
                       (user_id,)).scalar()
    for badge in db.execute("SELECT id FROM insignias WHERE puntos_requeridos <= ? AND id NOT IN "
                            "(SELECT insignia_id FROM usuario_insignias WHERE usuario_id = ?)",
                            (total, user_id)).fetchall():
        db.execute("INSERT INTO usuario_insignias (usuario_id, insignia_id) VALUES (?, ?)", (user_id, badge["id"]))


def recognition(db, user_id):
    points = db.execute("SELECT COALESCE(SUM(puntos), 0) AS n FROM registro_puntos WHERE usuario_id = ?",
                        (user_id,)).scalar()
    badges = db.execute(
        "SELECT i.nombre AS name, i.descripcion AS description, i.icono AS icon, i.puntos_requeridos AS points "
        "FROM usuario_insignias ui JOIN insignias i ON i.id = ui.insignia_id "
        "WHERE ui.usuario_id = ? ORDER BY i.puntos_requeridos", (user_id,)).fetchall()
    return {"points": int(points), "badges": badges}


def ranking(db, limit=10):
    """Ranking de colaboración: usuarios activos ordenados por puntos (registro_puntos)."""
    return db.execute(
        "SELECT u.id, u.nombre AS name, u.rol AS role, SUM(p.puntos) AS points "
        "FROM registro_puntos p JOIN usuarios u ON u.id = p.usuario_id "
        "WHERE u.activo = 1 AND u.estado_registro = 'aprobado' "
        "GROUP BY u.id, u.nombre, u.rol HAVING SUM(p.puntos) > 0 "
        "ORDER BY points DESC, u.nombre LIMIT ?", (limit,)).fetchall()


def get_user(db, user_id):
    row = db.execute("SELECT * FROM usuarios WHERE id = ?", (user_id,)).fetchone()
    return user_public(row) if row else None


def get_user_by_email(db, email):
    return db.execute("SELECT * FROM usuarios WHERE email = ?", (email,)).fetchone()


def list_users(db):
    rows = db.execute("SELECT * FROM usuarios ORDER BY id").fetchall()
    return [{**user_public(r), "registration_status": REG_API.get(r["estado_registro"], r["estado_registro"])}
            for r in rows]


def create_pending_user(db, name, email, password_hash):
    cur = db.execute(
        "INSERT INTO usuarios (nombre, email, password_hash, rol, estado_registro, activo, acepto_datos_en) "
        "VALUES (?, ?, ?, 'estudiante', 'pendiente', 0, CURRENT_TIMESTAMP)",
        (name, email, password_hash))
    notify_admins(db, None, f"Nueva solicitud de registro: {name} ({email})")
    return cur.lastrowid


def reject_registration(db, user_id):
    row = db.execute("SELECT estado_registro FROM usuarios WHERE id = ?", (user_id,)).fetchone()
    if not row or row["estado_registro"] != "pendiente":
        raise ValueError("La solicitud ya no está pendiente")
    db.execute("UPDATE usuarios SET estado_registro='rechazado', activo=0 WHERE id = ?", (user_id,))


def update_user(db, user_id, role, active):
    target = db.execute("SELECT rol, activo FROM usuarios WHERE id = ?", (user_id,)).fetchone()
    if not target:
        raise ValueError("Usuario no encontrado")
    if target["rol"] == "administrador" and target["activo"] and (role != "administrador" or not active):
        total = db.execute("SELECT COUNT(*) AS n FROM usuarios WHERE rol='administrador' AND activo=1").scalar()
        if total <= 1:
            raise ValueError("Debe quedar al menos un administrador activo")
    if active:
        db.execute("UPDATE usuarios SET rol=?, activo=1, estado_registro='aprobado' WHERE id=?", (role, user_id))
    else:
        db.execute("UPDATE usuarios SET rol=?, activo=0 WHERE id=?", (role, user_id))


# ================================================================= notificaciones
def notify(db, user_id, content_id, message):
    db.execute("INSERT INTO notificaciones (usuario_id, contenido_id, mensaje) VALUES (?, ?, ?)",
               (user_id, content_id, message[:300]))


def notify_admins(db, content_id, message):
    for row in db.execute("SELECT id FROM usuarios WHERE rol='administrador' AND activo=1").fetchall():
        notify(db, row["id"], content_id, message)


def list_notifications(db, user_id):
    return db.execute(
        "SELECT id, contenido_id AS content_id, mensaje AS message, leida AS is_read, fecha AS created_at "
        "FROM notificaciones WHERE usuario_id = ? ORDER BY id DESC LIMIT 50",
        (user_id,)).fetchall()


def mark_notifications_read(db, user_id):
    db.execute("UPDATE notificaciones SET leida = 1 WHERE usuario_id = ?", (user_id,))


# =================================================================== contenidos
def _parse_date(text):
    """'18 – 22 ago 2026' -> ('2026-08-18', '2026-08-22'); '12 sep 2025' -> ('2025-09-12', None)."""
    text = (text or "").lower()
    iso = re.match(r"(\d{4})-(\d{2})-(\d{2})", text)
    if iso:
        return iso.group(0), None
    m = re.search(r"(\d{1,2})\s*(?:[–-]\s*(\d{1,2}))?\s*([a-z]{3})[a-z]*\.?\s*(\d{4})", text)
    if not m or m.group(3) not in MONTHS:
        return None, None
    month, year = MONTHS[m.group(3)], int(m.group(4))
    start = f"{year:04d}-{month:02d}-{int(m.group(1)):02d}"
    end = f"{year:04d}-{month:02d}-{int(m.group(2)):02d}" if m.group(2) else None
    return start, end


def _category_id(db, name):
    row = db.execute("SELECT id FROM categorias WHERE nombre = ?", (name,)).fetchone()
    if row:
        return row["id"]
    return db.execute("INSERT INTO categorias (nombre) VALUES (?)", (name,)).lastrowid


def _person_id(db, name, category=None):
    name = name[:100]
    row = db.execute("SELECT id FROM personas WHERE nombres = ? AND apellidos = ''", (name,)).fetchone()
    if row:
        if category:
            db.execute("UPDATE personas SET categoria = ? WHERE id = ?", (category, row["id"]))
        return row["id"]
    return db.execute("INSERT INTO personas (nombres, apellidos, categoria) VALUES (?, '', ?)",
                      (name, category or "otro")).lastrowid


def _names(text):
    seen, names = set(), []
    for part in (text or "").split(","):
        part = part.strip()
        if part and part not in seen:
            seen.add(part)
            names.append(part)
    return names


def save_content(db, c, status, author_id, content_id=None, created_at=None):
    """Guarda un contenido plano `c` (ver server.clean_content) en las tablas normalizadas."""
    extra = c["extra"]
    category_id = _category_id(db, c["category"] or "Sin categoría")
    tipo = tipo_of(c["kind"])

    old_project = old_research = None
    if content_id is None:
        columns = "autor_id, categoria_id, tipo, titulo, descripcion, anio, fuente, derechos_autor, estado"
        values = [author_id, category_id, tipo, c["title"], c["description"], c["year"],
                  c["source"], c["rights"], status]
        if created_at:
            columns += ", creado_en, actualizado_en"
            values += [created_at, created_at]
        content_id = db.execute(
            f"INSERT INTO contenidos ({columns}) VALUES ({_marks(values)})", values).lastrowid
    else:
        db.execute(
            "UPDATE contenidos SET categoria_id=?, tipo=?, titulo=?, descripcion=?, anio=?, fuente=?, "
            "derechos_autor=?, estado=?, actualizado_en=CURRENT_TIMESTAMP WHERE id=?",
            (category_id, tipo, c["title"], c["description"], c["year"], c["source"],
             c["rights"], status, content_id))
        # Los vínculos con semilleros/grupos los fija la administración: se conservan al editar.
        old_project = db.execute("SELECT semillero_id FROM proyectos WHERE contenido_id = ?", (content_id,)).fetchone()
        old_research = db.execute("SELECT semillero_id, grupo_id FROM investigaciones WHERE contenido_id = ?",
                                  (content_id,)).fetchone()
        for table in SUBTYPE_TABLES:
            db.execute(f"DELETE FROM {table} WHERE contenido_id = ?", (content_id,))
        for table in ("participaciones", "contenido_etiquetas", "evidencias"):
            db.execute(f"DELETE FROM {table} WHERE contenido_id = ?", (content_id,))

    # --- protagonistas y personas relacionadas (participaciones: una fila por persona,
    #     con sus papeles separados por coma, p. ej. "protagonista,integrante")
    members, hall_person = {}, None
    groups = [("protagonista", c["protagonist"])] + [
        (role, extra.get(field, "")) for field, role in PEOPLE_FIELDS.items()]
    person_category = extra.get("personCategory")
    person_category = person_category if person_category in PERSON_CATEGORIES else None
    for role, text in groups:
        for name in _names(text):
            first_hall = tipo == "persona" and role == "protagonista" and hall_person is None
            pid = _person_id(db, name, person_category if first_hall else None)
            if first_hall:
                hall_person = pid
            members.setdefault(pid, []).append(role)
    for order, (pid, roles) in enumerate(members.items(), start=1):
        db.execute("INSERT INTO participaciones (contenido_id, persona_id, rol, orden) VALUES (?, ?, ?, ?)",
                   (content_id, pid, ",".join(roles), order))

    # --- subtipo según el tipo de contenido
    year = c["year"]
    if tipo == "acontecimiento":
        db.execute("INSERT INTO acontecimientos (contenido_id, fecha, tipo_hito) VALUES (?, ?, ?)",
                   (content_id, f"{year:04d}-01-01", extra.get("eventType", "hito")[:20] or "hito"))
    elif tipo == "premio":
        db.execute("INSERT INTO premios (contenido_id, lugar, fecha) VALUES (?, ?, ?)",
                   (content_id, extra.get("place") or None, f"{year:04d}-01-01"))
    elif tipo == "evento":
        start, end = _parse_date(extra.get("eventDate"))
        db.execute("INSERT INTO eventos (contenido_id, fecha_inicio, fecha_fin, fecha_texto, lugar, objetivo) "
                   "VALUES (?, ?, ?, ?, ?, ?)",
                   (content_id, start and start + " 00:00:00", end and end + " 00:00:00",
                    (extra.get("eventDate") or None) and extra["eventDate"][:80],
                    extra.get("place") or None, extra.get("eventObjective") or None))
    elif tipo == "persona":
        db.execute("INSERT INTO hall_fama (contenido_id, persona_id, biografia, logros) VALUES (?, ?, ?, ?)",
                   (content_id, hall_person, extra.get("biography") or None, extra.get("achievements") or None))
    elif tipo == "proyecto":
        db.execute("INSERT INTO proyectos (contenido_id, semillero_id, linea_investigacion, tecnologias, resultados) "
                   "VALUES (?, ?, ?, ?, ?)",
                   (content_id, old_project and old_project["semillero_id"], extra.get("researchLine") or None,
                    extra.get("technologies") or None, extra.get("result") or None))
    elif tipo == "investigacion":
        db.execute("INSERT INTO investigaciones (contenido_id, semillero_id, grupo_id, tipo, impacto) "
                   "VALUES (?, ?, ?, ?, ?)",
                   (content_id, old_research and old_research["semillero_id"], old_research and old_research["grupo_id"],
                    (extra.get("researchType") or "publicacion")[:30], extra.get("impact") or None))

    # --- etiquetas
    for tag in _names(c["tags"]):
        tag = tag[:60]
        row = db.execute("SELECT id FROM etiquetas WHERE nombre = ?", (tag,)).fetchone()
        tag_id = row["id"] if row else db.execute("INSERT INTO etiquetas (nombre) VALUES (?)", (tag,)).lastrowid
        exists = db.execute("SELECT 1 AS x FROM contenido_etiquetas WHERE contenido_id=? AND etiqueta_id=?",
                            (content_id, tag_id)).fetchone()
        if not exists:
            db.execute("INSERT INTO contenido_etiquetas (contenido_id, etiqueta_id) VALUES (?, ?)",
                       (content_id, tag_id))

    # --- evidencias: orden 1 = imagen principal, 2 = documento/enlace, 3+ = adicionales
    credit, alt, rights = c["credit"], c["alt"], c["rights"]
    if c["image"] or credit or alt:
        db.execute("INSERT INTO evidencias (contenido_id, tipo, url, credito, texto_alt, orden, autorizado) "
                   "VALUES (?, 'imagen', ?, ?, ?, 1, ?)", (content_id, c["image"], credit, alt, rights))
    if c["evidence"]:
        db.execute("INSERT INTO evidencias (contenido_id, tipo, url, credito, texto_alt, orden, autorizado) "
                   "VALUES (?, 'documento', ?, ?, ?, 2, ?)", (content_id, c["evidence"], credit, alt, rights))
    for index, media in enumerate(extra.get("media", []), start=3):
        db.execute("INSERT INTO evidencias (contenido_id, tipo, url, credito, texto_alt, orden, autorizado) "
                   "VALUES (?, ?, ?, ?, ?, ?, ?)",
                   (content_id, MEDIA_TO_DB.get(media["type"], "imagen"), media["url"], media["credits"],
                    media["alt"], index, int(media["authorized"])))
    return content_id


def load_contents(db, where="1=1", params=(), order="c.id DESC"):
    """Devuelve contenidos en el formato plano que usa la interfaz."""
    rows = db.execute(
        "SELECT c.id, c.titulo, c.tipo, c.anio, cat.nombre AS categoria, c.descripcion, c.fuente, "
        "c.derechos_autor, c.estado, c.autor_id, c.creado_en, c.actualizado_en, u.nombre AS autor "
        "FROM contenidos c JOIN categorias cat ON cat.id = c.categoria_id "
        f"JOIN usuarios u ON u.id = c.autor_id WHERE {where} ORDER BY {order}", params).fetchall()
    if not rows:
        return []
    ids = [r["id"] for r in rows]
    marks = _marks(ids)

    def by_content(sql, key="contenido_id"):
        grouped = {}
        for r in db.execute(sql.replace("{ids}", marks), ids).fetchall():
            grouped.setdefault(r[key], []).append(r)
        return grouped

    people = by_content("SELECT pa.contenido_id, pa.rol, p.nombres, p.apellidos, p.categoria FROM participaciones pa "
                        "JOIN personas p ON p.id = pa.persona_id WHERE pa.contenido_id IN ({ids}) ORDER BY pa.orden")
    tags = by_content("SELECT ce.contenido_id, e.nombre FROM contenido_etiquetas ce "
                      "JOIN etiquetas e ON e.id = ce.etiqueta_id WHERE ce.contenido_id IN ({ids}) ORDER BY e.id")
    evid = by_content("SELECT * FROM evidencias WHERE contenido_id IN ({ids}) ORDER BY orden")
    sub = {t: {r["contenido_id"]: r for r in db.execute(
        f"SELECT * FROM {t} WHERE contenido_id IN ({marks})", ids).fetchall()} for t in SUBTYPE_TABLES}
    hall_people = {r["contenido_id"]: r["categoria"] for r in db.execute(
        "SELECT h.contenido_id, p.categoria FROM hall_fama h JOIN personas p ON p.id = h.persona_id "
        f"WHERE h.contenido_id IN ({marks})", ids).fetchall()}
    notes = {r["contenido_id"]: r["observaciones"] for r in db.execute(
        "SELECT contenido_id, observaciones FROM validaciones WHERE id IN "
        f"(SELECT MAX(id) FROM validaciones WHERE contenido_id IN ({marks}) GROUP BY contenido_id)", ids).fetchall()}

    result = []
    for r in rows:
        cid, tipo = r["id"], r["tipo"]
        extra = {}

        def put(key, value):
            if value not in (None, ""):
                extra[key] = str(value)

        def names(role):
            return ", ".join((p["nombres"] + " " + p["apellidos"]).strip()
                             for p in people.get(cid, []) if role in p["rol"].split(","))

        if tipo == "acontecimiento":
            put("eventType", sub["acontecimientos"].get(cid, {}).get("tipo_hito"))
        elif tipo == "premio":
            put("place", sub["premios"].get(cid, {}).get("lugar"))
            put("participants", names("participante"))
        elif tipo == "evento":
            e = sub["eventos"].get(cid, {})
            put("eventDate", e.get("fecha_texto"))
            put("place", e.get("lugar"))
            put("eventObjective", e.get("objetivo"))
        elif tipo == "persona":
            h = sub["hall_fama"].get(cid, {})
            put("biography", h.get("biografia"))
            put("achievements", h.get("logros"))
            if hall_people.get(cid) in PERSON_CATEGORIES:
                put("personCategory", hall_people[cid])
        elif tipo == "proyecto":
            p = sub["proyectos"].get(cid, {})
            put("researchLine", p.get("linea_investigacion"))
            put("team", names("integrante"))
            put("technologies", p.get("tecnologias"))
            put("result", p.get("resultados"))
        elif tipo == "investigacion":
            i = sub["investigaciones"].get(cid, {})
            put("researchType", i.get("tipo"))
            put("impact", i.get("impacto"))
            put("authors", names("autor"))

        image = evidence = credit = alt = ""
        media = []
        for ev in evid.get(cid, []):
            if ev["orden"] == 1:
                image, credit, alt = ev["url"], ev["credito"], ev["texto_alt"]
            elif ev["orden"] == 2:
                evidence = ev["url"]
                credit, alt = credit or ev["credito"], alt or ev["texto_alt"]
            else:
                media.append({"url": ev["url"], "type": MEDIA_FROM_DB.get(ev["tipo"], "foto"),
                              "alt": ev["texto_alt"], "credits": ev["credito"],
                              "authorized": bool(ev["autorizado"])})
        if media:
            extra["media"] = media

        result.append({
            "id": cid, "title": r["titulo"], "kind": kind_of(tipo), "year": r["anio"],
            "category": r["categoria"], "protagonist": names("protagonista"),
            "description": r["descripcion"], "source": r["fuente"],
            "tags": ",".join(t["nombre"] for t in tags.get(cid, [])),
            "image": image, "evidence": evidence, "credit": credit, "alt": alt,
            "rights": r["derechos_autor"], "status": r["estado"], "author_id": r["autor_id"],
            "created_at": r["creado_en"], "updated_at": r["actualizado_en"],
            "note": notes.get(cid) or "", "extra": json.dumps(extra, ensure_ascii=False),
            "author": r["autor"],
        })
    return result


def get_content(db, content_id):
    rows = load_contents(db, "c.id = ?", (content_id,))
    return rows[0] if rows else None


def stats(db):
    rows = db.execute("SELECT tipo, COUNT(*) AS total FROM contenidos WHERE estado='publicado' GROUP BY tipo").fetchall()
    return {kind_of(r["tipo"]): r["total"] for r in rows}


# ================================================== versiones, auditoría, validación
def log_change(db, user_id, content_id, action, old_state, new_state, note=""):
    """Bitácora (RF-64) + versión del contenido (RF-67)."""
    db.execute("INSERT INTO auditoria (usuario_id, contenido_id, accion, estado_anterior, estado_nuevo, nota) "
               "VALUES (?, ?, ?, ?, ?, ?)", (user_id, content_id, action, old_state, new_state, note[:1000]))
    snapshot = get_content(db, content_id)
    number = db.execute("SELECT COALESCE(MAX(numero), 0) + 1 AS n FROM contenido_versiones WHERE contenido_id = ?",
                        (content_id,)).scalar()
    db.execute("INSERT INTO contenido_versiones (contenido_id, autor_id, numero, estado, snapshot, observaciones) "
               "VALUES (?, ?, ?, ?, ?, ?)",
               (content_id, user_id, number, new_state or old_state or "", json.dumps(snapshot, ensure_ascii=False),
                note[:1000] or None))


def record_validation(db, content_id, user_id, action, note):
    db.execute("INSERT INTO validaciones (contenido_id, usuario_id, accion, observaciones) VALUES (?, ?, ?, ?)",
               (content_id, user_id, action, note[:1000]))


AUDIT_SELECT = ("SELECT a.id, a.contenido_id AS content_id, a.usuario_id AS actor_id, a.accion AS action, "
                "a.nota AS note, a.estado_anterior, a.estado_nuevo, a.fecha AS created_at")


def content_history(db, content_id):
    return db.execute(AUDIT_SELECT + ", u.nombre AS actor FROM auditoria a JOIN usuarios u ON u.id = a.usuario_id "
                      "WHERE a.contenido_id = ? ORDER BY a.id DESC", (content_id,)).fetchall()


def audit_log(db):
    return db.execute(AUDIT_SELECT + " FROM auditoria a ORDER BY a.id DESC LIMIT 100").fetchall()


# ===================================================== favoritos, comentarios, reacciones
def favorites(db, user_id):
    return load_contents(
        db, "c.estado = 'publicado' AND c.id IN (SELECT contenido_id FROM favoritos WHERE usuario_id = ?)", (user_id,))


def toggle_favorite(db, user_id, content_id):
    exists = db.execute("SELECT 1 AS x FROM favoritos WHERE usuario_id=? AND contenido_id=?",
                        (user_id, content_id)).fetchone()
    if exists:
        db.execute("DELETE FROM favoritos WHERE usuario_id=? AND contenido_id=?", (user_id, content_id))
    else:
        db.execute("INSERT INTO favoritos (usuario_id, contenido_id) VALUES (?, ?)", (user_id, content_id))
    return not exists


def comments_of(db, content_id, user_id):
    return db.execute(
        "SELECT cm.id, cm.cuerpo AS body, cm.estado AS status, cm.fecha AS created_at, u.nombre AS name "
        "FROM comentarios cm JOIN usuarios u ON u.id = cm.usuario_id "
        "WHERE cm.contenido_id = ? AND (cm.estado = 'aprobado' OR cm.usuario_id = ?) ORDER BY cm.id DESC",
        (content_id, user_id)).fetchall()


def add_comment(db, user_id, content_id, text):
    db.execute("INSERT INTO comentarios (usuario_id, contenido_id, cuerpo) VALUES (?, ?, ?)",
               (user_id, content_id, text))
    notify_admins(db, content_id, "Nuevo comentario pendiente de moderación")


def pending_comments(db):
    return db.execute(
        "SELECT cm.id, cm.usuario_id AS user_id, cm.contenido_id AS content_id, cm.cuerpo AS body, "
        "cm.estado AS status, cm.fecha AS created_at, u.nombre AS name "
        "FROM comentarios cm JOIN usuarios u ON u.id = cm.usuario_id "
        "WHERE cm.estado = 'pendiente' ORDER BY cm.id DESC").fetchall()


def moderate_comment(db, comment_id, status):
    db.execute("UPDATE comentarios SET estado = ? WHERE id = ?", (status, comment_id))


def reactions_of(db, content_id, user_id):
    rows = db.execute("SELECT tipo AS emoji, COUNT(*) AS total FROM reacciones WHERE contenido_id = ? GROUP BY tipo",
                      (content_id,)).fetchall()
    mine = db.execute("SELECT tipo AS emoji FROM reacciones WHERE contenido_id = ? AND usuario_id = ?",
                      (content_id, user_id)).fetchone()
    return {"counts": {r["emoji"]: r["total"] for r in rows}, "mine": mine["emoji"] if mine else None}


def toggle_reaction(db, user_id, content_id, emoji):
    old = db.execute("SELECT tipo FROM reacciones WHERE contenido_id=? AND usuario_id=?",
                     (content_id, user_id)).fetchone()
    db.execute("DELETE FROM reacciones WHERE contenido_id=? AND usuario_id=?", (content_id, user_id))
    if not old or old["tipo"] != emoji:
        db.execute("INSERT INTO reacciones (usuario_id, contenido_id, tipo) VALUES (?, ?, ?)",
                   (user_id, content_id, emoji))


# ============================================================ grupos y semilleros
def research_overview(db):
    """Grupos de investigación con sus semilleros, integrantes y contenidos relacionados (RF-28)."""
    def person(row):
        return ((row["nombres"] or "") + " " + (row["apellidos"] or "")).strip() or None if row else None

    groups = db.execute(
        "SELECT g.*, p.nombres, p.apellidos FROM grupos_investigacion g "
        "LEFT JOIN personas p ON p.id = g.lider_id ORDER BY g.id").fetchall()
    seedbeds = db.execute(
        "SELECT s.*, p.nombres, p.apellidos FROM semilleros s "
        "LEFT JOIN personas p ON p.id = s.coordinador_id ORDER BY s.id").fetchall()
    members = db.execute(
        "SELECT m.semillero_id, m.rol, p.nombres, p.apellidos FROM semillero_miembros m "
        "JOIN personas p ON p.id = m.persona_id ORDER BY p.id").fetchall()
    links = db.execute(
        "SELECT i.semillero_id, i.grupo_id, c.id, c.titulo, c.anio FROM investigaciones i "
        "JOIN contenidos c ON c.id = i.contenido_id WHERE c.estado = 'publicado'").fetchall()
    projects = db.execute(
        "SELECT pr.semillero_id, c.id, c.titulo, c.anio FROM proyectos pr "
        "JOIN contenidos c ON c.id = pr.contenido_id WHERE c.estado = 'publicado' AND pr.semillero_id IS NOT NULL"
    ).fetchall()

    def seedbed(s):
        return {"id": s["id"], "name": s["nombre"], "description": s["descripcion"],
                "line": s["linea_investigacion"], "year": s["anio_creacion"], "status": s["estado"],
                "coordinator": person(s),
                "members": [{"name": person(m), "role": m["rol"]} for m in members if m["semillero_id"] == s["id"]],
                "research": [{"id": l["id"], "title": l["titulo"], "year": l["anio"]}
                             for l in links if l["semillero_id"] == s["id"]],
                "projects": [{"id": p["id"], "title": p["titulo"], "year": p["anio"]}
                             for p in projects if p["semillero_id"] == s["id"]]}

    result = [{"id": g["id"], "name": g["nombre"], "code": g["codigo_minciencias"], "category": g["categoria"],
               "line": g["linea_principal"], "leader": person(g),
               "seedbeds": [seedbed(s) for s in seedbeds if s["grupo_id"] == g["id"]],
               "research": [{"id": l["id"], "title": l["titulo"], "year": l["anio"]}
                            for l in links if l["grupo_id"] == g["id"]]} for g in groups]
    loose = [seedbed(s) for s in seedbeds if s["grupo_id"] is None]
    return {"groups": result, "seedbeds_without_group": loose}
