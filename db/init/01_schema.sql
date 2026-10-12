-- =====================================================================
-- Museo Digital Unilibrista · Modelo de datos (MySQL 8)
-- Diagrama ER v2.0 (27 tablas): las 25 del ER v1.0 + 2 extensiones (contenido_versiones, auditoria)
-- Módulo 1: núcleo · Módulo 2: investigación · Módulo 3: comunidad/validación/insignias
-- Las columnas/tablas marcadas "EXTENSIÓN" no están en el ER v1.0: las exigen los requerimientos.
-- Nota: el nombre de la base (museo_digital) está fijo aquí y en 02_seed.sql; debe coincidir con MYSQL_DATABASE del .env.
-- =====================================================================
CREATE DATABASE IF NOT EXISTS museo_digital
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE museo_digital;
SET NAMES utf8mb4;

-- ---------------------- MÓDULO 1: NÚCLEO ------------------------------
CREATE TABLE usuarios (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  nombre          VARCHAR(150) NOT NULL,
  email           VARCHAR(150) NOT NULL UNIQUE,
  password_hash   VARCHAR(255) NOT NULL,
  rol             VARCHAR(20)  NOT NULL DEFAULT 'estudiante',
  estado_registro VARCHAR(20)  NOT NULL DEFAULT 'pendiente',
  activo          TINYINT(1)   NOT NULL DEFAULT 0,
  creado_en       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  vinculacion     VARCHAR(60)  NULL,           -- EXTENSIÓN RF-30: vinculación con el programa
  acepto_datos_en DATETIME     NULL,           -- EXTENSIÓN RF-34: autorización Ley 1581 de 2012
  CONSTRAINT ck_usuarios_rol    CHECK (rol IN ('estudiante','docente','administrador')),
  CONSTRAINT ck_usuarios_estado CHECK (estado_registro IN ('pendiente','aprobado','rechazado')),
  CONSTRAINT ck_usuarios_email  CHECK (email LIKE '%@unilibre.edu.co')   -- RF-31 / RNF-17
) ENGINE=InnoDB;

CREATE TABLE personas (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NULL UNIQUE,                 -- una persona puede ser (o no) usuaria
  nombres    VARCHAR(100) NOT NULL,
  apellidos  VARCHAR(100) NOT NULL DEFAULT '',
  categoria  VARCHAR(30)  NOT NULL,           -- docente, estudiante, egresado, pionero
  foto       VARCHAR(255) NULL,
  CONSTRAINT fk_personas_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL,
  CONSTRAINT ck_personas_cat CHECK (categoria IN ('docente','estudiante','egresado','pionero','otro'))
) ENGINE=InnoDB;

