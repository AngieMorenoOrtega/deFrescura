DROP DATABASE IF EXISTS productos_db;
DROP DATABASE IF EXISTS tienda_db;

-- Conectar a MySQL
CREATE DATABASE IF NOT EXISTS productos_db;
USE productos_db;

-- Crear tabla de productos
CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

-- Insertar algunos datos
INSERT INTO productos (nombre, precio) VALUES
    ('Manzana', 2.5),
    ('Banana', 1.8),
    ('Zanahoria', 1.2),
    ('Tomate', 1.5);

ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'abcd1234';
-- Insertar categorías de frutas y verduras (evitando duplicados)
-- Conectar a MySQL y seleccionar la base de datos
USE productos_db;

-- Crear la tabla de categorías
CREATE TABLE IF NOT EXISTS `categorias` (
  `nombreCategoria` VARCHAR(255) NOT NULL,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`nombreCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- Insertar categorías de frutas y verduras (evitando duplicados)
INSERT IGNORE INTO categorias (nombreCategoria, descripcion)
VALUES
  ('Frutas', 'Categoría de productos frutales'),
  ('Verduras', 'Categoría de productos vegetales');
-- Agregar la columna categoria a la tabla de productos
ALTER TABLE productos
ADD COLUMN categoria VARCHAR(50) NOT NULL DEFAULT 'Otra';
-- Clasificar los productos existentes como frutas o verduras
UPDATE productos
SET categoria = 'Frutas'
WHERE nombre IN ('Manzana', 'Banana');

UPDATE productos
SET categoria = 'Verduras'
WHERE nombre IN ('Zanahoria', 'Tomate');
-- Verificar la clasificación de productos
SELECT nombre, categoria
FROM productos;

