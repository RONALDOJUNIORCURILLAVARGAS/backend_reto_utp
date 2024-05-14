/*
 Navicat Premium Data Transfer

 Source Server         : UTP_ANALISTA_PROGRAMADOR
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : bd_reto_analista

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 14/05/2024 04:57:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alumno
-- ----------------------------
DROP TABLE IF EXISTS `alumno`;
CREATE TABLE `alumno`  (
  `alumno_id` int NOT NULL AUTO_INCREMENT,
  `alumno_nombres` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alumno_apellidos` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alumno_codigo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alumno_fecha_creacion` timestamp NULL DEFAULT NULL,
  `alumno_fecha_actualizacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`alumno_id`) USING BTREE,
  UNIQUE INDEX `fk_unique_alumno_codigo`(`alumno_codigo` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of alumno
-- ----------------------------
INSERT INTO `alumno` VALUES (1, 'Rosa Lupita', 'Sanchez Correa', '201700001', NULL, NULL);
INSERT INTO `alumno` VALUES (2, 'Carlos', 'Carhuas Trinidad', '201700002', NULL, NULL);

-- ----------------------------
-- Table structure for curso
-- ----------------------------
DROP TABLE IF EXISTS `curso`;
CREATE TABLE `curso`  (
  `curso_id` int NOT NULL AUTO_INCREMENT,
  `curso_nombre` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `curso_fecha_creacion` timestamp NULL DEFAULT NULL,
  `curso_fecha_actualizacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`curso_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of curso
-- ----------------------------
INSERT INTO `curso` VALUES (1, 'Álgebra lineal', '2024-05-13 10:06:53', '2024-05-13 10:06:56');
INSERT INTO `curso` VALUES (2, 'Física Cuántica', '2024-05-13 10:06:59', '2024-05-13 10:07:02');
INSERT INTO `curso` VALUES (3, 'Matemática Básica', '2024-05-13 10:07:05', '2024-05-13 10:07:08');

-- ----------------------------
-- Table structure for curso_alumno
-- ----------------------------
DROP TABLE IF EXISTS `curso_alumno`;
CREATE TABLE `curso_alumno`  (
  `curso_alumno_id` int NOT NULL AUTO_INCREMENT,
  `curso_id` int NOT NULL,
  `alumno_id` int NOT NULL,
  PRIMARY KEY (`curso_alumno_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of curso_alumno
-- ----------------------------
INSERT INTO `curso_alumno` VALUES (1, 1, 2);
INSERT INTO `curso_alumno` VALUES (2, 1, 1);
INSERT INTO `curso_alumno` VALUES (3, 2, 1);

-- ----------------------------
-- Table structure for curso_docente
-- ----------------------------
DROP TABLE IF EXISTS `curso_docente`;
CREATE TABLE `curso_docente`  (
  `curso_docente_id` int NOT NULL AUTO_INCREMENT,
  `curso_id` int NOT NULL,
  `usuario_docente_id` int NOT NULL,
  PRIMARY KEY (`curso_docente_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of curso_docente
-- ----------------------------
INSERT INTO `curso_docente` VALUES (1, 1, 1);
INSERT INTO `curso_docente` VALUES (2, 2, 1);

-- ----------------------------
-- Table structure for estado_solicitud
-- ----------------------------
DROP TABLE IF EXISTS `estado_solicitud`;
CREATE TABLE `estado_solicitud`  (
  `estado_solicitud_id` int NOT NULL AUTO_INCREMENT,
  `estado_solicitud_valor` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`estado_solicitud_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of estado_solicitud
-- ----------------------------
INSERT INTO `estado_solicitud` VALUES (1, 'Pendiente');
INSERT INTO `estado_solicitud` VALUES (2, 'Aprobado');
INSERT INTO `estado_solicitud` VALUES (3, 'Rechazado');

-- ----------------------------
-- Table structure for nota
-- ----------------------------
DROP TABLE IF EXISTS `nota`;
CREATE TABLE `nota`  (
  `nota_id` int NOT NULL AUTO_INCREMENT,
  `nota_valor` double NOT NULL,
  `curso_alumno_id` int NOT NULL,
  `tipo_evaluacion_id` int NOT NULL,
  `curso_docente_id` int NOT NULL,
  PRIMARY KEY (`nota_id`) USING BTREE,
  INDEX `fk_nta_cursa_alumno_curso_alumno_id`(`curso_alumno_id` ASC) USING BTREE,
  CONSTRAINT `fk_nota_tipo_evaluacion_id` FOREIGN KEY (`tipo_evaluacion_id`) REFERENCES `tipo_evaluacion` (`tipo_evaluacion_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_nt_curso_docente_id` FOREIGN KEY (`curso_docente_id`) REFERENCES `curso_docente` (`curso_docente_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_nta_cursa_alumno_curso_alumno_id` FOREIGN KEY (`curso_alumno_id`) REFERENCES `curso_alumno` (`curso_alumno_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nota
-- ----------------------------
INSERT INTO `nota` VALUES (1, 10, 2, 1, 2);
INSERT INTO `nota` VALUES (5, 5, 2, 1, 1);
INSERT INTO `nota` VALUES (6, 20, 1, 1, 1);

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol`  (
  `rol_id` int NOT NULL AUTO_INCREMENT,
  `rol_nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`rol_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rol
-- ----------------------------
INSERT INTO `rol` VALUES (1, 'docente');
INSERT INTO `rol` VALUES (2, 'coordinador');

-- ----------------------------
-- Table structure for solicitud
-- ----------------------------
DROP TABLE IF EXISTS `solicitud`;
CREATE TABLE `solicitud`  (
  `solicitud_id` int NOT NULL AUTO_INCREMENT,
  `usuario_docente_id` int NOT NULL,
  `estado_solicitud_id` int NOT NULL,
  `usuario_coordinador_id` int NOT NULL,
  `solicitud_nota_nueva` double NOT NULL,
  `solicitud_archivo_evidencia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nota_id` int NOT NULL,
  PRIMARY KEY (`solicitud_id`) USING BTREE,
  CONSTRAINT `fk_slc_estado_slc_id` FOREIGN KEY (`estado_solicitud_id`) REFERENCES `estado_solicitud` (`estado_solicitud_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_solicitud_cod_id` FOREIGN KEY (`usuario_coordinador_id`) REFERENCES `usuario` (`usuario_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_solicitud_doc_id` FOREIGN KEY (`usuario_docente_id`) REFERENCES `usuario` (`usuario_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_solicitud_nts_id` FOREIGN KEY (`nota_id`) REFERENCES `nota` (`nota_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of solicitud
-- ----------------------------
INSERT INTO `solicitud` VALUES (1, 1, 2, 2, 15, 'http://localhost:4001/uploads/prueba-examen.jpg', 5);
INSERT INTO `solicitud` VALUES (2, 1, 3, 2, 20, 'http://localhost:4001/uploads/prueba-examen.jpg', 5);
INSERT INTO `solicitud` VALUES (4, 1, 2, 2, 12, 'http://localhost:4001/uploads/prueba-examen.jpg', 5);
INSERT INTO `solicitud` VALUES (5, 1, 3, 2, 10, 'http://localhost:4001/uploads/prueba-examen.jpg', 6);
INSERT INTO `solicitud` VALUES (6, 1, 2, 2, 10, 'http://localhost:4001/uploads/prueba-examen.jpg', 5);
INSERT INTO `solicitud` VALUES (7, 1, 1, 2, 15, 'http://localhost:4001/uploads/prueba-examen.jpg', 5);

-- ----------------------------
-- Table structure for tipo_evaluacion
-- ----------------------------
DROP TABLE IF EXISTS `tipo_evaluacion`;
CREATE TABLE `tipo_evaluacion`  (
  `tipo_evaluacion_id` int NOT NULL AUTO_INCREMENT,
  `tipo_evaluacion_nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`tipo_evaluacion_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_evaluacion
-- ----------------------------
INSERT INTO `tipo_evaluacion` VALUES (1, 'Práctica 1');
INSERT INTO `tipo_evaluacion` VALUES (2, 'Práctica 2');
INSERT INTO `tipo_evaluacion` VALUES (3, 'Práctica 3');
INSERT INTO `tipo_evaluacion` VALUES (4, 'Examen Parcial');
INSERT INTO `tipo_evaluacion` VALUES (5, 'Examen Final');

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `usuario_id` int NOT NULL AUTO_INCREMENT,
  `usuario_nombres` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `usuario_alias` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `usuario_clave` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `usuario_fecha_creacion` timestamp NULL DEFAULT NULL,
  `usuario_fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `rol_id` int NOT NULL,
  `usuario_apellidos` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`usuario_id`) USING BTREE,
  UNIQUE INDEX `usr_email_unique`(`usuario_alias` ASC) USING BTREE,
  CONSTRAINT `fk_usr_rol_id` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES (1, 'ronaldo junior', 'ronaldo', '$2b$09$lGdt6RGdkDVwaBd7txpAJOqWMVLrIi6N89E.JentGl1dyaUEB9UVC', '2024-05-12 23:04:19', '2024-05-12 23:04:19', 1, 'test');
INSERT INTO `usuario` VALUES (2, 'Ruben arteria', 'ruben1996', '$2b$09$idrZwGX3hkRhwNllyELDfOZMV7UDEjV.o0HpaLfL7sIwS0xLEHkP6', '2024-05-12 23:08:34', '2024-05-12 23:08:34', 2, 'test');

-- ----------------------------
-- View structure for buscarcoordinadorvista
-- ----------------------------
DROP VIEW IF EXISTS `buscarcoordinadorvista`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `buscarcoordinadorvista` AS SELECT * FROM usuario
WHERE rol_id = 2
LIMIT 1 ;

-- ----------------------------
-- View structure for usuariorolvista
-- ----------------------------
DROP VIEW IF EXISTS `usuariorolvista`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `usuariorolvista` AS SELECT u.*, r.rol_nombre
FROM usuario AS u
INNER JOIN rol AS r ON u.rol_id = r.rol_id ;

-- ----------------------------
-- Procedure structure for FiltroAlumnosDocente
-- ----------------------------
DROP PROCEDURE IF EXISTS `FiltroAlumnosDocente`;
delimiter ;;
CREATE PROCEDURE `FiltroAlumnosDocente`(IN tipo_evaluacion_id_param INT,
    IN curso_docente_id_param INT)
BEGIN
    SELECT DISTINCT
        a.alumno_nombres,
        a.alumno_apellidos,
        a.alumno_codigo,
        n.nota_valor,
        te.tipo_evaluacion_id,
        te.tipo_evaluacion_nombre,
        (SELECT estado_solicitud_id FROM solicitud WHERE nota_id = n.nota_id ORDER BY solicitud_id DESC LIMIT 1) AS estado_solicitud_id,
        (SELECT MAX(solicitud_id) FROM solicitud WHERE nota_id = n.nota_id) AS solicitud_id,
        n.nota_id
    FROM 
        usuario AS u 
    INNER JOIN 
        curso_docente AS cd ON cd.usuario_docente_id = u.usuario_id 
    INNER JOIN 
        nota AS n ON n.curso_docente_id = cd.curso_docente_id
    INNER JOIN 
        tipo_evaluacion AS te ON te.tipo_evaluacion_id = n.tipo_evaluacion_id
    INNER JOIN 
        curso_alumno AS ca ON n.curso_alumno_id = ca.curso_alumno_id
    INNER JOIN 
        alumno AS a ON a.alumno_id = ca.alumno_id
    LEFT JOIN 
        solicitud AS s ON s.nota_id = n.nota_id
    WHERE 
        te.tipo_evaluacion_id = tipo_evaluacion_id_param
        AND cd.curso_docente_id = curso_docente_id_param;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for InsertarSolicitud
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertarSolicitud`;
delimiter ;;
CREATE PROCEDURE `InsertarSolicitud`(IN usuario_docente_id_param INT,
    IN usuario_coordinador_id_param INT,
    IN solicitud_nota_nueva_param VARCHAR(255),
    IN solicitud_archivo_evidencia_param VARCHAR(255),
    IN nota_id_param INT)
BEGIN
    INSERT INTO solicitud 
    (usuario_docente_id, estado_solicitud_id, usuario_coordinador_id, solicitud_nota_nueva, solicitud_archivo_evidencia, nota_id)
    VALUES 
    (usuario_docente_id_param, 1, usuario_coordinador_id_param, solicitud_nota_nueva_param, solicitud_archivo_evidencia_param, nota_id_param);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ObtenerCursosPorUsuarioYRol
-- ----------------------------
DROP PROCEDURE IF EXISTS `ObtenerCursosPorUsuarioYRol`;
delimiter ;;
CREATE PROCEDURE `ObtenerCursosPorUsuarioYRol`(IN p_usuario_id INT, IN p_rol_id INT)
BEGIN
    SELECT c.curso_nombre, cd.curso_docente_id 
    FROM usuario AS u 
    INNER JOIN curso_docente AS cd ON u.usuario_id = cd.usuario_docente_id 
    INNER JOIN curso AS c ON cd.curso_id = c.curso_id 
    WHERE u.usuario_id = p_usuario_id AND u.rol_id = p_rol_id;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
