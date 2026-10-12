-- Datos de prueba (generado por tools/crear_seed.py). No editar a mano.
USE museo_digital;
SET NAMES utf8mb4;

-- usuarios: 4 filas
INSERT INTO usuarios (id,nombre,email,password_hash,rol,estado_registro,activo,creado_en,vinculacion,acepto_datos_en) VALUES (1,'Coordinación del Museo','admin@unilibre.edu.co','7cdb9a3a4380bb14fc902932d5785c8b$a1a70ae3c960664d08c7f870ba49d0812e72bcf013cd2d634ba0c0271e7cc35d','administrador','aprobado',1,'2026-10-12 08:43:06',NULL,'2026-10-12 08:43:06');
INSERT INTO usuarios (id,nombre,email,password_hash,rol,estado_registro,activo,creado_en,vinculacion,acepto_datos_en) VALUES (2,'Ing. Camila Morales','docente@unilibre.edu.co','fc1d29fd424ef61c71c3fe03b2c26d0c$bd29ed913f362d0b8573e4c484cf1a22cc92bd9bf3731dd929614b6bcb1025d5','docente','aprobado',1,'2026-10-12 08:43:06',NULL,'2026-10-12 08:43:06');
INSERT INTO usuarios (id,nombre,email,password_hash,rol,estado_registro,activo,creado_en,vinculacion,acepto_datos_en) VALUES (3,'Laura Pineda','estudiante@unilibre.edu.co','7e19663f7b70cf3b10c6c060b05e0ebc$e2e61cbbe63b04c3b2d82933a092c8c990ae61536301f4c456078e5c1a9f4c69','estudiante','aprobado',1,'2026-10-12 08:43:06',NULL,'2026-10-12 08:43:06');
INSERT INTO usuarios (id,nombre,email,password_hash,rol,estado_registro,activo,creado_en,vinculacion,acepto_datos_en) VALUES (4,'Maicol Elias Osorio','maicole-osorioc@unilibre.edu.co','1fb8acbed4b04d6595707d5b159196ba$489554c4b7e7d10c884bd8a56b8d038211076020486b69dd152f3cfa406526b4','estudiante','pendiente',0,'2026-10-12 08:43:06',NULL,'2026-10-12 08:43:06');

-- categorias: 33 filas
INSERT INTO categorias (id,nombre) VALUES (1,'Memoria');
INSERT INTO categorias (id,nombre) VALUES (2,'Innovación');
INSERT INTO categorias (id,nombre) VALUES (3,'Investigación');
INSERT INTO categorias (id,nombre) VALUES (4,'Reconocimientos');
INSERT INTO categorias (id,nombre) VALUES (5,'Comunidad');
INSERT INTO categorias (id,nombre) VALUES (6,'Eventos');
INSERT INTO categorias (id,nombre) VALUES (7,'Hito Histórico');
INSERT INTO categorias (id,nombre) VALUES (8,'Logro Institucional');
INSERT INTO categorias (id,nombre) VALUES (9,'Premio');
INSERT INTO categorias (id,nombre) VALUES (10,'Software Institucional');
INSERT INTO categorias (id,nombre) VALUES (11,'Inteligencia Artificial');
INSERT INTO categorias (id,nombre) VALUES (12,'Desarrollo Móvil');
INSERT INTO categorias (id,nombre) VALUES (13,'Internet de las Cosas');
INSERT INTO categorias (id,nombre) VALUES (14,'Educación y Accesibilidad');
INSERT INTO categorias (id,nombre) VALUES (15,'Seguridad Informática');
INSERT INTO categorias (id,nombre) VALUES (16,'Competencia Nacional');
INSERT INTO categorias (id,nombre) VALUES (17,'Congreso Académico');
INSERT INTO categorias (id,nombre) VALUES (18,'Reconocimiento Nacional');
INSERT INTO categorias (id,nombre) VALUES (19,'Distinción Académica');
INSERT INTO categorias (id,nombre) VALUES (20,'Docente');
INSERT INTO categorias (id,nombre) VALUES (21,'Egresada');
INSERT INTO categorias (id,nombre) VALUES (22,'Estudiante');
INSERT INTO categorias (id,nombre) VALUES (23,'Investigador');
INSERT INTO categorias (id,nombre) VALUES (24,'Egresado');
INSERT INTO categorias (id,nombre) VALUES (25,'Evento Académico');
INSERT INTO categorias (id,nombre) VALUES (26,'Competencia');
INSERT INTO categorias (id,nombre) VALUES (27,'Ceremonial');
INSERT INTO categorias (id,nombre) VALUES (28,'Grupo de Investigación');
INSERT INTO categorias (id,nombre) VALUES (29,'Semillero');
INSERT INTO categorias (id,nombre) VALUES (30,'Patente de Software');
INSERT INTO categorias (id,nombre) VALUES (31,'Publicación Científica');
INSERT INTO categorias (id,nombre) VALUES (32,'Noticia');
INSERT INTO categorias (id,nombre) VALUES (33,'Reconocimiento Académico');

