# Museo Digital Unilibrista — Segundo corte

Aplicación web (HTML/CSS/JS + servidor Python) con base de datos **MySQL** de 27 tablas, empaquetada con **Docker**.

## 1. Estructura del proyecto
```
museo-segundo-corte/
├── app/                      Aplicación
│   ├── server.py             API y servidor web (rutas, permisos, reglas del flujo editorial)
│   ├── repo.py               Capa de datos: lee/escribe en las 27 tablas
│   ├── db.py                 Conexión (MySQL en Docker, SQLite en modo local) y creación del esquema
│   ├── requirements.txt      Librerías de Python (PyMySQL)
│   └── public/               Interfaz (HTML, CSS y JavaScript)
│       ├── index.html, style.css   Página base y estilos generales
│       ├── app.js                  Núcleo: conexión con la API, tarjetas, buscador y rutas
│       ├── inicio.js               V01 Inicio (portada, línea del tiempo, secciones)
│       ├── acceso.js               V06 Acceso (login y registro)
│       └── vistas.js, vistas.css   V02–V05 y V07–V14 (búsqueda, detalle, investigación, galería, panel, aportes, perfil, validación, administración)
├── db/init/                  Scripts de MySQL (Docker los ejecuta solos la primera vez)
│   ├── 01_schema.sql         Las 27 tablas del diagrama ER + extensiones marcadas
│   └── 02_seed.sql           Datos de prueba: contenidos del prototipo con sus fotos
├── tests/prueba_api.py       Prueba de punta a punta (login, aportes, validación, comentarios…)
├── tools/crear_seed.py       Regenera 02_seed.sql
├── Dockerfile                Receta de la imagen de la aplicación
├── docker-compose.yml        app + MySQL + Adminer
├── .env.example              Variables (claves) — copiar a .env
└── README.md
```

## 2. Cómo ejecutarlo
**Con Docker (entorno completo con MySQL)**
```
cp .env.example .env          # en Windows: copy .env.example .env
docker compose up --build
```
- Museo: http://localhost:8000
- Adminer (ver tablas): http://localhost:8080 → sistema **MySQL**, servidor **db**, usuario y clave del `.env`, base **museo_digital**
- Apagar: `docker compose down` · Borrar los datos y empezar de cero: `docker compose down -v`

**Sin Docker (modo local rápido, SQLite con el mismo esquema)**
```
cd app
python server.py              # http://localhost:8000
```
Cuentas demo: admin@unilibre.edu.co · docente@unilibre.edu.co · estudiante@unilibre.edu.co (clave `Museo2026!`).

**Pruebas:** `python tests/prueba_api.py` (usa una base SQLite temporal y verifica ~40 comportamientos).

## 3. Docker en simple
- **Imagen**: caja con Python + el código (receta: `Dockerfile`). **Contenedor**: esa caja encendida.
- `docker-compose.yml` define tres contenedores: `db` (MySQL, crea las tablas con `db/init`), `web` (la aplicación) y `adminer` (visor de la base).
- **Volumen** `museo_mysql`: guarda los datos aunque apagues todo. **.env**: claves fuera del código.

## 4. Modelo de datos
25 tablas del ER v1.0 (más 2 de la v2.0: contenido_versiones y auditoria): usuarios, personas, categorias, etiquetas, contenidos, acontecimientos, premios, eventos,
hall_fama, evidencias, participaciones, contenido_etiquetas, grupos_investigacion, semilleros, semillero_miembros,
proyectos, investigaciones, validaciones, comentarios, reacciones, favoritos, notificaciones, registro_puntos,
insignias, usuario_insignias.

El diagrama ER v2.0 se entrega aparte y coincide con `01_schema.sql`.
**Extensiones que exigen los requerimientos respecto al ER v1.0 (marcadas con ★ en el diagrama):**
| Extensión | Requerimiento |
|---|---|
| tabla `contenido_versiones` | RF-55, RF-67 historial de versiones |
| tabla `auditoria` (estado anterior/nuevo, nota) | RF-64 bitácora |
| `usuarios.vinculacion`, `usuarios.acepto_datos_en` | RF-30, RF-34, RNF-19 |
| `evidencias.autorizado` | RF-48 autorización de uso por archivo |
| `eventos.fecha_texto` | RF-12 (fecha tal como se muestra) |
| `participaciones.orden` y papeles combinados (`protagonista,integrante`) | RF-20, RF-24 |
| `personas.categoria = 'otro'` | protagonistas que no son docentes/estudiantes/egresados/pioneros |

## 5. Coherencia requerimientos ↔ base de datos ↔ interfaces
| Requerimientos | Tablas | Interfaz (primer corte) |
|---|---|---|
| RF-01–15 portada, línea de tiempo, premios, Hall, eventos, cifras | contenidos + acontecimientos, premios, eventos, hall_fama, personas, evidencias | V01 Inicio |
| RF-16–29 búsqueda, filtros, detalle, galería | contenidos, categorias, etiquetas, contenido_etiquetas, participaciones, evidencias | V02 Búsqueda, V03 Detalle, V05 Galería |
| RF-28 investigación | grupos_investigacion, semilleros, semillero_miembros, proyectos, investigaciones | V04 Investigación |
| RF-30–39 registro, login, roles | usuarios | V06 Login |
| Gamificación: puntos (50 por aporte publicado), insignias, niveles y ranking | registro_puntos, insignias, usuario_insignias | V10 Perfil |
| RF-40–43 comentarios, reacciones, favoritos, notificaciones | comentarios, reacciones, favoritos, notificaciones | V03, V07, V10 |
| RF-44–53 aportes | contenidos + subtipos, evidencias, contenido_versiones | V07 Panel, V08 Formulario, V09 Mis aportes, V10 Perfil |
| RF-54–64 validación y administración | validaciones, comentarios, usuarios, auditoria | V11 Bandeja, V12 Revisión, V13 Dashboard, V14 Usuarios |
| RF-65–68 comportamiento automático | consultas sobre estado = 'publicado', auditoria | — |

## 6. Notas
- `docker compose up --build` probado con MySQL 8.4 en Docker Desktop (27 tablas cargadas, lectura y escritura).
- El nombre de la base (`museo_digital`) está en `01_schema.sql` y `02_seed.sql`; si cambias `MYSQL_DATABASE` en el `.env`, cámbialo también ahí.
- `grupos_investigacion`, `semilleros` y `semillero_miembros` ya tienen datos (1 grupo, 3 semilleros, 5 integrantes,
  proyectos e investigaciones vinculados) y se consultan en `GET /api/research`. La vista V04 (Investigación) los muestra.
- Tecnologías: HTML, CSS, JavaScript y Python, las permitidas por el profesor para este corte. El prototipo en React del primer corte fue la guía visual.
