"""Servidor del Museo Digital Unilibrista.

Sirve la interfaz (public/) y una API JSON. Los datos viven en MySQL (modo Docker) o en
SQLite (modo local); en ambos casos con el mismo esquema de 27 tablas (ver db.py y repo.py).
"""

import hashlib
import hmac
import json
import os
import re
import secrets
import time
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import parse_qs, urlparse

import db as database
import repo

ROOT = Path(__file__).resolve().parent
connection = database.connection

# Las sesiones se conservan en memoria mientras el servidor permanece encendido (RF-68).
SESSIONS = {}

KINDS = {"historia", "proyecto", "investigacion", "premio", "persona", "evento", "galeria"}
EXTRA_KEYS = ("eventType", "place", "participants", "researchLine", "team", "technologies", "result",
              "personCategory", "biography", "achievements", "eventDate", "eventObjective",
              "researchType", "impact", "authors")
CHECKLIST = ("accuracy", "duplicates", "metadata", "accessibility", "rights_check", "relevance")
TRANSITIONS = {
    "en_revision": {"return": "requiere_ajustes", "approve": "aprobado", "publish": "publicado", "archive": "archivado"},
    "aprobado": {"publish": "publicado", "archive": "archivado", "return": "requiere_ajustes"},
    "publicado": {"archive": "archivado"},
    "archivado": {"restore": "publicado"},
}
DECISION_LABEL = {"return": "devuelto con observaciones", "approve": "aprobado", "publish": "publicado",
                  "archive": "archivado", "restore": "restaurado"}


def password(raw, salt=None):
    """Genera una contraseña protegida con PBKDF2."""
    salt = salt or secrets.token_bytes(16)
    digest = hashlib.pbkdf2_hmac("sha256", raw.encode(), salt, 220000)
    return salt.hex() + "$" + digest.hex()


def valid_password(raw, stored):
    salt, digest = stored.split("$")
    candidate = password(raw, bytes.fromhex(salt)).split("$")[1]
    return hmac.compare_digest(candidate, digest)


