"""Genera db/init/02_seed.sql: pasa los contenidos del prototipo (SQLite plano) al modelo de 27 tablas.

Uso:  python3 tools/crear_seed.py ruta/museo.sqlite3
Usa la misma capa de datos de la aplicación (app/repo.py), así el seed siempre es coherente con ella.
"""
import json, os, sqlite3, sys, tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
tmp = Path(tempfile.mkdtemp()) / "seed.sqlite3"
os.environ["SQLITE_PATH"] = str(tmp)
import shutil
solo_esquema = tmp.parent / "sql"; solo_esquema.mkdir()
shutil.copy(ROOT / "db" / "init" / "01_schema.sql", solo_esquema)   # sin datos previos
os.environ["SQL_DIR"] = str(solo_esquema)
sys.path.insert(0, str(ROOT / "app"))
import db, repo                                          # noqa: E402

origen = sqlite3.connect(sys.argv[1]); origen.row_factory = sqlite3.Row
db.init_db()

ORDEN = ["usuarios", "categorias", "personas", "etiquetas", "contenidos", "acontecimientos", "premios", "eventos",
         "hall_fama", "grupos_investigacion", "semilleros", "semillero_miembros", "proyectos", "investigaciones", "participaciones", "contenido_etiquetas", "evidencias",
         "validaciones", "auditoria", "insignias", "registro_puntos", "usuario_insignias"]
REG = {"approved": "aprobado", "pending": "pendiente", "rejected": "rechazado"}

