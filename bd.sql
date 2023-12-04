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
  PRIMARY KEY (clienteId)
);

-- Insert data into clientes table
INSERT INTO clientes (nombre, telefono, direccion, sucursal, correoElectronico)
VALUES
  ('Angie', '12345', 'Direccion1', 'Sucursal1', 'correo_electronico');

-- Create ordenes table with foreign key reference to clientes
CREATE TABLE IF NOT EXISTS ordenes (
  ordenId INT NOT NULL AUTO_INCREMENT,
  clienteId INT NOT NULL,
  fechaPedido DATE NULL DEFAULT NULL,
  sucursal VARCHAR(255) NULL DEFAULT NULL,
  total DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (ordenId),
  INDEX clienteId (clienteId ASC),
  CONSTRAINT ordenes_ibfk_1
    FOREIGN KEY (clienteId)
    REFERENCES clientes (clienteId)
);
   CREATE TABLE IF NOT EXISTS empresa (
      id INT PRIMARY KEY AUTO_INCREMENT,
      nombre VARCHAR(255) NOT NULL,
      nit VARCHAR(255) NOT NULL,
      direccion VARCHAR(255) NOT NULL,
      telefono VARCHAR(15),
      email VARCHAR(255),
      imagen VARCHAR(255)
    );
    INSERT INTO empresa (nombre,nit, direccion, telefono, email,imagen) VALUES
('Empresa 1','1234556778', 'Calle 123', '123456789', 'empresa1@example.com','https://i.ibb.co/xD21Gr7/Captura-de-pantalla-2023-12-03-193838.png')