class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(ROOT / "public"), **kwargs)

    # ------------------------------------------------------------ utilidades
    def send_json(self, status, data):
        payload = json.dumps(data, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(payload)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(payload)

    def body(self):
        length = int(self.headers.get("Content-Length", "0"))
        if length > 100000:
            raise ValueError("Solicitud demasiado grande")
        return json.loads(self.rfile.read(length) or b"{}")

    def user(self):
        match = re.search(r"(?:^|;\s*)museo_session=([a-f0-9]+)", self.headers.get("Cookie", ""))
        session = SESSIONS.get(match.group(1)) if match else None
        if not session or session[1] < time.time():
            return None
        with connection() as db:
            found = repo.get_user(db, session[0])
        return found if found and found["active"] else None

    def require(self, roles=None):
        current = self.user()
        if not current:
            raise PermissionError("Inicia sesión para continuar")
        if roles and current["role"] not in roles:
            raise PermissionError("No tienes permiso para esta acción")
        return current

    def error(self, error):
        self.send_json(403 if isinstance(error, PermissionError) else 400, {"error": str(error)})

    def log_message(self, *args):
        pass

    # ------------------------------------------------------------------ GET
    def do_GET(self):
        try:
            address = urlparse(self.path)
            route, query = address.path, parse_qs(address.query)
            flag = lambda name: query.get(name, [""])[0] == "1"

            if route == "/api/me":
                current = self.user()
                if current:
                    with connection() as db:
                        current = {**current, **repo.recognition(db, current["id"])}
                return self.send_json(200, current)

            if route == "/api/ranking":
                self.require()
                with connection() as db:
                    return self.send_json(200, repo.ranking(db))

            if route == "/api/contents":
                own, queue, manage, everything = flag("own"), flag("queue"), flag("manage"), flag("all")
                current = self.user()
                if own:
                    current = self.require()
                if queue or manage or everything:
                    current = self.require(["administrador"])
                params = ()
                if own:
                    where, params = "c.autor_id = ?", (current["id"],)
                elif everything:
                    where = "1=1"
                elif queue:
                    where = "c.estado IN ('en_revision', 'aprobado')"
                elif manage:
                    where = "c.estado IN ('aprobado', 'publicado', 'archivado')"
                else:
                    where = "c.estado = 'publicado'"
                with connection() as db:
                    results = repo.load_contents(db, where, params)
                if not (own or queue or manage or everything):
                    for field in ("kind", "category", "year"):
                        value = query.get(field, [""])[0]
                        if value:
                            results = [i for i in results if str(i[field]) == value]
                    text = query.get("q", [""])[0].lower().strip()
                    if text:
                        results = [i for i in results if text in " ".join(
                            str(i[k]) for k in ("title", "description", "protagonist", "tags")).lower()]
                return self.send_json(200, results)

            if route == "/api/reactions":
                cid, user = int(query.get("content_id", ["0"])[0]), self.user()
                with connection() as db:
                    row = db.execute("SELECT estado, autor_id FROM contenidos WHERE id = ?", (cid,)).fetchone()
                    if not row or (row["estado"] != "publicado" and (
                            not user or (user["id"] != row["autor_id"] and user["role"] != "administrador"))):
                        raise PermissionError("Contenido no disponible")
                    return self.send_json(200, repo.reactions_of(db, cid, user["id"] if user else -1))

            if route == "/api/history":
                user, cid = self.require(), int(query.get("id", ["0"])[0])
                with connection() as db:
                    row = db.execute("SELECT autor_id FROM contenidos WHERE id = ?", (cid,)).fetchone()
                    if not row or (row["autor_id"] != user["id"] and user["role"] != "administrador"):
                        raise PermissionError("No tienes permiso para consultar este historial")
                    return self.send_json(200, repo.content_history(db, cid))

            if route.startswith("/api/contents/"):
                content_id, current = int(route.rsplit("/", 1)[-1]), self.user()
                with connection() as db:
                    row = repo.get_content(db, content_id)
                allowed = row and (row["status"] == "publicado" or (current and (
                    current["role"] == "administrador" or current["id"] == row["author_id"])))
                if not allowed:
                    return self.send_json(404, {"error": "Contenido no disponible"})
                return self.send_json(200, row)

            if route == "/api/stats":
                with connection() as db:
                    return self.send_json(200, repo.stats(db))

            if route == "/api/users":
                self.require(["administrador"])
                with connection() as db:
                    return self.send_json(200, repo.list_users(db))

            if route == "/api/audit":
                self.require(["administrador"])
                with connection() as db:
                    return self.send_json(200, repo.audit_log(db))

            if route == "/api/favorites":
                current = self.require()
                with connection() as db:
                    return self.send_json(200, repo.favorites(db, current["id"]))

            if route == "/api/comments":
                content_id, current = int(query.get("content_id", ["0"])[0]), self.user()
                with connection() as db:
                    return self.send_json(200, repo.comments_of(db, content_id, current["id"] if current else -1))

            if route == "/api/moderation":
                self.require(["administrador"])
                with connection() as db:
                    return self.send_json(200, repo.pending_comments(db))

            if route == "/api/research":
                with connection() as db:
                    return self.send_json(200, repo.research_overview(db))

            if route == "/api/notifications":
                current = self.require()
                with connection() as db:
                    return self.send_json(200, repo.list_notifications(db, current["id"]))

            return super().do_GET()
        except Exception as error:
            self.error(error)

    # ----------------------------------------------------------------- POST
    def do_POST(self):
        try:
            route = urlparse(self.path).path
            data = self.body()

            if route == "/api/registration-decision":
                self.require(["administrador"])
                with connection() as db:
                    repo.reject_registration(db, int(data["id"]))
                return self.send_json(200, {"ok": True})

            if route == "/api/reactions":
                user = self.require()
                cid, emoji = int(data["content_id"]), str(data.get("emoji", ""))
                if emoji not in ("❤️", "👏", "💡"):
                    raise ValueError("Reacción inválida")
                with connection() as db:
                    row = db.execute("SELECT estado FROM contenidos WHERE id = ?", (cid,)).fetchone()
                    if not row or row["estado"] != "publicado":
                        raise ValueError("Solo puedes reaccionar a contenido publicado")
                    repo.toggle_reaction(db, user["id"], cid, emoji)
                return self.send_json(200, {"ok": True})

            if route == "/api/login":
                return self.login(data)

            if route == "/api/logout":
                match = re.search(r"museo_session=([a-f0-9]+)", self.headers.get("Cookie", ""))
                if match:
                    SESSIONS.pop(match.group(1), None)
                self.send_response(200)
                self.send_header("Set-Cookie", "museo_session=; HttpOnly; SameSite=Lax; Path=/; Max-Age=0")
                self.end_headers()
                return

            if route == "/api/register":
                return self.register(data)

            if route == "/api/contents":
                return self.create_content(data)

            if route.startswith("/api/contents/"):
                return self.update_content(int(route.rsplit("/", 1)[-1]), data)

            if route == "/api/users":
                current = self.require(["administrador"])
                user_id, role, active = int(data["id"]), data.get("role"), int(bool(data.get("active")))
                if role not in ("estudiante", "docente", "administrador"):
                    raise ValueError("Rol no permitido")
                if user_id == current["id"] and not active:
                    raise ValueError("No puedes desactivar tu propia cuenta")
                with connection() as db:
                    repo.update_user(db, user_id, role, active)
                return self.send_json(200, {"ok": True})

            if route == "/api/favorites":
                current, content_id = self.require(), int(data["content_id"])
                with connection() as db:
                    found = db.execute("SELECT id FROM contenidos WHERE id = ? AND estado = 'publicado'",
                                       (content_id,)).fetchone()
                    if not found:
                        raise ValueError("Contenido no disponible")
                    saved = repo.toggle_favorite(db, current["id"], content_id)
                return self.send_json(200, {"saved": saved})

            if route == "/api/comments":
                current, content_id = self.require(), int(data["content_id"])
                text = str(data.get("body", "")).strip()
                if not text or len(text) > 1000:
                    raise ValueError("Escribe un comentario de hasta 1000 caracteres")
                with connection() as db:
                    found = db.execute("SELECT 1 AS x FROM contenidos WHERE id = ? AND estado = 'publicado'",
                                       (content_id,)).fetchone()
                    if not found:
                        raise ValueError("Contenido no disponible")
                    repo.add_comment(db, current["id"], content_id, text)
                return self.send_json(201, {"message": "Comentario pendiente de moderación"})

            if route == "/api/moderation":
                self.require(["administrador"])
                comment_id, status = int(data["id"]), data.get("status")
                if status not in ("aprobado", "oculto"):
                    raise ValueError("Decisión inválida")
                with connection() as db:
                    repo.moderate_comment(db, comment_id, status)
                return self.send_json(200, {"ok": True})

            if route == "/api/notifications/read":
                current = self.require()
                with connection() as db:
                    repo.mark_notifications_read(db, current["id"])
                return self.send_json(200, {"ok": True})

            return self.send_json(404, {"error": "Ruta desconocida"})

        except database.IntegrityErrors:
            self.send_json(409, {"error": "Ese correo ya está registrado"})
        except Exception as error:
            self.error(error)

    # ------------------------------------------------------- cuentas y sesión
    def login(self, data):
        email = str(data.get("email", "")).lower().strip()
        with connection() as db:
            row = repo.get_user_by_email(db, email)
        correct = row and valid_password(str(data.get("password", "")), row["password_hash"])
        if correct and row["estado_registro"] == "pendiente":      # RF-36
            return self.send_json(401, {"error": "Tu cuenta está en espera de aprobación del administrador"})
        if not (correct and row["activo"]):
            return self.send_json(401, {"error": "Credenciales incorrectas"})
        token = secrets.token_hex(32)
        SESSIONS[token] = (row["id"], time.time() + 28800)
        self.send_response(200)
        self.send_header("Set-Cookie", f"museo_session={token}; HttpOnly; SameSite=Lax; Path=/; Max-Age=28800")
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(b'{"ok": true}')

    def register(self, data):
        name = str(data.get("name", "")).strip()
        email = str(data.get("email", "")).lower().strip()
        raw = str(data.get("password", ""))
        valid = (name and email.endswith("@unilibre.edu.co") and len(raw) >= 8 and re.search(r"[A-Z]", raw)
                 and re.search(r"\d", raw) and data.get("consent"))
        if not valid:
            raise ValueError("Revisa nombre, correo institucional, contraseña (8 caracteres, mayúscula y "
                             "número) y consentimiento")
        with connection() as db:
            repo.create_pending_user(db, name[:150], email, password(raw))
        return self.send_json(201, {"message": "Solicitud registrada. Espera la activación del administrador."})

    # ------------------------------------------------------------ contenidos
    def create_content(self, data):
        current = self.require(["estudiante", "docente", "administrador"])
        content = self.clean_content(data)
        status = "en_revision" if data.get("submit") else "borrador"
        if status == "en_revision":
            self.check_submission(content)
        with connection() as db:
            content_id = repo.save_content(db, content, status, current["id"])
            repo.log_change(db, current["id"], content_id, status, None, status)
            if status == "en_revision":
                repo.notify_admins(db, content_id, f"Nuevo aporte para validar: {content['title']}")
        return self.send_json(201, {"id": content_id, "status": status})

    def update_content(self, content_id, data):
        current = self.require()
        action = data.get("action", "save")
        with connection() as db:
            row = db.execute("SELECT autor_id, estado, titulo FROM contenidos WHERE id = ?", (content_id,)).fetchone()
            if not row:
                return self.send_json(404, {"error": "No encontrado"})
            old_state = row["estado"]
            note = str(data.get("note", "")).strip()[:1000]

            if action in ("save", "submit"):
                if not (row["autor_id"] == current["id"] and old_state in ("borrador", "requiere_ajustes")):
                    raise PermissionError("El aporte no se puede editar")
                content = self.clean_content(data)
                if action == "submit":
                    self.check_submission(content)
                status = "en_revision" if action == "submit" else old_state
                repo.save_content(db, content, status, row["autor_id"], content_id=content_id)
                if action == "submit":
                    repo.notify_admins(db, content_id, f"Aporte reenviado para validar: {content['title']}")
            else:
                if current["role"] != "administrador":
                    raise PermissionError("Solo administración valida")
                status = TRANSITIONS.get(old_state, {}).get(action)
                if not status:
                    raise ValueError("Cambio de estado no permitido")
                if action == "return" and not note:
                    raise ValueError("Escribe las observaciones")
                if (action == "approve" or (action == "publish" and old_state == "en_revision")) \
                        and not all(data.get(item) for item in CHECKLIST):
                    raise ValueError("Completa la lista de verificación")
                db.execute("UPDATE contenidos SET estado = ?, actualizado_en = CURRENT_TIMESTAMP WHERE id = ?",
                           (status, content_id))
                repo.record_validation(db, content_id, current["id"], action, note)
                if status == "publicado" and old_state != "publicado":
                    repo.award_points(db, row["autor_id"], "aporte_publicado", repo.POINTS_PER_PUBLICATION)
                repo.notify(db, row["autor_id"], content_id,
                            f"Tu aporte «{row['titulo']}» fue {DECISION_LABEL[action]}")
            repo.log_change(db, current["id"], content_id, action, old_state, status, note)
        return self.send_json(200, {"status": status})

    def clean_content(self, data):
        """Valida y normaliza los datos del formulario. Devuelve el contenido plano."""
        extra = data.get("extra", {})
        if not isinstance(extra, dict):
            raise ValueError("Campos específicos inválidos")
        clean_extra = {k: str(extra[k])[:3000] for k in EXTRA_KEYS if k in extra}
        media = extra.get("media", [])
        if not isinstance(media, list) or len(media) > 12:
            raise ValueError("Puedes adjuntar hasta 12 evidencias adicionales")
        clean_media = []
        for item in media:
            if not isinstance(item, dict):
                raise ValueError("Evidencia inválida")
            address = str(item.get("url", "")).strip()[:1000]
            kind_media = str(item.get("type", "foto"))
            if not address.startswith(("http://", "https://")) or kind_media not in ("foto", "video", "documento"):
                raise ValueError("Revisa el tipo y el enlace de la evidencia")
            clean_media.append({"url": address, "type": kind_media, "alt": str(item.get("alt", ""))[:300],
                                "credits": str(item.get("credits", ""))[:200],
                                "authorized": item.get("authorized") is True})
        if clean_media:
            clean_extra["media"] = clean_media

        kind = str(data.get("kind", ""))
        if kind not in KINDS:
            raise ValueError("Selecciona un tipo válido")
        try:
            year = int(data.get("year", 0))
        except (TypeError, ValueError):
            raise ValueError("Año inválido")
        if not 1900 <= year <= 2100:
            raise ValueError("El año debe estar entre 1900 y 2100")

        limits = (("title", 160), ("category", 80), ("protagonist", 160), ("description", 4000),
                  ("source", 500), ("tags", 400), ("image", 1000), ("evidence", 1000),
                  ("credit", 200), ("alt", 300))
        fields = {key: str(data.get(key, "")).strip()[:n] for key, n in limits}
        for address in (fields["image"], fields["evidence"]):
            if address and not address.startswith(("https://", "http://")):
                raise ValueError("Los enlaces de imagen y evidencia deben comenzar por http:// o https://")
        return {**fields, "kind": kind, "year": year, "rights": int(bool(data.get("rights"))), "extra": clean_extra}

    def check_submission(self, c):
        for media in c["extra"].get("media", []):
            if not all((media["alt"].strip(), media["credits"].strip(), media["authorized"])):
                raise ValueError("Cada evidencia adicional necesita descripción, créditos y autorización")
        if not all((c["title"], c["category"], c["protagonist"], c["description"], c["source"])) \
                or len(c["description"]) < 30:
            raise ValueError("Completa título, categoría, protagonistas, descripción (30 caracteres) y fuente")
        if (c["image"] or c["evidence"]) and not all((c["credit"], c["alt"], c["rights"])):
            raise ValueError("La evidencia necesita créditos, texto alternativo y autorización de uso")


if __name__ == "__main__":
    database.init_db()
    port = int(os.environ.get("PORT", "8000"))
    where = "MySQL" if database.ENGINE == "mysql" else f"SQLite ({database.SQLITE_PATH.name})"
    print(f"Museo disponible en http://localhost:{port}  ·  base de datos: {where}", flush=True)
    ThreadingHTTPServer((os.environ.get("HOST", "127.0.0.1"), port), Handler).serve_forever()