with db.connection() as c:
    for u in origen.execute("SELECT * FROM users ORDER BY id"):
        c.execute("INSERT INTO usuarios (id,nombre,email,password_hash,rol,estado_registro,activo,acepto_datos_en) "
                  "VALUES (?,?,?,?,?,?,?,CURRENT_TIMESTAMP)",
                  (u["id"], u["name"], u["email"], u["password"], u["role"], REG[u["registration_status"]], u["active"]))
    for r in origen.execute("SELECT * FROM contents ORDER BY id"):
        extra = json.loads(r["extra"] or "{}")
        contenido = {"title": r["title"], "kind": r["kind"], "year": r["year"], "category": r["category"],
                     "protagonist": r["protagonist"], "description": r["description"], "source": r["source"],
                     "tags": r["tags"], "image": r["image"], "evidence": r["evidence"], "credit": r["credit"],
                     "alt": r["alt"], "rights": r["rights"], "extra": extra}
        for m in extra.get("media", []):
            m.setdefault("authorized", True)
        cid = repo.save_content(c, contenido, r["status"], r["author_id"], created_at=r["created_at"])
        assert cid == r["id"], (cid, r["id"])
        c.execute("INSERT INTO auditoria (usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota) VALUES (1,?,?,?,?,?)",
                  (cid, "publish" if r["status"] == "publicado" else "archive", "en_revision", r["status"],
                   "Carga inicial del prototipo"))
        if r["note"]:
            repo.record_validation(c, cid, 1, "return", r["note"])
    for nombre, desc, pts, icono in [("Primera memoria", "Publicó su primer aporte en el museo", 50, "sparkles"),
                                      ("Colaborador activo", "Tiene 3 aportes publicados", 150, "users"),
                                      ("Memoria viva", "Tiene 10 aportes publicados", 500, "award")]:
        c.execute("INSERT INTO insignias (nombre,descripcion,puntos_requeridos,icono) VALUES (?,?,?,?)", (nombre, desc, pts, icono))
    # ---- foto de "Grado Laureado — AccesoLibre": la original de Unsplash ya no carga; se usa otra del mismo banco que sí carga
    c.execute("UPDATE evidencias SET url = ? WHERE contenido_id = 24 AND orden = 1",
              ("https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800&h=500&fit=crop&auto=format",))
    # ---- puntos e insignias: 50 puntos por cada aporte publicado
    for fila in c.execute("SELECT autor_id FROM contenidos WHERE estado = 'publicado' ORDER BY id").fetchall():
        repo.award_points(c, fila["autor_id"], "aporte_publicado", repo.POINTS_PER_PUBLICATION)
    # ---- grupos y semilleros (datos tomados de los contenidos del prototipo)
    def persona(nombre):
        fila = c.execute("SELECT id FROM personas WHERE nombres = ? AND apellidos = ''", (nombre,)).fetchone()
        assert fila, f"persona no encontrada: {nombre}"
        return fila["id"]

    gisi = c.execute(
        "INSERT INTO grupos_investigacion (lider_id,nombre,codigo_minciencias,categoria,linea_principal) VALUES (?,?,?,?,?)",
        (persona("Dr. Héctor Villanueva"), "GISI — Inteligencia y Sistemas de Información", "COL0047823", "A1",
         "IA aplicada, seguridad informática, ingeniería de software y sistemas de información para la salud")).lastrowid
    seedai = c.execute(
        "INSERT INTO semilleros (grupo_id,nombre,descripcion,linea_investigacion,anio_creacion,estado) VALUES (?,?,?,?,?,'activo')",
        (gisi, "SeedAI — Inteligencia Artificial Aplicada",
         "Semillero estudiantil formado por estudiantes de séptimo semestre en adelante. Ha producido 8 publicaciones y 3 proyectos de grado laureados.",
         "Inteligencia artificial aplicada", 2018)).lastrowid
    inteligentes = c.execute(
        "INSERT INTO semilleros (grupo_id,coordinador_id,nombre,descripcion,linea_investigacion,anio_creacion,estado) VALUES (?,?,?,?,?,?,'activo')",
        (gisi, persona("Dr. Héctor Villanueva"), "Semillero de Sistemas Inteligentes",
         "Primer semillero de investigación del programa, enfocado en inteligencia artificial y bases de datos relacionales.",
         "Inteligencia artificial y bases de datos", 2001)).lastrowid
    c.execute(
        "INSERT INTO semilleros (nombre,descripcion,estado) VALUES (?,?,'activo')",
        ("Semillero de Innovación Digital", "Organiza el Hackathon LibreCode y espacios de innovación estudiantil."))
    for nombre in ("Est. Alejandro Herrera", "Paula Jiménez", "Miguel Ángel Suárez", "Tomás Gutiérrez"):
        c.execute("INSERT INTO semillero_miembros (semillero_id,persona_id,rol) VALUES (?,?,'integrante')", (seedai, persona(nombre)))
    c.execute("INSERT INTO semillero_miembros (semillero_id,persona_id,rol) VALUES (?,?,'coordinador')",
              (inteligentes, persona("Dr. Héctor Villanueva")))
    # contenidos de investigación del prototipo: 35 grupo GISI, 36 SeedAI, 37 patente, 38 artículo IEEE
    c.execute("UPDATE investigaciones SET grupo_id=? WHERE contenido_id IN (35,37,38)", (gisi,))
    c.execute("UPDATE investigaciones SET grupo_id=?, semillero_id=? WHERE contenido_id=36", (gisi, seedai))
    c.execute("UPDATE proyectos SET semillero_id=? WHERE contenido_id=17", (seedai,))   # BiciLibre: integra a Tomás Gutiérrez (SeedAI)

def lit(v):
    if v is None: return "NULL"
    if isinstance(v, (int, float)): return str(v)
    assert "\\" not in v, "texto con barra invertida: MySQL y SQLite la tratan distinto"
    return "'" + v.replace("'", "''") + "'"

lines = ["-- Datos de prueba (generado por tools/crear_seed.py). No editar a mano.", "USE museo_digital;", "SET NAMES utf8mb4;", ""]
raw = sqlite3.connect(tmp); raw.row_factory = sqlite3.Row
for t in ORDEN:
    rows = raw.execute(f"SELECT * FROM {t} ORDER BY 1").fetchall()
    if not rows: continue
    cols = rows[0].keys()
    lines.append(f"-- {t}: {len(rows)} filas")
    for r in rows:
        lines.append(f"INSERT INTO {t} ({','.join(cols)}) VALUES ({','.join(lit(r[k]) for k in cols)});")
    lines.append("")
(ROOT / "db" / "init" / "02_seed.sql").write_text("\n".join(lines), encoding="utf-8")
print({t: raw.execute(f"SELECT COUNT(*) FROM {t}").fetchone()[0] for t in ORDEN})