CREATE TABLE categorias (
  id     INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE etiquetas (
  id     INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(60) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE contenidos (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  autor_id       INT NOT NULL,
  categoria_id   INT NOT NULL,
  tipo           VARCHAR(20)  NOT NULL,
  titulo         VARCHAR(200) NOT NULL,
  descripcion    TEXT NOT NULL,
  anio           INT NOT NULL,
  fuente         VARCHAR(500) NOT NULL,
  derechos_autor TINYINT(1)   NOT NULL DEFAULT 0,
  estado         VARCHAR(20)  NOT NULL DEFAULT 'borrador',
  creado_en      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_cont_autor FOREIGN KEY (autor_id)     REFERENCES usuarios(id),
  CONSTRAINT fk_cont_cat   FOREIGN KEY (categoria_id) REFERENCES categorias(id),
  CONSTRAINT ck_cont_tipo   CHECK (tipo IN ('acontecimiento','proyecto','investigacion','premio','persona','evento','galeria')),
  CONSTRAINT ck_cont_estado CHECK (estado IN ('borrador','en_revision','requiere_ajustes','aprobado','publicado','archivado')),
  INDEX idx_cont_estado_tipo (estado, tipo),
  INDEX idx_cont_anio (anio),
  FULLTEXT INDEX ft_cont_busqueda (titulo, descripcion)   -- RF-16 búsqueda por palabra clave
) ENGINE=InnoDB;

-- Subtipos (1:1 con contenidos, comparten la PK)
CREATE TABLE acontecimientos (
  contenido_id INT PRIMARY KEY,
  fecha        DATE NULL,
  tipo_hito    VARCHAR(20) NOT NULL DEFAULT 'hito',    -- hito, investigacion, logro, premio (RF-08)
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE premios (
  contenido_id       INT PRIMARY KEY,
  entidad_otorgante  VARCHAR(150) NULL,
  lugar              VARCHAR(150) NULL,
  fecha              DATE NULL,
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE eventos (
  contenido_id INT PRIMARY KEY,
  fecha_inicio DATETIME NULL,
  fecha_fin    DATETIME NULL,
  fecha_texto  VARCHAR(80) NULL,               -- EXTENSIÓN: fecha tal como se muestra ("18 – 22 ago 2026")
  lugar        VARCHAR(150) NULL,
  objetivo     TEXT NULL,
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE hall_fama (
  contenido_id INT PRIMARY KEY,
  persona_id   INT NULL,
  biografia    TEXT NULL,
  logros       TEXT NULL,
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE,
  FOREIGN KEY (persona_id)   REFERENCES personas(id)   ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE evidencias (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  contenido_id INT NOT NULL,
  tipo         VARCHAR(20)  NOT NULL DEFAULT 'imagen',   -- imagen, video, documento
  url          VARCHAR(500) NOT NULL,
  credito      VARCHAR(255) NOT NULL,                    -- RF-48: obligatorio
  texto_alt    VARCHAR(255) NOT NULL,                    -- RF-48: obligatorio
  orden        INT NOT NULL DEFAULT 1,
  autorizado   TINYINT(1) NOT NULL DEFAULT 0,  -- EXTENSIÓN RF-48/RNF-19: autorización de uso
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE,
  CONSTRAINT ck_evid_tipo CHECK (tipo IN ('imagen','video','documento'))
) ENGINE=InnoDB;

CREATE TABLE participaciones (            -- N:M contenidos ↔ personas (protagonistas)
  contenido_id INT NOT NULL,
  persona_id   INT NOT NULL,
  rol          VARCHAR(60) NULL,               -- protagonista, participante, integrante, autor
  orden        INT NOT NULL DEFAULT 1,         -- EXTENSIÓN: orden de aparición
  PRIMARY KEY (contenido_id, persona_id),
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE,
  FOREIGN KEY (persona_id)   REFERENCES personas(id)   ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE contenido_etiquetas (        -- N:M contenidos ↔ etiquetas
  contenido_id INT NOT NULL,
  etiqueta_id  INT NOT NULL,
  PRIMARY KEY (contenido_id, etiqueta_id),
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE,
  FOREIGN KEY (etiqueta_id)  REFERENCES etiquetas(id)  ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------- MÓDULO 2: INVESTIGACIÓN --------------------------
CREATE TABLE grupos_investigacion (
  id                 INT AUTO_INCREMENT PRIMARY KEY,
  lider_id           INT NULL,
  nombre             VARCHAR(150) NOT NULL UNIQUE,
  codigo_minciencias VARCHAR(30)  NULL UNIQUE,
  categoria          VARCHAR(10)  NULL,
  linea_principal    VARCHAR(200) NULL,
  FOREIGN KEY (lider_id) REFERENCES personas(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE semilleros (
  id                 INT AUTO_INCREMENT PRIMARY KEY,
  grupo_id           INT NULL,
  coordinador_id     INT NULL,
  nombre             VARCHAR(150) NOT NULL UNIQUE,
  descripcion        TEXT NULL,
  linea_investigacion VARCHAR(200) NULL,
  anio_creacion      INT NULL,
  logo               VARCHAR(255) NULL,
  estado             VARCHAR(20) NOT NULL DEFAULT 'activo',
  FOREIGN KEY (grupo_id)       REFERENCES grupos_investigacion(id) ON DELETE SET NULL,
  FOREIGN KEY (coordinador_id) REFERENCES personas(id)             ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE semillero_miembros (
  semillero_id  INT NOT NULL,
  persona_id    INT NOT NULL,
  rol           VARCHAR(60) NULL,
  fecha_ingreso DATE NULL,
  fecha_salida  DATE NULL,
  PRIMARY KEY (semillero_id, persona_id),
  FOREIGN KEY (semillero_id) REFERENCES semilleros(id) ON DELETE CASCADE,
  FOREIGN KEY (persona_id)   REFERENCES personas(id)   ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE proyectos (
  contenido_id        INT PRIMARY KEY,
  semillero_id        INT NULL,
  linea_investigacion VARCHAR(200) NULL,
  tecnologias         VARCHAR(300) NULL,
  resultados          TEXT NULL,
  impacto             TEXT NULL,
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE,
  FOREIGN KEY (semillero_id) REFERENCES semilleros(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE investigaciones (
  contenido_id    INT PRIMARY KEY,
  semillero_id    INT NULL,
  grupo_id        INT NULL,
  tipo            VARCHAR(30) NOT NULL,        -- publicación, patente, software
  doi_o_registro  VARCHAR(150) NULL,
  impacto         TEXT NULL,
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id)           ON DELETE CASCADE,
  FOREIGN KEY (semillero_id) REFERENCES semilleros(id)           ON DELETE SET NULL,
  FOREIGN KEY (grupo_id)     REFERENCES grupos_investigacion(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- --------- MÓDULO 3: COMUNIDAD, VALIDACIÓN Y GAMIFICACIÓN -------------
CREATE TABLE validaciones (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  contenido_id  INT NOT NULL,
  usuario_id    INT NOT NULL,                  -- quien revisa
  accion        VARCHAR(30) NOT NULL,          -- enviar, devolver, aprobar, publicar, archivar...
  observaciones TEXT NULL,
  fecha         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE,
  FOREIGN KEY (usuario_id)   REFERENCES usuarios(id)
) ENGINE=InnoDB;

CREATE TABLE comentarios (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id   INT NOT NULL,
  contenido_id INT NOT NULL,
  cuerpo       TEXT NOT NULL,
  estado       VARCHAR(20) NOT NULL DEFAULT 'pendiente',   -- pendiente, aprobado, oculto
  fecha        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id)   REFERENCES usuarios(id)   ON DELETE CASCADE,
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE,
  CONSTRAINT ck_com_estado CHECK (estado IN ('pendiente','aprobado','oculto'))
) ENGINE=InnoDB;

CREATE TABLE reacciones (
  usuario_id   INT NOT NULL,
  contenido_id INT NOT NULL,
  tipo         VARCHAR(20) NOT NULL,
  fecha        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, contenido_id),       -- RF-41: una reacción por usuario y contenido
  FOREIGN KEY (usuario_id)   REFERENCES usuarios(id)   ON DELETE CASCADE,
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE favoritos (
  usuario_id   INT NOT NULL,
  contenido_id INT NOT NULL,
  fecha        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, contenido_id),
  FOREIGN KEY (usuario_id)   REFERENCES usuarios(id)   ON DELETE CASCADE,
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE notificaciones (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id   INT NOT NULL,
  contenido_id INT NULL,
  mensaje      VARCHAR(300) NOT NULL,
  leida        TINYINT(1) NOT NULL DEFAULT 0,
  fecha        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id)   REFERENCES usuarios(id)   ON DELETE CASCADE,
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE registro_puntos (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  accion     VARCHAR(60) NOT NULL,
  puntos     INT NOT NULL,
  fecha      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE insignias (
  id                INT AUTO_INCREMENT PRIMARY KEY,
  nombre            VARCHAR(80) NOT NULL UNIQUE,
  descripcion       VARCHAR(255) NULL,
  puntos_requeridos INT NOT NULL DEFAULT 0,
  icono             VARCHAR(60) NULL
) ENGINE=InnoDB;

CREATE TABLE usuario_insignias (
  usuario_id  INT NOT NULL,
  insignia_id INT NOT NULL,
  obtenida_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, insignia_id),
  FOREIGN KEY (usuario_id)  REFERENCES usuarios(id)  ON DELETE CASCADE,
  FOREIGN KEY (insignia_id) REFERENCES insignias(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------- EXTENSIONES (requerimientos) ---------------------
-- RF-67: una versión con autor, fecha, estado y observaciones en cada cambio
CREATE TABLE contenido_versiones (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  contenido_id  INT NOT NULL,
  autor_id      INT NOT NULL,
  numero        INT NOT NULL,
  estado        VARCHAR(20) NOT NULL,
  snapshot      JSON NOT NULL,
  observaciones TEXT NULL,
  fecha         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_version (contenido_id, numero),
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE CASCADE,
  FOREIGN KEY (autor_id)     REFERENCES usuarios(id)
) ENGINE=InnoDB;

-- RF-64: bitácora de solo lectura (usuario, acción, contenido, estado anterior y nuevo)
CREATE TABLE auditoria (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id      INT NOT NULL,
  contenido_id    INT NULL,
  accion          VARCHAR(60) NOT NULL,
  estado_anterior VARCHAR(20) NULL,
  estado_nuevo    VARCHAR(20) NULL,
  nota            VARCHAR(1000) NULL,
  fecha           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id)   REFERENCES usuarios(id),
  FOREIGN KEY (contenido_id) REFERENCES contenidos(id) ON DELETE SET NULL
) ENGINE=InnoDB;
