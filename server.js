const express = require("express");
const mysql = require("mysql");

const cors = require("cors");

const app = express();
// Habilitar CORS para todas las rutas

app.use(cors({ origin: "http://localhost:3000" }));
// Configuración de la conexión a la base de datos
const db = mysql.createConnection({
  host: "localhost",
  user: "root", // Reemplaza con tu usuario de MySQL
  password: "abcd1234", // Reemplaza con tu contraseña de MySQL
  database: "productos_db", // Reemplaza con el nombre de tu base de datos
});

// Conectar a la base de datos
db.connect((err) => {
  if (err) {
    console.error("Error de conexión a la base de datos:", err);
    return;
  }
  console.log("Conexión a la base de datos establecida");
});

// Ruta para obtener productos
app.get("/productos", (req, res) => {
  // Consultar productos desde la base de datos
  const consulta = "SELECT * FROM productos";

  db.query(consulta, (error, resultados) => {
    if (error) {
      console.error(
        "Error al obtener productos desde la base de datos:",
        error
      );
      res.status(500).json({ error: "Error interno del servidor" });
      return;
    }

    // Enviar la lista de productos como respuesta
    res.json(resultados);
  });
});

app.get("/clientes", (req, res) => {
  // Consultar productos desde la base de datos
  const consulta = "SELECT * FROM clientes";

  db.query(consulta, (error, resultados) => {
    if (error) {
      console.error(
        "Error al obtener productos desde la base de datos:",
        error
      );
      res.status(500).json({ error: "Error interno del servidor" });
      return;
    }

    // Enviar la lista de productos como respuesta
    res.json(resultados);
  });
});
// Otros manejadores de rutas y configuraciones...
app.get("/ordenes", (req, res) => {
  // Consultar productos desde la base de datos
  const consulta = "SELECT * FROM ordenes";

  db.query(consulta, (error, resultados) => {
    if (error) {
      console.error(
        "Error al obtener productos desde la base de datos:",
        error
      );
      res.status(500).json({ error: "Error interno del servidor" });
      return;
    }

    // Enviar la lista de productos como respuesta
    res.json(resultados);
  });
});

app.get("/empresa", (req, res) => {
  // Consultar productos desde la base de datos
  const consulta = "SELECT * FROM empresa";

  db.query(consulta, (error, resultados) => {
    if (error) {
      console.error(
        "Error al obtener productos desde la base de datos:",
        error
      );
      res.status(500).json({ error: "Error interno del servidor" });
      return;
    }

    // Enviar la lista de productos como respuesta
    res.json(resultados);
  });
});
// Iniciar el servidor en el puerto 3000
const PORT = 3001;
app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});