-- personas: 50 filas
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (1,NULL,'Comunidad académica','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (2,NULL,'Semillero de estudiantes','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (3,NULL,'Docentes y estudiantes','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (4,NULL,'Equipo del programa','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (5,NULL,'Egresados y docentes','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (6,NULL,'Dr. Fernando Espinosa','','docente',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (7,NULL,'Dr. Héctor Villanueva','','pionero',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (8,NULL,'Ing. Roberto Leal','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (9,NULL,'Consejo de Facultad','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (10,NULL,'Comité de Acreditación','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (11,NULL,'Sebastián Vargas','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (12,NULL,'Diana Torres','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (13,NULL,'Miguel Ángel Suárez','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (14,NULL,'Decanatura de Ingeniería','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (15,NULL,'Ing. Camila Morales','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (16,NULL,'Est. Alejandro Herrera','','estudiante',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (17,NULL,'Carlos Eduardo Ruiz','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (18,NULL,'Junta Directiva Universidad Libre','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (19,NULL,'Rectoría Universidad Libre','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (20,NULL,'Ana Rodríguez','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (21,NULL,'Carlos Méndez','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (22,NULL,'Julián Ospina','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (23,NULL,'Valentina Cruz','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (24,NULL,'Laura Pineda','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (25,NULL,'Tomás Gutiérrez','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (26,NULL,'María José Castillo','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (27,NULL,'Andrés Pedraza','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (28,NULL,'Daniela Suárez','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (29,NULL,'Felipe Montoya','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (30,NULL,'Paula Jiménez','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (31,NULL,'Dr. Roberto Leal','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (32,NULL,'Grupo GISI','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (33,NULL,'Ing. Marcela Rondón','','egresado',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (34,NULL,'Ing. Ricardo Pardo','','egresado',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (35,NULL,'Dra. Patricia Salazar','','docente',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (36,NULL,'Dirección del Programa','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (37,NULL,'Consejo Estudiantil','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (38,NULL,'Semillero de Innovación Digital','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (39,NULL,'Empresas patrocinadoras','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (40,NULL,'Docentes del Programa','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (41,NULL,'Rector Universidad Libre','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (42,NULL,'Directora del Programa','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (43,NULL,'94 nuevos ingenieros','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (44,NULL,'MinCiencias','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (45,NULL,'Forbes Colombia','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (46,NULL,'Semillero SeedAI','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (47,NULL,'OEA','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (48,NULL,'Andrés Felipe Cárdenas','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (49,NULL,'Natalia Bermúdez','','otro',NULL);
INSERT INTO personas (id,usuario_id,nombres,apellidos,categoria,foto) VALUES (50,NULL,'Ing. Santiago Montoya','','egresado',NULL);

-- etiquetas: 130 filas
INSERT INTO etiquetas (id,nombre) VALUES (1,'origen');
INSERT INTO etiquetas (id,nombre) VALUES (2,'programa');
INSERT INTO etiquetas (id,nombre) VALUES (3,'tecnología');
INSERT INTO etiquetas (id,nombre) VALUES (4,'innovación');
INSERT INTO etiquetas (id,nombre) VALUES (5,'investigación');
INSERT INTO etiquetas (id,nombre) VALUES (6,'software');
INSERT INTO etiquetas (id,nombre) VALUES (7,'premio');
INSERT INTO etiquetas (id,nombre) VALUES (8,'comunidad');
INSERT INTO etiquetas (id,nombre) VALUES (9,'egresados');
INSERT INTO etiquetas (id,nombre) VALUES (10,'historia');
INSERT INTO etiquetas (id,nombre) VALUES (11,'evento');
INSERT INTO etiquetas (id,nombre) VALUES (12,'proyectos');
INSERT INTO etiquetas (id,nombre) VALUES (13,'fundación');
INSERT INTO etiquetas (id,nombre) VALUES (14,'semillero');
INSERT INTO etiquetas (id,nombre) VALUES (15,'IA');
INSERT INTO etiquetas (id,nombre) VALUES (16,'bases de datos');
INSERT INTO etiquetas (id,nombre) VALUES (17,'acreditación');
INSERT INTO etiquetas (id,nombre) VALUES (18,'calidad');
INSERT INTO etiquetas (id,nombre) VALUES (19,'ministerio');
INSERT INTO etiquetas (id,nombre) VALUES (20,'logro');
INSERT INTO etiquetas (id,nombre) VALUES (21,'robótica');
INSERT INTO etiquetas (id,nombre) VALUES (22,'olimpiada');
INSERT INTO etiquetas (id,nombre) VALUES (23,'nacional');
INSERT INTO etiquetas (id,nombre) VALUES (24,'laboratorio');
INSERT INTO etiquetas (id,nombre) VALUES (25,'VR');
INSERT INTO etiquetas (id,nombre) VALUES (26,'patente');
INSERT INTO etiquetas (id,nombre) VALUES (27,'GISI');
INSERT INTO etiquetas (id,nombre) VALUES (28,'SIC');
INSERT INTO etiquetas (id,nombre) VALUES (29,'graduación');
INSERT INTO etiquetas (id,nombre) VALUES (30,'hito');
INSERT INTO etiquetas (id,nombre) VALUES (31,'reacreditación');
INSERT INTO etiquetas (id,nombre) VALUES (32,'internacional');
INSERT INTO etiquetas (id,nombre) VALUES (33,'MEN');
INSERT INTO etiquetas (id,nombre) VALUES (34,'gestión académica');
INSERT INTO etiquetas (id,nombre) VALUES (35,'React');
INSERT INTO etiquetas (id,nombre) VALUES (36,'web');
INSERT INTO etiquetas (id,nombre) VALUES (37,'institucional');
INSERT INTO etiquetas (id,nombre) VALUES (38,'visión por computador');
INSERT INTO etiquetas (id,nombre) VALUES (39,'salud');
INSERT INTO etiquetas (id,nombre) VALUES (40,'CNN');
INSERT INTO etiquetas (id,nombre) VALUES (41,'IEEE');
INSERT INTO etiquetas (id,nombre) VALUES (42,'movilidad');
INSERT INTO etiquetas (id,nombre) VALUES (43,'Flutter');
INSERT INTO etiquetas (id,nombre) VALUES (44,'sostenibilidad');
INSERT INTO etiquetas (id,nombre) VALUES (45,'Bogotá');
INSERT INTO etiquetas (id,nombre) VALUES (46,'app');
INSERT INTO etiquetas (id,nombre) VALUES (47,'IoT');
INSERT INTO etiquetas (id,nombre) VALUES (48,'ambiental');
INSERT INTO etiquetas (id,nombre) VALUES (49,'Arduino');
INSERT INTO etiquetas (id,nombre) VALUES (50,'sensores');
INSERT INTO etiquetas (id,nombre) VALUES (51,'IDEAM');
INSERT INTO etiquetas (id,nombre) VALUES (52,'accesibilidad');
INSERT INTO etiquetas (id,nombre) VALUES (53,'e-learning');
INSERT INTO etiquetas (id,nombre) VALUES (54,'inclusión');
INSERT INTO etiquetas (id,nombre) VALUES (55,'WCAG');
INSERT INTO etiquetas (id,nombre) VALUES (56,'LSC');
INSERT INTO etiquetas (id,nombre) VALUES (57,'seguridad');
INSERT INTO etiquetas (id,nombre) VALUES (58,'fraude');
INSERT INTO etiquetas (id,nombre) VALUES (59,'ML');
INSERT INTO etiquetas (id,nombre) VALUES (60,'grafos');
INSERT INTO etiquetas (id,nombre) VALUES (61,'primer lugar');
INSERT INTO etiquetas (id,nombre) VALUES (62,'UNAL');
INSERT INTO etiquetas (id,nombre) VALUES (63,'ponencia');
INSERT INTO etiquetas (id,nombre) VALUES (64,'ACIS');
INSERT INTO etiquetas (id,nombre) VALUES (65,'educación');
INSERT INTO etiquetas (id,nombre) VALUES (66,'MinCiencias');
INSERT INTO etiquetas (id,nombre) VALUES (67,'social');
INSERT INTO etiquetas (id,nombre) VALUES (68,'laureado');
INSERT INTO etiquetas (id,nombre) VALUES (69,'distinción');
INSERT INTO etiquetas (id,nombre) VALUES (70,'fundador');
INSERT INTO etiquetas (id,nombre) VALUES (71,'docente');
INSERT INTO etiquetas (id,nombre) VALUES (72,'liderazgo');
INSERT INTO etiquetas (id,nombre) VALUES (73,'egresada');
INSERT INTO etiquetas (id,nombre) VALUES (74,'fintech');
INSERT INTO etiquetas (id,nombre) VALUES (75,'CTO');
INSERT INTO etiquetas (id,nombre) VALUES (76,'transformación digital');
INSERT INTO etiquetas (id,nombre) VALUES (77,'estudiante');
INSERT INTO etiquetas (id,nombre) VALUES (78,'MIT');
INSERT INTO etiquetas (id,nombre) VALUES (79,'hackathon');
INSERT INTO etiquetas (id,nombre) VALUES (80,'destacado');
INSERT INTO etiquetas (id,nombre) VALUES (81,'investigador');
INSERT INTO etiquetas (id,nombre) VALUES (82,'pionero');
INSERT INTO etiquetas (id,nombre) VALUES (83,'publicaciones');
INSERT INTO etiquetas (id,nombre) VALUES (84,'egresado');
INSERT INTO etiquetas (id,nombre) VALUES (85,'emprendimiento');
INSERT INTO etiquetas (id,nombre) VALUES (86,'EdTech');
INSERT INTO etiquetas (id,nombre) VALUES (87,'Y Combinator');
INSERT INTO etiquetas (id,nombre) VALUES (88,'Fulbright');
INSERT INTO etiquetas (id,nombre) VALUES (89,'computación afectiva');
INSERT INTO etiquetas (id,nombre) VALUES (90,'mujer STEM');
INSERT INTO etiquetas (id,nombre) VALUES (91,'semana de la ingeniería');
INSERT INTO etiquetas (id,nombre) VALUES (92,'conferencias');
INSERT INTO etiquetas (id,nombre) VALUES (93,'talleres');
INSERT INTO etiquetas (id,nombre) VALUES (94,'feria de proyectos');
INSERT INTO etiquetas (id,nombre) VALUES (95,'competencia');
INSERT INTO etiquetas (id,nombre) VALUES (96,'LibreCode');
INSERT INTO etiquetas (id,nombre) VALUES (97,'48 horas');
INSERT INTO etiquetas (id,nombre) VALUES (98,'congreso');
INSERT INTO etiquetas (id,nombre) VALUES (99,'estudiantes');
INSERT INTO etiquetas (id,nombre) VALUES (100,'ponencias');
INSERT INTO etiquetas (id,nombre) VALUES (101,'realizado');
INSERT INTO etiquetas (id,nombre) VALUES (102,'2025');
INSERT INTO etiquetas (id,nombre) VALUES (103,'grado');
INSERT INTO etiquetas (id,nombre) VALUES (104,'ceremonia');
INSERT INTO etiquetas (id,nombre) VALUES (105,'A1');
INSERT INTO etiquetas (id,nombre) VALUES (106,'SeedAI');
INSERT INTO etiquetas (id,nombre) VALUES (107,'primera patente');
INSERT INTO etiquetas (id,nombre) VALUES (108,'publicación');
INSERT INTO etiquetas (id,nombre) VALUES (109,'deserción');
INSERT INTO etiquetas (id,nombre) VALUES (110,'Q1');
INSERT INTO etiquetas (id,nombre) VALUES (111,'noticia');
INSERT INTO etiquetas (id,nombre) VALUES (112,'financiación');
INSERT INTO etiquetas (id,nombre) VALUES (113,'2026');
INSERT INTO etiquetas (id,nombre) VALUES (114,'Forbes');
INSERT INTO etiquetas (id,nombre) VALUES (115,'reconocimiento');
INSERT INTO etiquetas (id,nombre) VALUES (116,'OEA');
INSERT INTO etiquetas (id,nombre) VALUES (117,'paz');
INSERT INTO etiquetas (id,nombre) VALUES (118,'RFID');
INSERT INTO etiquetas (id,nombre) VALUES (119,'inventarios');
INSERT INTO etiquetas (id,nombre) VALUES (120,'biblioteca');
INSERT INTO etiquetas (id,nombre) VALUES (121,'2024');
INSERT INTO etiquetas (id,nombre) VALUES (122,'ciberseguridad');
INSERT INTO etiquetas (id,nombre) VALUES (123,'CCIT');
INSERT INTO etiquetas (id,nombre) VALUES (124,'pymes');
INSERT INTO etiquetas (id,nombre) VALUES (125,'énfasis');
INSERT INTO etiquetas (id,nombre) VALUES (126,'currículo');
INSERT INTO etiquetas (id,nombre) VALUES (127,'inteligencia artificial');
INSERT INTO etiquetas (id,nombre) VALUES (128,'profundización');
INSERT INTO etiquetas (id,nombre) VALUES (129,'LACLO');
INSERT INTO etiquetas (id,nombre) VALUES (130,'mención de honor');

-- contenidos: 51 filas
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (1,1,1,'acontecimiento','Los primeros pasos del programa','Una mirada al origen y la evolución de la formación en ingeniería, reconstruida con aportes de la comunidad.',1976,'Archivo demostrativo; verificar con el programa',1,'publicado','2026-09-28 14:37:57','2026-09-28 14:37:57');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (2,1,2,'proyecto','Laboratorio de innovación estudiantil','Un espacio para crear soluciones tecnológicas a necesidades de la comunidad y compartir aprendizajes.',2023,'Contenido demostrativo',1,'publicado','2026-09-28 14:37:57','2026-09-28 14:37:57');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (3,1,3,'investigacion','Semillero de inteligencia artificial','Exploración colaborativa de aplicaciones responsables de la inteligencia artificial.',2024,'Contenido demostrativo',1,'publicado','2026-09-28 14:37:57','2026-09-28 14:37:57');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (4,1,4,'premio','Reconocimiento a la colaboración académica','Un reconocimiento simbólico al trabajo conjunto de estudiantes y docentes.',2022,'Contenido demostrativo',1,'publicado','2026-09-28 14:37:57','2026-09-28 14:37:57');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (5,1,5,'persona','Voces que hicieron historia','Historias y experiencias de quienes han acompañado el crecimiento del programa.',2021,'Contenido demostrativo',1,'publicado','2026-09-28 14:37:57','2026-09-28 14:37:57');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (6,1,6,'evento','Encuentro de proyectos de aula','Presentación de iniciativas y resultados de aprendizaje ante la comunidad.',2025,'Contenido demostrativo',1,'publicado','2026-09-28 14:37:57','2026-09-28 14:37:57');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (7,1,7,'acontecimiento','Fundación del Programa de Ingeniería de Sistemas','El Programa de Ingeniería de Sistemas de la Universidad Libre abre sus puertas con la primera cohorte de 42 estudiantes. Este hito marca el inicio de una historia de formación tecnológica con impacto social en Bogotá.',1994,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c1]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Archivo Histórico Universidad Libre',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (8,1,3,'acontecimiento','Primer Semillero de Investigación en Sistemas Inteligentes','Se formaliza el primer semillero de investigación del programa, enfocado en inteligencia artificial y bases de datos relacionales. Doce estudiantes y dos docentes conforman el grupo pionero.',2001,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c2]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Registro Académico Universidad Libre',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (9,1,8,'acontecimiento','Acreditación de Alta Calidad — Primera vez','El programa recibe por primera vez la Acreditación de Alta Calidad otorgada por el Ministerio de Educación Nacional, certificando la excelencia académica e investigativa del programa ante la comunidad educativa colombiana.',2007,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c3]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Resolución 2007-MEN-4521',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (10,1,9,'acontecimiento','Primer Lugar — Olimpiada Nacional de Robótica','El equipo "LibreBot" integrado por estudiantes del programa obtiene el primer lugar en la competencia nacional de robótica, con un prototipo de brazo articulado autónomo capaz de clasificar objetos por color y forma.',2012,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c4]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Federación Colombiana de Robótica',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (11,1,7,'acontecimiento','Inauguración del Laboratorio de Innovación Digital','El programa inaugura un laboratorio de 250 m² equipado con estaciones de realidad virtual, impresoras 3D de última generación, equipos de IoT y espacios de trabajo colaborativo para proyectos interdisciplinarios.',2016,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c5]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Acta de Inauguración No. 2016-045',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (12,1,3,'acontecimiento','Primera Patente de Software del Programa','El grupo de investigación GISI registra ante la Superintendencia de Industria y Comercio la primera patente de software del programa: un sistema de detección de fraude financiero basado en redes neuronales convolucionales.',2019,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c6]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: SIC Colombia — Registro de Propiedad Industrial',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (13,1,8,'acontecimiento','Egresado N.° 1000 del Programa','Con la graduación de Carlos Eduardo Ruiz, el programa celebra su egresado número mil. La ceremonia especial contó con la presencia de los primeros graduados de 1998 y autoridades académicas nacionales.',2022,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c7]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Acta de Grado — Consejo Académico 2022',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (14,1,8,'acontecimiento','Reacreditación Internacional por Seis Años','El programa recibe la reacreditación internacional con reconocimiento de pares académicos de México, España y Argentina, y la reacreditación nacional del MEN por seis años adicionales, consolidando su posición como programa de referencia en Colombia.',2024,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c8]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Resolución MEN 2024-ACRED-7821',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (15,2,10,'proyecto','LibreAdmin — Sistema de Gestión Académica','Plataforma web integral para la gestión de notas, asistencia y seguimiento académico. Incluye módulo de analítica para docentes, alertas de riesgo de deserción y portal de estudiantes con acceso móvil.

Línea de investigación: Ingeniería de Software. Tecnologías: React, Node.js, PostgreSQL, Docker. Resultado: Adoptado por 3 facultades de la universidad. Equipo: Ana Rodríguez, Carlos Méndez, Diana Torres',2023,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c9]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Proyecto de Grado — Director: Ing. Camila Morales',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (16,2,11,'proyecto','Detección de Patologías Retinales con IA','Red neuronal convolucional entrenada con más de 15.000 imágenes para la detección temprana de retinopatía diabética y glaucoma. Alcanzó una precisión del 94.3% en validación cruzada.

Línea de investigación: Inteligencia Artificial y Salud. Tecnologías: Python, TensorFlow, OpenCV, Keras. Resultado: Publicado en IEEE Xplore — LACLO 2022. Equipo: Julián Ospina, Valentina Cruz, Dr. Héctor Villanueva',2022,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c10]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Publicado en IEEE Xplore — LACLO 2022',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (17,2,12,'proyecto','App de Movilidad Sostenible — BiciLibre','Aplicación móvil para optimizar rutas de ciclovía y transporte público alternativo en Bogotá. Incluye gamificación por kilómetros recorridos, mapa en tiempo real y reportes de estado de vías.

Línea de investigación: Ciudades Inteligentes. Tecnologías: Flutter, Firebase, Google Maps API, Dart. Resultado: 12.400 descargas activas en Play Store. Equipo: Sebastián Vargas, Laura Pineda, Tomás Gutiérrez',2021,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c11]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Premio Innova Digital MinCiencias 2021',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (18,2,13,'proyecto','Sistema de Monitoreo de Calidad del Agua IoT','Red de sensores conectados para monitorear en tiempo real parámetros de calidad del agua en ríos del departamento de Cundinamarca. Los datos alimentan un dashboard público con alertas automáticas.

Línea de investigación: IoT y Medio Ambiente. Tecnologías: Arduino, MQTT, Node-RED, Grafana. Resultado: 8 nodos activos en ríos de Cundinamarca. Equipo: María José Castillo, Andrés Pedraza, Ing. Roberto Leal',2020,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c12]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Convenio Universidad Libre — IDEAM',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (19,2,14,'proyecto','Plataforma E-learning Inclusiva — AccesoLibre','Plataforma de aprendizaje en línea diseñada siguiendo WCAG 2.1 nivel AAA, con soporte para lectores de pantalla, contenido en lengua de señas colombiana y módulos de pedagogía adaptativa.

Línea de investigación: Tecnología Educativa Inclusiva. Tecnologías: Vue.js, Django, PostgreSQL, WebRTC. Resultado: Premio de Grado Laureado — Mención de Honor. Equipo: Daniela Suárez, Felipe Montoya',2019,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c13]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Proyecto de Grado Laureado 2019',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (20,1,15,'proyecto','Sistema de Detección de Fraude Financiero — FraudeNet','Algoritmo de aprendizaje automático para detección de transacciones fraudulentas en tiempo real, basado en grafos de conocimiento y modelos de anomalías no supervisados. Resultado directo de la primera patente del programa.

Línea de investigación: Seguridad Informática e IA. Tecnologías: Python, Neo4j, scikit-learn, Apache Kafka. Resultado: Primera patente de software del programa — SIC 2019. Equipo: Est. Alejandro Herrera, Dr. Héctor Villanueva, Ing. Camila Morales',2018,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c14]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Grupo GISI — Registrado ante SIC como Patente de Software',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (21,1,16,'premio','Primer Lugar — Olimpiada Nacional de Robótica UNAL 2023','El equipo "LibreBot 2.0" superó a 34 universidades con un robot colaborativo capaz de resolver laberintos dinámicos mediante visión por computador y aprendizaje por refuerzo.

Lugar: Bogotá, Colombia. Participantes: Miguel Ángel Suárez, Paula Jiménez, Tomás Gutiérrez',2023,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c15]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Olimpiada Nacional de Robótica — Universidad Nacional de Colombia',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (22,1,17,'premio','Mejor Ponencia — Congreso ACIS 2022','La ponencia "Detección temprana de deserción universitaria con modelos de ML" fue seleccionada como mejor ponencia del congreso entre 180 trabajos presentados de 25 universidades colombianas.

Lugar: Bogotá, Colombia. Participantes: Dr. Roberto Leal, Ing. Camila Morales',2022,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c16]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Asociación Colombiana de Ingenieros de Sistemas — ACIS',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (23,1,18,'premio','Premio Innova — MinCiencias 2021','El grupo GISI recibió el Premio Innova del Ministerio de Ciencias por el proyecto BiciLibre, reconocido como el mejor proyecto de innovación social con impacto urbano del año.

Lugar: Nacional — Colombia. Participantes: Grupo GISI, Sebastián Vargas, Laura Pineda, Tomás Gutiérrez',2021,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c17]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Ministerio de Ciencias, Tecnología e Innovación — MinCiencias',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (24,1,19,'premio','Grado Laureado — AccesoLibre','El proyecto de grado "AccesoLibre: Plataforma E-learning Inclusiva" obtuvo distinción de grado laureado, la máxima distinción académica del programa, otorgada por unanimidad del jurado.

Lugar: Bogotá, Colombia. Participantes: Daniela Suárez, Felipe Montoya',2019,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c18]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Consejo de Facultad — Universidad Libre',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (25,1,20,'persona','Dr. Fernando Espinosa — Docente Fundador','Pionero del programa, cofundador de la carrera en 1994. Dirigió la facultad durante 14 años y formó a más de 500 ingenieros. Su visión académica sentó las bases del perfil de egresado que distingue al programa hoy.

Biografía: Doctor en Ciencias de la Computación por la Universidad de los Andes. Fundó el Programa de Ingeniería de Sistemas en 1994 y lo dirigió hasta 2008. Autor de tres libros de texto adoptados en universidades colombianas.. Logros: Cofundador del programa (1994), Director de Programa 1994–2008, Autor de tres libros de texto, Formó a más de 500 ingenieros, Premio Docente del Año ACIS 2003. Perfil: docente',1994,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c19]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Archivo Histórico — Hoja de Vida Institucional',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (26,1,21,'persona','Ing. Marcela Rondón — Egresada Destacada','CTO de una de las cinco fintech más influyentes de Colombia. Egresada de la promoción 2005, es referente nacional de transformación digital y asesora del Gobierno Digital Colombia.

Biografía: Egresada con honores en 2005. Hizo su maestría en MIT Sloan. Fundó la fintech "DataPago" en 2013, valuada hoy en más de 50 millones de dólares. Asesora del programa Gobierno Digital del MinTIC.. Logros: Egresada con honores (2005), Maestría — MIT Sloan, Fundadora y CTO de DataPago, Forbes Colombia 30 Under 30 (2018), Asesora Gobierno Digital MinTIC. Perfil: egresado',2005,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c20]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Asociación de Egresados Universidad Libre',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (27,1,22,'persona','Est. Alejandro Herrera — Estudiante Sobresaliente','Ganador de tres hackathons internacionales durante su carrera, investigador del grupo GISI y becario doctoral del MIT. Su proyecto FraudeNet derivó en la primera patente de software del programa.

Biografía: Estudiante de la cohorte 2016. Ganó hackathons en MIT (2019), Stanford (2019) y ICPC Latinoamérica (2020). Actualmente becario doctoral en el MIT Media Lab. Coautor de la primera patente de software del programa.. Logros: Ganador Hackathon MIT 2019, Ganador Hackathon Stanford 2019, ICPC Latinoamérica — Top 10, Coautor Patente SIC 2019, Becario Doctoral MIT Media Lab. Perfil: estudiante',2020,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c21]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Registro Académico — Vicerrectoría de Investigaciones',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (28,1,23,'persona','Dr. Héctor Villanueva — Investigador Pionero','Fundó el primer semillero de IA del programa en 2001 y publicó más de 40 artículos en revistas indexadas. Formó 3 doctores y 12 magísteres durante sus 17 años como docente investigador.

Biografía: Doctor en Inteligencia Artificial por la Universidad Autónoma de Madrid. Fundó el grupo GISI en 2001 y lo dirigió hasta 2018. Publicó 42 artículos en revistas Scopus y Q1. Formó tres doctores y doce magísteres.. Logros: Fundador del Grupo GISI (2001), 42 publicaciones en revistas Scopus, Formó 3 doctores y 12 magísteres, Coautor Patente SIC 2019, Premio Investigador del Año MEN 2015. Perfil: pionero',2001,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c22]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Vicerrectoría de Investigaciones — CvLAC',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (29,1,24,'persona','Ing. Ricardo Pardo — Egresado Innovador','Fundador de EduTech Colombia, plataforma educativa con más de dos millones de usuarios activos. Su empresa fue seleccionada para el programa de aceleración de Y Combinator en 2021.

Biografía: Egresado de la promoción 2010. Fundó EduTech Colombia en 2014. En 2021 fue aceptado en Y Combinator, convirtiéndose en uno de los primeros colombianos en el programa. Su plataforma supera los 2 millones de usuarios en 8 países.. Logros: Fundador de EduTech Colombia, Y Combinator 2021, 2M+ usuarios activos, Startup del Año Colombia 2022, Mentor del programa de emprendimiento UniLibre. Perfil: egresado',2010,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c23]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Asociación de Egresados Universidad Libre',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (30,1,20,'persona','Dra. Patricia Salazar — Docente Investigadora','Primera docente investigadora del programa en obtener una beca Fulbright. Su tesis doctoral sobre computación afectiva fue citada más de 300 veces y sigue siendo referencia en la comunidad científica iberoamericana.

Biografía: Primera docente de tiempo completo del programa en recibir una beca Fulbright (2006). Doctora por la Universidad de Carnegie Mellon. Especialista en computación afectiva e interacción humano-computador.. Logros: Beca Fulbright 2006, Doctorado Carnegie Mellon, 300+ citas en Google Scholar, Presidenta IEEE Colombia 2018–2020, Mentora Mujer STEM Colombia. Perfil: docente',2003,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c24]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Vicerrectoría Académica — Universidad Libre',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (31,1,25,'evento','Semana de la Ingeniería 2026','La mayor celebración académica del programa reúne conferencias magistrales, talleres técnicos, feria de proyectos y la noche de entrega de reconocimientos anuales. Abierta a toda la comunidad universitaria.

Lugar: Campus principal, Bogotá. Fecha: 18 – 22 ago 2026. Objetivo: Celebrar la ingeniería con talleres, conferencias y exposición de proyectos estudiantiles',2026,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c25]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Programa Académico Oficial 2026-1',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (32,1,26,'evento','Hackathon LibreCode 2026','48 horas de innovación para resolver problemas reales de la ciudad con tecnología. Categorías: salud, movilidad, educación y sostenibilidad. Premios en efectivo y mentoría con empresas patrocinadoras.

Lugar: Laboratorio de Innovación Digital. Fecha: 25 – 26 oct 2026. Objetivo: 48 horas de desarrollo para resolver problemas reales de Bogotá con tecnología',2026,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c26]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Convocatoria LibreCode 2026 — Vicerrectoría de Investigaciones',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (33,1,25,'evento','Congreso Estudiantil de Sistemas 2025','El congreso reunió a 240 participantes de 18 universidades colombianas. Se presentaron 45 ponencias, 12 proyectos de grado y tres talleres de certificación en tecnologías emergentes.

Lugar: Auditorio Central — Universidad Libre. Fecha: 12 sep 2025. Objetivo: Presentar y discutir los mejores proyectos de investigación estudiantil del año',2025,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c27]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Memorias del Congreso Estudiantil 2025',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (34,1,27,'evento','Ceremonia de Grado — Promoción Diciembre 2025','Ceremonia de grado de 94 nuevos ingenieros de sistemas, incluyendo a los dos primeros graduados en el énfasis de Inteligencia Artificial y los cuatro titulados con distinción de grado de honor.

Lugar: Auditorio Principal — Universidad Libre. Fecha: 8 dic 2025. Objetivo: Celebrar la graduación de 94 nuevos ingenieros de sistemas de la Universidad Libre',2025,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c28]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Secretaría Académica — Universidad Libre',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (35,1,28,'investigacion','Grupo de Investigación GISI — Inteligencia y Sistemas de Información','Grupo reconocido por MinCiencias en categoría A1. Líneas activas: IA aplicada, seguridad informática, ingeniería de software y sistemas de información para la salud. 14 investigadores activos, 3 doctorandos.

Impacto: Categoría A1 MinCiencias — 42 publicaciones — 1 patente de software. Autores: Dr. Héctor Villanueva, Ing. Camila Morales, Ing. Roberto Leal, Dra. Patricia Salazar',2001,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c29]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: GrupLAC MinCiencias — Código COL0047823',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (36,1,29,'investigacion','Semillero SeedAI — Inteligencia Artificial Aplicada','Semillero estudiantil activo desde 2018, formado por estudiantes de séptimo semestre en adelante. Ha producido 8 publicaciones, 3 proyectos de grado laureados y el mejor proyecto de la Olimpiada de Robótica 2023.

Impacto: 8 publicaciones estudiantiles — 3 proyectos laureados — Premio Robótica 2023. Autores: Est. Alejandro Herrera, Paula Jiménez, Miguel Ángel Suárez, Tomás Gutiérrez',2018,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c30]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Vicerrectoría de Investigaciones — Registro de Semilleros 2024',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (37,1,30,'investigacion','Sistema de Detección de Fraude Financiero — Patente SIC NC2019/000234','Primera patente de software del programa. Algoritmo de detección de anomalías en redes de transacciones financieras usando grafos de conocimiento y aprendizaje no supervisado. Registrado ante la SIC en 2019.

Impacto: Primera patente de software del programa — Licencia de uso con dos entidades financieras. Autores: Dr. Héctor Villanueva, Est. Alejandro Herrera, Ing. Camila Morales',2019,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c31]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Superintendencia de Industria y Comercio — Registro NC2019/000234',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (38,1,31,'investigacion','Detección Temprana de Deserción con ML — IEEE Xplore 2023','Artículo publicado en IEEE Transactions on Learning Technologies. Modelo de clasificación multiclase con 89% de precisión para predecir riesgo de deserción estudiantil en los primeros tres semestres. Datos de 4.200 estudiantes.

Impacto: 48 citas en Google Scholar — Implementado en el Sistema LibreAdmin. Autores: Dr. Roberto Leal, Ing. Camila Morales, Valentina Cruz',2023,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c32]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: IEEE Transactions on Learning Technologies — DOI: 10.1109/TLT.2023.1234567',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (39,1,32,'investigacion','El programa recibe financiación de Minciencias para proyecto de IA en salud','La convocatoria 937 de MinCiencias otorgó 450 millones de pesos al proyecto "IA para diagnóstico temprano de enfermedades crónicas en zonas rurales", liderado por el grupo GISI con un equipo de 8 investigadores.

Resumen: MinCiencias aprobó 450 millones de pesos para el proyecto de diagnóstico de enfermedades en zonas rurales.',2026,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c33]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Vicerrectoría de Investigaciones — Comunicado de prensa',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (40,1,32,'investigacion','Dos egresados del programa entre los 30 líderes tecnológicos menores de 30 de Forbes Colombia','Marcela Rondón (2005) y Ricardo Pardo (2010) fueron incluidos en la lista Forbes Colombia 30 Under 30 en las categorías de Fintech y EdTech respectivamente, destacando el impacto del programa en el ecosistema tecnológico nacional.

Resumen: Dos egresados del programa se destacan en la lista Forbes Colombia 30 Under 30 en Fintech y EdTech.',2026,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c34]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Forbes Colombia — Edición Julio 2026',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (41,1,32,'investigacion','El semillero SeedAI gana el hackatón de la OEA sobre tecnología para la paz','El equipo del semillero SeedAI resultó ganador del Hackathon Tecnología para la Paz organizado por la OEA, con una propuesta de plataforma de mapeo participativo para comunidades en zonas de reintegración.

Resumen: El semillero SeedAI gana el hackatón internacional de la OEA sobre tecnología para la paz.',2026,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c35]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Organización de los Estados Americanos — Comunicado oficial',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (42,3,10,'proyecto','Sistema de Gestión de Inventarios con RFID — StockLibre','Plataforma para la gestión en tiempo real de inventarios en bibliotecas y laboratorios universitarios usando tecnología RFID. Redujo el tiempo de inventario de 8 horas a 45 minutos en la prueba piloto.

Línea de investigación: Sistemas de Información. Tecnologías: Arduino, React, Node.js, MySQL, RFID RC522. Resultado: Reducción del 90% en tiempo de inventario en prueba piloto. Equipo: Andrés Felipe Cárdenas, Natalia Bermúdez',2024,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c36]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Proyecto de Grado 2024 — Director: Ing. Roberto Leal',0,'en_revision','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (43,2,24,'persona','Ing. Santiago Montoya — Egresado Emprendedor','Egresado de 2015 que fundó la startup de ciberseguridad "CyberLibre" en 2018. La empresa protege hoy a más de 200 pymes colombianas y fue reconocida por el CCIT como caso de éxito en emprendimiento TIC.

Biografía: Egresado de la promoción 2015. Trabajó 3 años en Bancolombia antes de fundar CyberLibre en 2018. La empresa está certificada ISO 27001 y tiene contratos con 200+ pymes y 3 entidades del gobierno.. Logros: Fundador CyberLibre (2018), ISO 27001 Lead Auditor, Caso de Éxito CCIT 2023, 200+ pymes protegidas, Embajador Startup Colombia. Perfil: egresado',2015,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c37]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Cámara Colombiana de Informática y Telecomunicaciones — CCIT',0,'en_revision','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (44,2,7,'acontecimiento','Apertura del énfasis en Inteligencia Artificial','El programa aprueba y abre el primer énfasis de profundización en Inteligencia Artificial, con materias especializadas en aprendizaje profundo, procesamiento de lenguaje natural y ética en IA. Primera cohorte: 28 estudiantes.',2025,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c38]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Resolución Consejo Académico 2025-CA-0018',0,'en_revision','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (45,3,33,'premio','Mención de Honor — Congreso IEEE LACLO 2024','El artículo sobre detección de deserción estudiantil recibió mención de honor en el Congreso Latinoamericano de Tecnología en Educación.

Lugar: Lima, Perú. Participantes: Valentina Cruz, Dr. Roberto Leal

Nota de revisión del prototipo: Por favor adjunta el certificado digital del congreso y amplía la descripción con el título completo del artículo y el nombre del director de memoria. La fuente debe incluir el enlace al repositorio IEEE.',2024,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:c39]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: IEEE LACLO 2024 — Actas del Congreso',0,'requiere_ajustes','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (46,1,7,'galeria','Galería: Fundación del Programa de Ingeniería de Sistemas','El Programa de Ingeniería de Sistemas de la Universidad Libre abre sus puertas con la primera cohorte de 42 estudiantes. Este hito marca el inicio de una historia de formación tecnológica con impacto social en Bogotá.',1994,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:galeria-c1]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Archivo Histórico Universidad Libre',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (47,2,10,'galeria','Galería: LibreAdmin — Sistema de Gestión Académica','Plataforma web integral para la gestión de notas, asistencia y seguimiento académico. Incluye módulo de analítica para docentes, alertas de riesgo de deserción y portal de estudiantes con acceso móvil.

Línea de investigación: Ingeniería de Software. Tecnologías: React, Node.js, PostgreSQL, Docker. Resultado: Adoptado por 3 facultades de la universidad. Equipo: Ana Rodríguez, Carlos Méndez, Diana Torres',2023,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:galeria-c9]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Proyecto de Grado — Director: Ing. Camila Morales',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (48,1,16,'galeria','Galería: Primer Lugar — Olimpiada Nacional de Robótica UNAL 2023','El equipo "LibreBot 2.0" superó a 34 universidades con un robot colaborativo capaz de resolver laberintos dinámicos mediante visión por computador y aprendizaje por refuerzo.

Lugar: Bogotá, Colombia. Participantes: Miguel Ángel Suárez, Paula Jiménez, Tomás Gutiérrez',2023,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:galeria-c15]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Olimpiada Nacional de Robótica — Universidad Nacional de Colombia',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (49,1,20,'galeria','Galería: Dr. Fernando Espinosa — Docente Fundador','Pionero del programa, cofundador de la carrera en 1994. Dirigió la facultad durante 14 años y formó a más de 500 ingenieros. Su visión académica sentó las bases del perfil de egresado que distingue al programa hoy.

Biografía: Doctor en Ciencias de la Computación por la Universidad de los Andes. Fundó el Programa de Ingeniería de Sistemas en 1994 y lo dirigió hasta 2008. Autor de tres libros de texto adoptados en universidades colombianas.. Logros: Cofundador del programa (1994), Director de Programa 1994–2008, Autor de tres libros de texto, Formó a más de 500 ingenieros, Premio Docente del Año ACIS 2003. Perfil: docente',1994,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:galeria-c19]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Archivo Histórico — Hoja de Vida Institucional',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (50,1,25,'galeria','Galería: Semana de la Ingeniería 2026','La mayor celebración académica del programa reúne conferencias magistrales, talleres técnicos, feria de proyectos y la noche de entrega de reconocimientos anuales. Abierta a toda la comunidad universitaria.

Lugar: Campus principal, Bogotá. Fecha: 18 – 22 ago 2026. Objetivo: Celebrar la ingeniería con talleres, conferencias y exposición de proyectos estudiantiles',2026,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:galeria-c25]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: Programa Académico Oficial 2026-1',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');
INSERT INTO contenidos (id,autor_id,categoria_id,tipo,titulo,descripcion,anio,fuente,derechos_autor,estado,creado_en,actualizado_en) VALUES (51,1,28,'galeria','Galería: Grupo de Investigación GISI — Inteligencia y Sistemas de Información','Grupo reconocido por MinCiencias en categoría A1. Líneas activas: IA aplicada, seguridad informática, ingeniería de software y sistemas de información para la salud. 14 investigadores activos, 3 doctorandos.

Impacto: Categoría A1 MinCiencias — 42 publicaciones — 1 patente de software. Autores: Dr. Héctor Villanueva, Ing. Camila Morales, Ing. Roberto Leal, Dra. Patricia Salazar',2001,'EJEMPLO FICTICIO DEL PROTOTIPO FIGMA [FIGMA:galeria-c29]. No es un hecho verificado de Universidad Libre Barranquilla. Referencia mencionada en el prototipo, sin verificar: GrupLAC MinCiencias — Código COL0047823',0,'publicado','2026-09-28 17:13:45','2026-09-28 17:13:45');

-- acontecimientos: 10 filas
INSERT INTO acontecimientos (contenido_id,fecha,tipo_hito) VALUES (1,'1976-01-01','hito');
INSERT INTO acontecimientos (contenido_id,fecha,tipo_hito) VALUES (7,'1994-01-01','hito');
INSERT INTO acontecimientos (contenido_id,fecha,tipo_hito) VALUES (8,'2001-01-01','investigacion');
INSERT INTO acontecimientos (contenido_id,fecha,tipo_hito) VALUES (9,'2007-01-01','logro');
INSERT INTO acontecimientos (contenido_id,fecha,tipo_hito) VALUES (10,'2012-01-01','premio');
INSERT INTO acontecimientos (contenido_id,fecha,tipo_hito) VALUES (11,'2016-01-01','hito');
INSERT INTO acontecimientos (contenido_id,fecha,tipo_hito) VALUES (12,'2019-01-01','investigacion');
INSERT INTO acontecimientos (contenido_id,fecha,tipo_hito) VALUES (13,'2022-01-01','logro');
INSERT INTO acontecimientos (contenido_id,fecha,tipo_hito) VALUES (14,'2024-01-01','logro');
INSERT INTO acontecimientos (contenido_id,fecha,tipo_hito) VALUES (44,'2025-01-01','hito');

-- premios: 6 filas
INSERT INTO premios (contenido_id,entidad_otorgante,lugar,fecha) VALUES (4,NULL,NULL,'2022-01-01');
INSERT INTO premios (contenido_id,entidad_otorgante,lugar,fecha) VALUES (21,NULL,'Bogotá, Colombia','2023-01-01');
INSERT INTO premios (contenido_id,entidad_otorgante,lugar,fecha) VALUES (22,NULL,'Bogotá, Colombia','2022-01-01');
INSERT INTO premios (contenido_id,entidad_otorgante,lugar,fecha) VALUES (23,NULL,'Nacional — Colombia','2021-01-01');
INSERT INTO premios (contenido_id,entidad_otorgante,lugar,fecha) VALUES (24,NULL,'Bogotá, Colombia','2019-01-01');
INSERT INTO premios (contenido_id,entidad_otorgante,lugar,fecha) VALUES (45,NULL,'Lima, Perú','2024-01-01');

-- eventos: 5 filas
INSERT INTO eventos (contenido_id,fecha_inicio,fecha_fin,fecha_texto,lugar,objetivo) VALUES (6,NULL,NULL,NULL,NULL,NULL);
INSERT INTO eventos (contenido_id,fecha_inicio,fecha_fin,fecha_texto,lugar,objetivo) VALUES (31,'2026-08-18 00:00:00','2026-08-22 00:00:00','18 – 22 ago 2026','Campus principal, Bogotá','Celebrar la ingeniería con talleres, conferencias y exposición de proyectos estudiantiles');
INSERT INTO eventos (contenido_id,fecha_inicio,fecha_fin,fecha_texto,lugar,objetivo) VALUES (32,'2026-10-25 00:00:00','2026-10-26 00:00:00','25 – 26 oct 2026','Laboratorio de Innovación Digital','48 horas de desarrollo para resolver problemas reales de Bogotá con tecnología');
INSERT INTO eventos (contenido_id,fecha_inicio,fecha_fin,fecha_texto,lugar,objetivo) VALUES (33,'2025-09-12 00:00:00',NULL,'12 sep 2025','Auditorio Central — Universidad Libre','Presentar y discutir los mejores proyectos de investigación estudiantil del año');
INSERT INTO eventos (contenido_id,fecha_inicio,fecha_fin,fecha_texto,lugar,objetivo) VALUES (34,'2025-12-08 00:00:00',NULL,'8 dic 2025','Auditorio Principal — Universidad Libre','Celebrar la graduación de 94 nuevos ingenieros de sistemas de la Universidad Libre');

-- hall_fama: 8 filas
INSERT INTO hall_fama (contenido_id,persona_id,biografia,logros) VALUES (5,5,NULL,NULL);
INSERT INTO hall_fama (contenido_id,persona_id,biografia,logros) VALUES (25,6,'Doctor en Ciencias de la Computación por la Universidad de los Andes. Fundó el Programa de Ingeniería de Sistemas en 1994 y lo dirigió hasta 2008. Autor de tres libros de texto adoptados en universidades colombianas.','Cofundador del programa (1994)
Director de Programa 1994–2008
Autor de tres libros de texto
Formó a más de 500 ingenieros
Premio Docente del Año ACIS 2003');
INSERT INTO hall_fama (contenido_id,persona_id,biografia,logros) VALUES (26,33,'Egresada con honores en 2005. Hizo su maestría en MIT Sloan. Fundó la fintech "DataPago" en 2013, valuada hoy en más de 50 millones de dólares. Asesora del programa Gobierno Digital del MinTIC.','Egresada con honores (2005)
Maestría — MIT Sloan
Fundadora y CTO de DataPago
Forbes Colombia 30 Under 30 (2018)
Asesora Gobierno Digital MinTIC');
INSERT INTO hall_fama (contenido_id,persona_id,biografia,logros) VALUES (27,16,'Estudiante de la cohorte 2016. Ganó hackathons en MIT (2019), Stanford (2019) y ICPC Latinoamérica (2020). Actualmente becario doctoral en el MIT Media Lab. Coautor de la primera patente de software del programa.','Ganador Hackathon MIT 2019
Ganador Hackathon Stanford 2019
ICPC Latinoamérica — Top 10
Coautor Patente SIC 2019
Becario Doctoral MIT Media Lab');
INSERT INTO hall_fama (contenido_id,persona_id,biografia,logros) VALUES (28,7,'Doctor en Inteligencia Artificial por la Universidad Autónoma de Madrid. Fundó el grupo GISI en 2001 y lo dirigió hasta 2018. Publicó 42 artículos en revistas Scopus y Q1. Formó tres doctores y doce magísteres.','Fundador del Grupo GISI (2001)
42 publicaciones en revistas Scopus
Formó 3 doctores y 12 magísteres
Coautor Patente SIC 2019
Premio Investigador del Año MEN 2015');
INSERT INTO hall_fama (contenido_id,persona_id,biografia,logros) VALUES (29,34,'Egresado de la promoción 2010. Fundó EduTech Colombia en 2014. En 2021 fue aceptado en Y Combinator, convirtiéndose en uno de los primeros colombianos en el programa. Su plataforma supera los 2 millones de usuarios en 8 países.','Fundador de EduTech Colombia
Y Combinator 2021
2M+ usuarios activos
Startup del Año Colombia 2022
Mentor del programa de emprendimiento UniLibre');
INSERT INTO hall_fama (contenido_id,persona_id,biografia,logros) VALUES (30,35,'Primera docente de tiempo completo del programa en recibir una beca Fulbright (2006). Doctora por la Universidad de Carnegie Mellon. Especialista en computación afectiva e interacción humano-computador.','Beca Fulbright 2006
Doctorado Carnegie Mellon
300+ citas en Google Scholar
Presidenta IEEE Colombia 2018–2020
Mentora Mujer STEM Colombia');
INSERT INTO hall_fama (contenido_id,persona_id,biografia,logros) VALUES (43,50,'Egresado de la promoción 2015. Trabajó 3 años en Bancolombia antes de fundar CyberLibre en 2018. La empresa está certificada ISO 27001 y tiene contratos con 200+ pymes y 3 entidades del gobierno.','Fundador CyberLibre (2018)
ISO 27001 Lead Auditor
Caso de Éxito CCIT 2023
200+ pymes protegidas
Embajador Startup Colombia');

-- grupos_investigacion: 1 filas
INSERT INTO grupos_investigacion (id,lider_id,nombre,codigo_minciencias,categoria,linea_principal) VALUES (1,7,'GISI — Inteligencia y Sistemas de Información','COL0047823','A1','IA aplicada, seguridad informática, ingeniería de software y sistemas de información para la salud');

-- semilleros: 3 filas
INSERT INTO semilleros (id,grupo_id,coordinador_id,nombre,descripcion,linea_investigacion,anio_creacion,logo,estado) VALUES (1,1,NULL,'SeedAI — Inteligencia Artificial Aplicada','Semillero estudiantil formado por estudiantes de séptimo semestre en adelante. Ha producido 8 publicaciones y 3 proyectos de grado laureados.','Inteligencia artificial aplicada',2018,NULL,'activo');
INSERT INTO semilleros (id,grupo_id,coordinador_id,nombre,descripcion,linea_investigacion,anio_creacion,logo,estado) VALUES (2,1,7,'Semillero de Sistemas Inteligentes','Primer semillero de investigación del programa, enfocado en inteligencia artificial y bases de datos relacionales.','Inteligencia artificial y bases de datos',2001,NULL,'activo');
INSERT INTO semilleros (id,grupo_id,coordinador_id,nombre,descripcion,linea_investigacion,anio_creacion,logo,estado) VALUES (3,NULL,NULL,'Semillero de Innovación Digital','Organiza el Hackathon LibreCode y espacios de innovación estudiantil.',NULL,NULL,NULL,'activo');

-- semillero_miembros: 5 filas
INSERT INTO semillero_miembros (semillero_id,persona_id,rol,fecha_ingreso,fecha_salida) VALUES (1,13,'integrante',NULL,NULL);
INSERT INTO semillero_miembros (semillero_id,persona_id,rol,fecha_ingreso,fecha_salida) VALUES (1,16,'integrante',NULL,NULL);
INSERT INTO semillero_miembros (semillero_id,persona_id,rol,fecha_ingreso,fecha_salida) VALUES (1,25,'integrante',NULL,NULL);
INSERT INTO semillero_miembros (semillero_id,persona_id,rol,fecha_ingreso,fecha_salida) VALUES (1,30,'integrante',NULL,NULL);
INSERT INTO semillero_miembros (semillero_id,persona_id,rol,fecha_ingreso,fecha_salida) VALUES (2,7,'coordinador',NULL,NULL);

-- proyectos: 8 filas
INSERT INTO proyectos (contenido_id,semillero_id,linea_investigacion,tecnologias,resultados,impacto) VALUES (2,NULL,NULL,NULL,NULL,NULL);
INSERT INTO proyectos (contenido_id,semillero_id,linea_investigacion,tecnologias,resultados,impacto) VALUES (15,NULL,'Ingeniería de Software','React, Node.js, PostgreSQL, Docker','Adoptado por 3 facultades de la universidad',NULL);
INSERT INTO proyectos (contenido_id,semillero_id,linea_investigacion,tecnologias,resultados,impacto) VALUES (16,NULL,'Inteligencia Artificial y Salud','Python, TensorFlow, OpenCV, Keras','Publicado en IEEE Xplore — LACLO 2022',NULL);
INSERT INTO proyectos (contenido_id,semillero_id,linea_investigacion,tecnologias,resultados,impacto) VALUES (17,1,'Ciudades Inteligentes','Flutter, Firebase, Google Maps API, Dart','12.400 descargas activas en Play Store',NULL);
INSERT INTO proyectos (contenido_id,semillero_id,linea_investigacion,tecnologias,resultados,impacto) VALUES (18,NULL,'IoT y Medio Ambiente','Arduino, MQTT, Node-RED, Grafana','8 nodos activos en ríos de Cundinamarca',NULL);
INSERT INTO proyectos (contenido_id,semillero_id,linea_investigacion,tecnologias,resultados,impacto) VALUES (19,NULL,'Tecnología Educativa Inclusiva','Vue.js, Django, PostgreSQL, WebRTC','Premio de Grado Laureado — Mención de Honor',NULL);
INSERT INTO proyectos (contenido_id,semillero_id,linea_investigacion,tecnologias,resultados,impacto) VALUES (20,NULL,'Seguridad Informática e IA','Python, Neo4j, scikit-learn, Apache Kafka','Primera patente de software del programa — SIC 2019',NULL);
INSERT INTO proyectos (contenido_id,semillero_id,linea_investigacion,tecnologias,resultados,impacto) VALUES (42,NULL,'Sistemas de Información','Arduino, React, Node.js, MySQL, RFID RC522','Reducción del 90% en tiempo de inventario en prueba piloto',NULL);

-- investigaciones: 8 filas
INSERT INTO investigaciones (contenido_id,semillero_id,grupo_id,tipo,doi_o_registro,impacto) VALUES (3,NULL,NULL,'publicacion',NULL,NULL);
INSERT INTO investigaciones (contenido_id,semillero_id,grupo_id,tipo,doi_o_registro,impacto) VALUES (35,NULL,1,'grupo',NULL,'Categoría A1 MinCiencias — 42 publicaciones — 1 patente de software');
INSERT INTO investigaciones (contenido_id,semillero_id,grupo_id,tipo,doi_o_registro,impacto) VALUES (36,1,1,'semillero',NULL,'8 publicaciones estudiantiles — 3 proyectos laureados — Premio Robótica 2023');
INSERT INTO investigaciones (contenido_id,semillero_id,grupo_id,tipo,doi_o_registro,impacto) VALUES (37,NULL,1,'patente',NULL,'Primera patente de software del programa — Licencia de uso con dos entidades financieras');
INSERT INTO investigaciones (contenido_id,semillero_id,grupo_id,tipo,doi_o_registro,impacto) VALUES (38,NULL,1,'publicacion',NULL,'48 citas en Google Scholar — Implementado en el Sistema LibreAdmin');
INSERT INTO investigaciones (contenido_id,semillero_id,grupo_id,tipo,doi_o_registro,impacto) VALUES (39,NULL,NULL,'publicacion',NULL,NULL);
INSERT INTO investigaciones (contenido_id,semillero_id,grupo_id,tipo,doi_o_registro,impacto) VALUES (40,NULL,NULL,'publicacion',NULL,NULL);
INSERT INTO investigaciones (contenido_id,semillero_id,grupo_id,tipo,doi_o_registro,impacto) VALUES (41,NULL,NULL,'publicacion',NULL,NULL);

-- participaciones: 109 filas
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (1,1,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (2,2,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (3,3,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (4,4,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (5,5,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (6,1,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (7,6,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (7,7,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (8,7,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (8,8,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (9,9,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (9,10,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (10,11,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (10,12,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (10,13,'protagonista',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (11,14,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (11,15,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (12,7,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (12,15,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (12,16,'protagonista',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (13,17,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (13,18,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (14,10,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (14,19,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (15,12,'protagonista,integrante',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (15,20,'protagonista,integrante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (15,21,'protagonista,integrante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (16,7,'integrante',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (16,22,'protagonista,integrante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (16,23,'protagonista,integrante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (17,11,'protagonista,integrante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (17,24,'protagonista,integrante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (17,25,'protagonista,integrante',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (18,8,'integrante',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (18,26,'protagonista,integrante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (18,27,'protagonista,integrante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (19,28,'protagonista,integrante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (19,29,'protagonista,integrante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (20,7,'protagonista,integrante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (20,15,'integrante',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (20,16,'protagonista,integrante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (21,13,'protagonista,participante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (21,25,'protagonista,participante',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (21,30,'protagonista,participante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (22,15,'protagonista,participante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (22,31,'protagonista,participante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (23,11,'protagonista,participante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (23,24,'protagonista,participante',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (23,25,'participante',4);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (23,32,'protagonista,participante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (24,28,'protagonista,participante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (24,29,'protagonista,participante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (25,6,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (26,33,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (27,16,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (28,7,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (29,34,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (30,35,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (31,36,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (31,37,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (32,38,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (32,39,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (33,37,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (33,40,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (34,41,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (34,42,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (34,43,'protagonista',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (35,7,'protagonista,autor',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (35,8,'protagonista,autor',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (35,15,'protagonista,autor',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (35,35,'autor',4);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (36,13,'protagonista,autor',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (36,16,'protagonista,autor',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (36,25,'autor',4);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (36,30,'protagonista,autor',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (37,7,'protagonista,autor',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (37,15,'protagonista,autor',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (37,16,'protagonista,autor',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (38,15,'protagonista,autor',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (38,23,'protagonista,autor',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (38,31,'protagonista,autor',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (39,32,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (39,44,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (40,33,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (40,34,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (40,45,'protagonista',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (41,46,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (41,47,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (42,48,'protagonista,integrante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (42,49,'protagonista,integrante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (43,50,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (44,9,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (44,15,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (45,23,'protagonista,participante',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (45,31,'protagonista,participante',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (46,6,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (46,7,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (47,12,'protagonista',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (47,20,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (47,21,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (48,13,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (48,25,'protagonista',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (48,30,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (49,6,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (50,36,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (50,37,'protagonista',2);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (51,7,'protagonista',1);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (51,8,'protagonista',3);
INSERT INTO participaciones (contenido_id,persona_id,rol,orden) VALUES (51,15,'protagonista',2);

-- contenido_etiquetas: 223 filas
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (1,1);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (1,2);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (2,3);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (2,4);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (3,5);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (3,6);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (4,7);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (4,8);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (5,9);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (5,10);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (6,11);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (6,12);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (7,2);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (7,10);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (7,13);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (8,5);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (8,14);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (8,15);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (8,16);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (9,17);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (9,18);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (9,19);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (9,20);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (10,7);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (10,21);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (10,22);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (10,23);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (11,3);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (11,4);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (11,24);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (11,25);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (12,6);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (12,15);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (12,26);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (12,27);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (12,28);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (13,8);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (13,9);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (13,29);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (13,30);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (14,18);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (14,31);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (14,32);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (14,33);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (15,34);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (15,35);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (15,36);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (15,37);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (16,15);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (16,38);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (16,39);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (16,40);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (16,41);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (17,42);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (17,43);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (17,44);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (17,45);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (17,46);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (18,47);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (18,48);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (18,49);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (18,50);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (18,51);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (19,52);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (19,53);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (19,54);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (19,55);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (19,56);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (20,26);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (20,28);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (20,57);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (20,58);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (20,59);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (20,60);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (21,21);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (21,23);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (21,61);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (21,62);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (22,5);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (22,59);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (22,63);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (22,64);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (22,65);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (23,4);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (23,23);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (23,27);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (23,66);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (23,67);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (24,52);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (24,53);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (24,68);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (24,69);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (25,10);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (25,70);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (25,71);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (25,72);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (26,73);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (26,74);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (26,75);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (26,76);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (27,26);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (27,77);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (27,78);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (27,79);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (27,80);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (28,15);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (28,27);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (28,81);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (28,82);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (28,83);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (29,84);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (29,85);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (29,86);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (29,87);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (30,5);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (30,71);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (30,88);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (30,89);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (30,90);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (31,91);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (31,92);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (31,93);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (31,94);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (32,4);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (32,79);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (32,95);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (32,96);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (32,97);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (33,98);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (33,99);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (33,100);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (33,101);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (33,102);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (34,29);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (34,101);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (34,102);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (34,103);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (34,104);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (35,6);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (35,15);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (35,27);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (35,57);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (35,66);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (35,105);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (36,14);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (36,15);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (36,21);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (36,99);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (36,106);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (37,26);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (37,28);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (37,58);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (37,59);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (37,60);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (37,107);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (38,41);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (38,59);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (38,65);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (38,108);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (38,109);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (38,110);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (39,15);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (39,39);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (39,66);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (39,111);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (39,112);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (39,113);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (40,9);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (40,85);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (40,111);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (40,114);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (40,115);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (41,32);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (41,79);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (41,106);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (41,111);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (41,116);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (41,117);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (42,37);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (42,118);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (42,119);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (42,120);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (42,121);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (43,84);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (43,85);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (43,122);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (43,123);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (43,124);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (44,15);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (44,125);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (44,126);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (44,127);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (44,128);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (45,41);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (45,65);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (45,109);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (45,129);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (45,130);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (46,2);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (46,10);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (46,13);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (47,34);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (47,35);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (47,36);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (47,37);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (48,21);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (48,23);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (48,61);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (48,62);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (49,10);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (49,70);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (49,71);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (49,72);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (50,91);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (50,92);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (50,93);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (50,94);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (51,6);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (51,15);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (51,27);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (51,57);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (51,66);
INSERT INTO contenido_etiquetas (contenido_id,etiqueta_id) VALUES (51,105);

-- evidencias: 40 filas
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (1,7,'imagen','https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Fundación del Programa de Ingeniería de Sistemas',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (2,8,'imagen','https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Primer Semillero de Investigación en Sistemas Inteligentes',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (3,9,'imagen','https://images.unsplash.com/photo-1525921429624-479b6a26d84d?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Acreditación de Alta Calidad — Primera vez',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (4,10,'imagen','https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Primer Lugar — Olimpiada Nacional de Robótica',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (5,11,'imagen','https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Inauguración del Laboratorio de Innovación Digital',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (6,12,'imagen','https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Primera Patente de Software del Programa',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (7,13,'imagen','https://images.unsplash.com/photo-1590012314607-cda9d9b699ae?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Egresado N.° 1000 del Programa',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (8,14,'imagen','https://images.unsplash.com/photo-1567427018141-0584cfcbf1b8?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Reacreditación Internacional por Seis Años',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (9,15,'imagen','https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para LibreAdmin — Sistema de Gestión Académica',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (10,16,'imagen','https://images.unsplash.com/photo-1559757175-5700dde675bc?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Detección de Patologías Retinales con IA',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (11,17,'imagen','https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para App de Movilidad Sostenible — BiciLibre',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (12,18,'imagen','https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Sistema de Monitoreo de Calidad del Agua IoT',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (13,19,'imagen','https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Plataforma E-learning Inclusiva — AccesoLibre',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (14,20,'imagen','https://images.unsplash.com/photo-1563986768609-322da13575f3?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Sistema de Detección de Fraude Financiero — FraudeNet',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (15,21,'imagen','https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Primer Lugar — Olimpiada Nacional de Robótica UNAL 2023',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (16,22,'imagen','https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Mejor Ponencia — Congreso ACIS 2022',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (17,23,'imagen','https://images.unsplash.com/photo-1567427018141-0584cfcbf1b8?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Premio Innova — MinCiencias 2021',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (18,24,'imagen','https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Grado Laureado — AccesoLibre',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (19,25,'imagen','https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Dr. Fernando Espinosa — Docente Fundador',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (20,26,'imagen','https://images.unsplash.com/photo-1580489944761-15a19d654956?w=400&h=400&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Ing. Marcela Rondón — Egresada Destacada',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (21,27,'imagen','https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400&h=400&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Est. Alejandro Herrera — Estudiante Sobresaliente',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (22,28,'imagen','https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=400&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Dr. Héctor Villanueva — Investigador Pionero',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (23,29,'imagen','https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400&h=400&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Ing. Ricardo Pardo — Egresado Innovador',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (24,30,'imagen','https://images.unsplash.com/photo-1594744803329-e58b31de8bf5?w=400&h=400&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Dra. Patricia Salazar — Docente Investigadora',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (25,31,'imagen','https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Semana de la Ingeniería 2026',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (26,32,'imagen','https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Hackathon LibreCode 2026',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (27,33,'imagen','https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Congreso Estudiantil de Sistemas 2025',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (28,34,'imagen','https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Ceremonia de Grado — Promoción Diciembre 2025',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (29,35,'imagen','https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Grupo de Investigación GISI — Inteligencia y Sistemas de Información',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (30,36,'imagen','https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Semillero SeedAI — Inteligencia Artificial Aplicada',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (31,37,'imagen','https://images.unsplash.com/photo-1563986768609-322da13575f3?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Sistema de Detección de Fraude Financiero — Patente SIC NC2019/000234',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (32,38,'imagen','https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Detección Temprana de Deserción con ML — IEEE Xplore 2023',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (33,42,'imagen','https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Sistema de Gestión de Inventarios con RFID — StockLibre',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (34,43,'imagen','https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&h=400&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Ing. Santiago Montoya — Egresado Emprendedor',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (35,46,'imagen','https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Galería: Fundación del Programa de Ingeniería de Sistemas',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (36,47,'imagen','https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Galería: LibreAdmin — Sistema de Gestión Académica',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (37,48,'imagen','https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Galería: Primer Lugar — Olimpiada Nacional de Robótica UNAL 2023',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (38,49,'imagen','https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Galería: Dr. Fernando Espinosa — Docente Fundador',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (39,50,'imagen','https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Galería: Semana de la Ingeniería 2026',1,0);
INSERT INTO evidencias (id,contenido_id,tipo,url,credito,texto_alt,orden,autorizado) VALUES (40,51,'imagen','https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=800&h=500&fit=crop&auto=format','Imagen ilustrativa de Unsplash; no documenta el hecho descrito','Fotografía ilustrativa para Galería: Grupo de Investigación GISI — Inteligencia y Sistemas de Información',1,0);

-- validaciones: 45 filas
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (1,7,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (2,8,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (3,9,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (4,10,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (5,11,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (6,12,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (7,13,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (8,14,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (9,15,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (10,16,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (11,17,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (12,18,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (13,19,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (14,20,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (15,21,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (16,22,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (17,23,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (18,24,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (19,25,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (20,26,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (21,27,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (22,28,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (23,29,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (24,30,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (25,31,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (26,32,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (27,33,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (28,34,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (29,35,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (30,36,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (31,37,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (32,38,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (33,39,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (34,40,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (35,41,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (36,42,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (37,43,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (38,44,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (39,45,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (40,46,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (41,47,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (42,48,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (43,49,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (44,50,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');
INSERT INTO validaciones (id,contenido_id,usuario_id,accion,observaciones,fecha) VALUES (45,51,1,'return','Registro demostrativo importado de Figma','2026-10-12 08:43:06');

-- auditoria: 51 filas
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (1,1,1,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (2,1,2,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (3,1,3,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (4,1,4,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (5,1,5,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (6,1,6,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (7,1,7,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (8,1,8,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (9,1,9,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (10,1,10,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (11,1,11,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (12,1,12,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (13,1,13,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (14,1,14,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (15,1,15,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (16,1,16,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (17,1,17,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (18,1,18,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (19,1,19,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (20,1,20,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (21,1,21,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (22,1,22,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (23,1,23,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (24,1,24,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (25,1,25,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (26,1,26,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (27,1,27,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (28,1,28,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (29,1,29,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (30,1,30,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (31,1,31,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (32,1,32,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (33,1,33,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (34,1,34,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (35,1,35,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (36,1,36,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (37,1,37,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (38,1,38,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (39,1,39,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (40,1,40,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (41,1,41,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (42,1,42,'archive','en_revision','en_revision','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (43,1,43,'archive','en_revision','en_revision','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (44,1,44,'archive','en_revision','en_revision','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (45,1,45,'archive','en_revision','requiere_ajustes','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (46,1,46,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (47,1,47,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (48,1,48,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (49,1,49,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (50,1,50,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');
INSERT INTO auditoria (id,usuario_id,contenido_id,accion,estado_anterior,estado_nuevo,nota,fecha) VALUES (51,1,51,'publish','en_revision','publicado','Carga inicial del prototipo','2026-10-12 08:43:06');

-- insignias: 3 filas
INSERT INTO insignias (id,nombre,descripcion,puntos_requeridos,icono) VALUES (1,'Primera memoria','Publicó su primer aporte en el museo',50,'sparkles');
INSERT INTO insignias (id,nombre,descripcion,puntos_requeridos,icono) VALUES (2,'Colaborador activo','Tiene 3 aportes publicados',150,'users');
INSERT INTO insignias (id,nombre,descripcion,puntos_requeridos,icono) VALUES (3,'Memoria viva','Tiene 10 aportes publicados',500,'award');

-- registro_puntos: 47 filas
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (1,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (2,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (3,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (4,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (5,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (6,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (7,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (8,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (9,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (10,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (11,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (12,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (13,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (14,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (15,2,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (16,2,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (17,2,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (18,2,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (19,2,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (20,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (21,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (22,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (23,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (24,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (25,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (26,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (27,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (28,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (29,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (30,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (31,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (32,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (33,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (34,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (35,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (36,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (37,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (38,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (39,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (40,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (41,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (42,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (43,2,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (44,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (45,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (46,1,'aporte_publicado',50,'2026-10-12 08:43:06');
INSERT INTO registro_puntos (id,usuario_id,accion,puntos,fecha) VALUES (47,1,'aporte_publicado',50,'2026-10-12 08:43:06');

-- usuario_insignias: 5 filas
INSERT INTO usuario_insignias (usuario_id,insignia_id,obtenida_en) VALUES (1,1,'2026-10-12 08:43:06');
INSERT INTO usuario_insignias (usuario_id,insignia_id,obtenida_en) VALUES (1,2,'2026-10-12 08:43:06');
INSERT INTO usuario_insignias (usuario_id,insignia_id,obtenida_en) VALUES (1,3,'2026-10-12 08:43:06');
INSERT INTO usuario_insignias (usuario_id,insignia_id,obtenida_en) VALUES (2,1,'2026-10-12 08:43:06');
INSERT INTO usuario_insignias (usuario_id,insignia_id,obtenida_en) VALUES (2,2,'2026-10-12 08:43:06');
