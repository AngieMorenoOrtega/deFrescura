
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `productos_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `productos_db` ;

CREATE TABLE IF NOT EXISTS `productos_db`.`categorias` (
  `nombreCategoria` VARCHAR(255) NOT NULL,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`nombreCategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `productos_db`.`clientes` (
  `clienteId` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NULL DEFAULT NULL,
  `telefono` VARCHAR(15) NULL DEFAULT NULL,
  `direccion` VARCHAR(255) NULL DEFAULT NULL,
  `sucursal` VARCHAR(255) NULL DEFAULT NULL,
  `correoElectronico` VARCHAR(255) NULL DEFAULT NULL,
  `nit` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`clienteId`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `productos_db`.`empresa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `nit` VARCHAR(255) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(15) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `imagen` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `productos_db`.`ordenes` (
  `ordenId` INT NOT NULL AUTO_INCREMENT,
  `clienteId` INT NOT NULL,
  `fechaPedido` DATE NULL DEFAULT NULL,
  `sucursal` VARCHAR(255) NULL DEFAULT NULL,
  `total` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ordenId`),
  INDEX `clienteId` (`clienteId` ASC) VISIBLE,
  CONSTRAINT `ordenes_ibfk_1`
    FOREIGN KEY (`clienteId`)
    REFERENCES `productos_db`.`clientes` (`clienteId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `productos_db`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `categoria` VARCHAR(50) NOT NULL DEFAULT 'Otra',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `productos_db`.`productos_seleccionados` (
  `seleccionId` INT NOT NULL AUTO_INCREMENT,
  `ordenId` INT NOT NULL,
  `productoId` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `seleccionado` TINYINT(1) NOT NULL,
  `nombre` VARCHAR(255) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`seleccionId`),
  INDEX `ordenId` (`ordenId` ASC) VISIBLE,
  INDEX `productoId` (`productoId` ASC) VISIBLE,
  CONSTRAINT `productos_seleccionados_ibfk_1`
    FOREIGN KEY (`ordenId`)
    REFERENCES `productos_db`.`ordenes` (`ordenId`),
  CONSTRAINT `productos_seleccionados_ibfk_2`
    FOREIGN KEY (`productoId`)
    REFERENCES `productos_db`.`productos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
-- Desactivar comprobaciones de clave foránea temporalmente
SET FOREIGN_KEY_CHECKS = 0;

-- Modificar la estructura de la tabla
ALTER TABLE `productos_db`.`productos_seleccionados`
DROP COLUMN `seleccionado`,
DROP COLUMN `total`;

-- Activar comprobaciones de clave foránea nuevamente
SET FOREIGN_KEY_CHECKS = 1;

-- Desactivar comprobaciones de clave foránea temporalmente
SET FOREIGN_KEY_CHECKS = 0;

-- Modificar la estructura de la tabla
ALTER TABLE `productos_db`.`productos_seleccionados`
DROP COLUMN `seleccionId`;

-- Activar comprobaciones de clave foránea nuevamente
SET FOREIGN_KEY_CHECKS = 1;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
