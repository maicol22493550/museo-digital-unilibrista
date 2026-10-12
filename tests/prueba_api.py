"""Prueba de punta a punta de la API (modo SQLite). Uso: python3 tests/prueba_api.py [museo_original.sqlite3]"""
import json, os, subprocess, sys, tempfile, time, urllib.request, urllib.error, sqlite3
from http.cookiejar import CookieJar
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
tmp = Path(tempfile.mkdtemp()); port = "8765"
env = {**os.environ, "SQLITE_PATH": str(tmp / "t.sqlite3"), "PORT": port}
env.pop("DB_HOST", None)
srv = subprocess.Popen([sys.executable, str(ROOT / "app" / "server.py")], env=env, cwd=ROOT / "app",
                       stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
time.sleep(2.5)
fails = []
def check(name, cond, extra=""):
    print(("OK   " if cond else "FALLA"), name, extra)
    if not cond: fails.append(name)

class Client:
    def __init__(self): self.jar = CookieJar(); self.op = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(self.jar))
    def call(self, method, path, data=None):
        req = urllib.request.Request(f"http://127.0.0.1:{port}{path}", method=method,
              data=json.dumps(data).encode() if data is not None else None, headers={"Content-Type": "application/json"})
        try:
            r = self.op.open(req); body = r.read(); code = r.status
        except urllib.error.HTTPError as e:
            body = e.read(); code = e.code
        try: return code, json.loads(body)
        except Exception: return code, body
