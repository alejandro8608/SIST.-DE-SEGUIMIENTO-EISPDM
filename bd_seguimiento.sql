/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;

CREATE TABLE `carrera` (
  `id_carrera` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` text CHARACTER SET utf8mb4 NOT NULL,
  PRIMARY KEY (`id_carrera`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `correcion` (
  `id_observacion` int(11) NOT NULL,
  `id_encargado` int(11) DEFAULT NULL,
  `fecha_correcion` date DEFAULT NULL,
  `detalle` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_observacion`),
  KEY `id_encargado` (`id_encargado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `egresado` (
  `id_egresado` int(11) NOT NULL,
  `ci` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombres` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `paterno` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `materno` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `celular` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `id_carrera` int(11) NOT NULL,
  PRIMARY KEY (`id_egresado`),
  KEY `id_carrera` (`id_carrera`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `entrega` (
  `id_tramite` int(11) NOT NULL,
  `id_encargado` int(11) DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL,
  PRIMARY KEY (`id_tramite`),
  KEY `id_encargado` (`id_encargado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `gestion` (
  `id_gestion` int(11) NOT NULL,
  `detalle` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_gestion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `observacion` (
  `id_observacion` int(11) NOT NULL,
  `id_tramite` int(11) DEFAULT NULL,
  `id_encargado` int(11) DEFAULT NULL,
  `detalle` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id_observacion`),
  KEY `id_tramite` (`id_tramite`),
  KEY `id_encargado` (`id_encargado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `recepcion` (
  `id_tramite` int(11) NOT NULL,
  `id_encargado` int(11) DEFAULT NULL,
  `fecha_recepcion` date DEFAULT NULL,
  PRIMARY KEY (`id_tramite`),
  KEY `id_encargado` (`id_encargado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `responsable` (
  `id_responsable` int(11) NOT NULL,
  `ci` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombres` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `paterno` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `materno` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `usuario` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `item` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_responsable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `id_encargado` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  KEY `id_tipo` (`id_tipo`),
  KEY `id_encargado` (`id_encargado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `tipo` (
  `id_tipo` int(11) NOT NULL,
  `tipo` varchar(50) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `tramite` (
  `id_tramite` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo` int(11) DEFAULT NULL,
  `id_egresado` int(11) DEFAULT NULL,
  `id_encargado` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_gestion` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id_tramite`),
  KEY `id_tipo` (`id_tipo`),
  KEY `id_egresado` (`id_egresado`),
  KEY `id_encargado` (`id_encargado`),
  KEY `id_gestion` (`id_gestion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE `validacion` (
  `id_tramite` int(11) NOT NULL,
  `id_encargado` int(11) DEFAULT NULL,
  `fecha_validacion` date NOT NULL,
  PRIMARY KEY (`id_tramite`),
  KEY `id_encargado` (`id_encargado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


ALTER TABLE `correcion`
ADD CONSTRAINT `correcion_ibfk_1` FOREIGN KEY (`id_observacion`) REFERENCES `observacion` (`id_observacion`),
ADD CONSTRAINT `correcion_ibfk_2` FOREIGN KEY (`id_encargado`) REFERENCES `responsable` (`id_responsable`);

ALTER TABLE `egresado`
ADD CONSTRAINT `egresado_ibfk_1` FOREIGN KEY (`id_carrera`) REFERENCES `carrera` (`id_carrera`) ON UPDATE CASCADE;

ALTER TABLE `entrega`
ADD CONSTRAINT `entrega_ibfk_1` FOREIGN KEY (`id_tramite`) REFERENCES `tramite` (`id_tramite`),
ADD CONSTRAINT `entrega_ibfk_2` FOREIGN KEY (`id_encargado`) REFERENCES `responsable` (`id_responsable`);

ALTER TABLE `observacion`
ADD CONSTRAINT `observacion_ibfk_1` FOREIGN KEY (`id_tramite`) REFERENCES `tramite` (`id_tramite`),
ADD CONSTRAINT `observacion_ibfk_2` FOREIGN KEY (`id_encargado`) REFERENCES `responsable` (`id_responsable`);

ALTER TABLE `recepcion`
ADD CONSTRAINT `recepcion_ibfk_1` FOREIGN KEY (`id_encargado`) REFERENCES `responsable` (`id_responsable`),
ADD CONSTRAINT `recepcion_ibfk_2` FOREIGN KEY (`id_tramite`) REFERENCES `tramite` (`id_tramite`);

ALTER TABLE `rol`
ADD CONSTRAINT `rol_ibfk_1` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`),
ADD CONSTRAINT `rol_ibfk_2` FOREIGN KEY (`id_encargado`) REFERENCES `responsable` (`id_responsable`);

ALTER TABLE `tramite`
ADD CONSTRAINT `tramite_ibfk_1` FOREIGN KEY (`id_tipo`) REFERENCES `tipo` (`id_tipo`),
ADD CONSTRAINT `tramite_ibfk_2` FOREIGN KEY (`id_egresado`) REFERENCES `egresado` (`id_egresado`),
ADD CONSTRAINT `tramite_ibfk_3` FOREIGN KEY (`id_gestion`) REFERENCES `gestion` (`id_gestion`),
ADD CONSTRAINT `tramite_ibfk_4` FOREIGN KEY (`id_encargado`) REFERENCES `responsable` (`id_responsable`);

ALTER TABLE `validacion`
ADD CONSTRAINT `validacion_ibfk_1` FOREIGN KEY (`id_tramite`) REFERENCES `tramite` (`id_tramite`),
ADD CONSTRAINT `validacion_ibfk_2` FOREIGN KEY (`id_encargado`) REFERENCES `responsable` (`id_responsable`);


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
