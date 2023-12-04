-- Drop existing database if it exists
DROP DATABASE IF EXISTS productos_db;

-- Create new database
CREATE DATABASE productos_db;

-- Use the new database
USE productos_db;

-- Create productos table
CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50) NOT NULL DEFAULT 'Otra'
);

-- Insert some data into productos
INSERT INTO productos (nombre, precio, categoria) VALUES
    ('Manzana', 2.5, 'Frutas'),
    ('Banana', 1.8, 'Frutas'),
    ('Zanahoria', 1.2, 'Verduras'),
    ('Tomate', 1.5, 'Verduras');

-- Create categorias table
CREATE TABLE IF NOT EXISTS categorias (
  nombreCategoria VARCHAR(255) NOT NULL,
  descripcion VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (nombreCategoria)
);

-- Insert categorias data (avoiding duplicates)
INSERT IGNORE INTO categorias (nombreCategoria, descripcion)
VALUES
  ('Frutas', 'Categoría de productos frutales'),
  ('Verduras', 'Categoría de productos vegetales');

-- Classify existing products as Frutas or Verduras
UPDATE productos
SET categoria = 'Frutas'
WHERE nombre IN ('Manzana', 'Banana');

UPDATE productos
SET categoria = 'Verduras'
WHERE nombre IN ('Zanahoria', 'Tomate');

-- Verify the product classification
SELECT nombre, categoria
FROM productos;

-- Create clientes table
CREATE TABLE IF NOT EXISTS clientes (
  clienteId INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NULL DEFAULT NULL,
  telefono VARCHAR(15) NULL DEFAULT NULL,
  direccion VARCHAR(255) NULL DEFAULT NULL,
  sucursal VARCHAR(255) NULL DEFAULT NULL,
  correoElectronico VARCHAR(255) NULL DEFAULT NULL,
 nit VARCHAR(255),
  PRIMARY KEY (clienteId)
);



-- Insert data into clientes table
INSERT INTO clientes (nombre, telefono, direccion, sucursal, correoElectronico,nit)
VALUES
  ('Angie', '12345', 'Direccion1', 'Sucursal1', 'correo_electronico','nit');

-- Create ordenes table with foreign key reference to clientes
CREATE TABLE IF NOT EXISTS ordenes (
  ordenId INT PRIMARY KEY AUTO_INCREMENT,
  clienteId INT NOT NULL,
  fechaPedido DATE NULL DEFAULT NULL,
  sucursal VARCHAR(255) NULL DEFAULT NULL,
  total DECIMAL(10,2) NULL DEFAULT NULL,
  FOREIGN KEY (clienteId) REFERENCES clientes (clienteId)
);

-- Tabla para productos seleccionados en una orden
CREATE TABLE IF NOT EXISTS productos_seleccionados (
  seleccionId INT PRIMARY KEY AUTO_INCREMENT,
  ordenId INT NOT NULL,
  productoId INT NOT NULL,
  cantidad INT NOT NULL,
  FOREIGN KEY (ordenId) REFERENCES ordenes (ordenId),
  FOREIGN KEY (productoId) REFERENCES productos (id)
);