try:
    anon, admin, student = Client(), Client(), Client()
    code, items = anon.call("GET", "/api/contents")
    check("lista pública", code == 200 and len(items) == 47, f"({len(items)} publicados)")
    check("sin contenido archivado", all(i["status"] == "publicado" for i in items))

    if len(sys.argv) > 1:       # comparar contra los datos originales (ida y vuelta)
        o = sqlite3.connect(sys.argv[1]); o.row_factory = sqlite3.Row
        mine = {i["id"]: i for i in items}; bad = []
        for r in o.execute("SELECT * FROM contents WHERE status='publicado' ORDER BY id"):
            m = mine.get(r["id"])
            if not m: bad.append((r["id"], "falta")); continue
            for k in ("title", "kind", "year", "category", "protagonist", "image", "credit", "alt", "evidence"):
                if str(m[k]) != str(r[k]): bad.append((r["id"], k, m[k], r[k]))
            if set(m["tags"].split(",")) - {""} != set(t.strip() for t in r["tags"].split(",") if t.strip()): bad.append((r["id"], "tags"))
            eo, em = json.loads(r["extra"] or "{}"), json.loads(m["extra"])
            for k, v in eo.items():
                if k == "media": continue
                same = (set(x.strip() for x in str(em.get(k)).split(",")) == set(x.strip() for x in v.split(","))) if k in ("team", "participants", "authors") else em.get(k) == v
                if not same: bad.append((r["id"], "extra." + k, em.get(k), v))
        check("ida y vuelta idéntica a los datos originales", not bad, str(bad[:5]))

    code, _ = admin.call("POST", "/api/login", {"email": "admin@unilibre.edu.co", "password": "Museo2026!"})
    check("login administrador", code == 200)
    code, _ = student.call("POST", "/api/login", {"email": "estudiante@unilibre.edu.co", "password": "Museo2026!"})
    check("login estudiante", code == 200)
    code, _ = anon.call("POST", "/api/login", {"email": "estudiante@unilibre.edu.co", "password": "mala"})
    check("login con clave mala rechazado", code == 401)
    code, _ = anon.call("POST", "/api/login", {"email": "maicole-osorioc@unilibre.edu.co", "password": "x"})
    check("cuenta pendiente no entra", code == 401)

    code, r = student.call("GET", "/api/contents?queue=1"); check("estudiante no ve la bandeja", code == 403)
    code, r = student.call("GET", "/api/users"); check("estudiante no ve usuarios", code == 403)

    nuevo = {"title": "Prueba de aporte", "kind": "proyecto", "year": 2025, "category": "Innovación",
             "protagonist": "Laura Pineda, Carlos Pérez", "description": "Un aporte de prueba con más de treinta caracteres.",
             "source": "Fuente de prueba", "tags": "prueba,museo", "image": "https://example.com/a.jpg",
             "credit": "Autor", "alt": "Foto de prueba", "rights": True,
             "extra": {"researchLine": "Software", "team": "Ana, Luis", "technologies": "Python, MySQL", "result": "Funciona",
                       "media": [{"url": "https://example.com/v.mp4", "type": "video", "alt": "video", "credits": "X", "authorized": True}]}}
    code, r = student.call("POST", "/api/contents", {**nuevo, "submit": True}); check("estudiante envía aporte", code == 201, str(r))
    cid = r["id"]
    code, r = student.call("GET", f"/api/contents/{cid}")
    e = json.loads(r["extra"]); check("aporte conserva extra y media", e.get("team") == "Ana, Luis" and len(e["media"]) == 1 and r["protagonist"] == "Laura Pineda, Carlos Pérez", str(e))
    code, r = anon.call("GET", "/api/contents"); check("en revisión no es público", all(i["id"] != cid for i in r))
    code, r = admin.call("GET", "/api/contents?queue=1"); check("administrador ve la bandeja", any(i["id"] == cid for i in r))
    code, r = admin.call("POST", f"/api/contents/{cid}", {"action": "publish"}); check("publicar exige checklist", code == 400, str(r))
    code, r = admin.call("POST", f"/api/contents/{cid}", {"action": "return"}); check("devolver exige observación", code == 400)
    code, r = admin.call("POST", f"/api/contents/{cid}", {"action": "return", "note": "Falta la fuente completa"}); check("devolver con observaciones", code == 200 and r["status"] == "requiere_ajustes")
    code, r = student.call("GET", f"/api/contents/{cid}"); check("autor ve la observación", r["note"] == "Falta la fuente completa")
    code, r = student.call("POST", f"/api/contents/{cid}", {**nuevo, "source": "Fuente completa", "action": "submit"}); check("autor corrige y reenvía", code == 200 and r["status"] == "en_revision", str(r))
    ok = {k: True for k in ("accuracy", "duplicates", "metadata", "accessibility", "rights_check", "relevance")}
    code, r = admin.call("POST", f"/api/contents/{cid}", {"action": "publish", **ok}); check("administrador publica", code == 200 and r["status"] == "publicado", str(r))
    code, r = anon.call("GET", "/api/contents"); check("ahora es público (48)", len(r) == 48)
    code, r = anon.call("GET", "/api/stats"); check("estadísticas", r.get("proyecto") == 8 and sum(r.values()) == 48, str(r))
    code, r = student.call("GET", f"/api/history?id={cid}"); check("historial del aporte", code == 200 and len(r) >= 4 and r[0]["actor"], str(len(r)))
    code, r = admin.call("GET", "/api/audit"); check("bitácora", code == 200 and r and "estado_nuevo" in r[0])

    code, r = student.call("POST", "/api/comments", {"content_id": cid, "body": "Muy bueno"}); check("comentar", code == 201)
    code, r = anon.call("GET", f"/api/comments?content_id={cid}"); check("comentario pendiente oculto al público", r == [])
    code, r = admin.call("GET", "/api/moderation"); check("moderación lista pendiente", len(r) == 1)
    code, _ = admin.call("POST", "/api/moderation", {"id": r[0]["id"], "status": "aprobado"})
    code, r = anon.call("GET", f"/api/comments?content_id={cid}"); check("comentario aprobado visible", len(r) == 1 and r[0]["name"])
    code, r = student.call("POST", "/api/favorites", {"content_id": cid}); check("favorito", r.get("saved") is True)
    code, r = student.call("GET", "/api/favorites"); check("lista de favoritos", len(r) == 1)
    code, _ = student.call("POST", "/api/reactions", {"content_id": cid, "emoji": "👏"})
    code, r = student.call("GET", f"/api/reactions?content_id={cid}"); check("reacción", r["mine"] == "👏" and r["counts"]["👏"] == 1)
    code, r = admin.call("GET", "/api/notifications"); check("notificaciones al administrador", code == 200 and len(r) >= 2)
    code, r = student.call("GET", "/api/notifications"); check("notificación al autor", any("publicado" in n["message"] for n in r))

    code, r = anon.call("POST", "/api/register", {"name": "Nuevo Usuario", "email": "nuevo@unilibre.edu.co", "password": "Clave1234", "consent": True}); check("registro", code == 201, str(r))
    code, r = anon.call("POST", "/api/register", {"name": "Nuevo Usuario", "email": "nuevo@unilibre.edu.co", "password": "Clave1234", "consent": True}); check("registro duplicado", code == 409, str(r))
    code, r = anon.call("POST", "/api/register", {"name": "X", "email": "x@gmail.com", "password": "Clave1234", "consent": True}); check("correo no institucional", code == 400)
    code, r = anon.call("POST", "/api/login", {"email": "nuevo@unilibre.edu.co", "password": "Clave1234"}); check("pendiente informa espera (RF-36)", code == 401 and "espera" in r["error"], str(r))
    code, users = admin.call("GET", "/api/users"); nid = [u for u in users if u["email"] == "nuevo@unilibre.edu.co"][0]["id"]
    code, _ = admin.call("POST", "/api/users", {"id": nid, "role": "docente", "active": True}); check("aprobar usuario", code == 200)
    code, _ = anon.call("POST", "/api/login", {"email": "nuevo@unilibre.edu.co", "password": "Clave1234"}); check("ya puede ingresar", code == 200)
    code, r = admin.call("POST", "/api/users", {"id": 1, "role": "estudiante", "active": True}); check("no quita al último administrador", code == 400, str(r))

    code, r = anon.call("GET", "/api/research"); check("investigación: grupos y semilleros", code == 200 and len(r["groups"]) == 1 and len(r["groups"][0]["seedbeds"]) + len(r["seedbeds_without_group"]) == 3, str(r)[:200])
    linked = [s for g in r["groups"] for s in g["seedbeds"] if s["projects"] or s["research"]]
    check("proyectos vinculados a semilleros", len(linked) >= 1)
    pid = linked[0]["projects"][0]["id"] if linked and linked[0]["projects"] else None
    if pid:
        code, c = admin.call("GET", f"/api/contents/{pid}"); c["title"] += " "
        admin.call("POST", f"/api/contents/{pid}", {**c, "action": "update"})
        code, r2 = anon.call("GET", "/api/research")
        check("editar conserva vínculo con semillero", sum(len(s["projects"]) for g in r2["groups"] for s in g["seedbeds"]) == sum(len(s["projects"]) for g in r["groups"] for s in g["seedbeds"]))
    code, r = student.call("GET", "/api/me"); check("puntos por aporte publicado (registro_puntos)", r.get("points", 0) >= 50 and any(b["name"] == "Primera memoria" for b in r.get("badges", [])), str(r)[:200])
    code, r = Client().call("GET", "/api/ranking"); check("ranking exige sesión", code == 403)
    code, r = student.call("GET", "/api/ranking"); check("ranking ordenado por puntos", code == 200 and len(r) >= 1 and all(r[i]["points"] >= r[i + 1]["points"] for i in range(len(r) - 1)), str(r)[:200])
    code, r = admin.call("POST", f"/api/contents/{cid}", {"action": "archive"}); check("archivar", r["status"] == "archivado")
    code, r = anon.call("GET", f"/api/contents/{cid}"); check("archivado no público", code == 404)
finally:
    srv.terminate(); out = srv.stdout.read()
    if "Traceback" in out: print(out[-1500:]); fails.append("traceback en servidor")
print("\nRESULTADO:", "TODO OK" if not fails else f"{len(fails)} fallas: {fails}")
sys.exit(1 if fails else 0)
