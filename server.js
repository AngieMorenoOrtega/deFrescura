const express = require("express");
const mysql = require("mysql");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

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
app.post('/ordenes', (req, res) => {
  // URL a la que se realizará la solicitud POST
  const urlDestino = 'https://localhost3001/ordenes';

  // Datos que se enviarán en la solicitud POST
  const datos = req.body;

  // Configuración de la solicitud POST
  const opciones = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(datos),
  };

  // Realizar la solicitud POST utilizando node-fetch
  fetch(urlDestino, opciones)
    .then(respuesta => {
      if (!respuesta.ok) {
        throw new Error(`Error en la solicitud POST. Código de estado: ${respuesta.status}`);
      }
      return respuesta.json();
    })
    .then(data => {
      // Manejar la respuesta exitosa
      console.log('Solicitud POST exitosa:', data);
      res.status(200).json(data);
    })
    .catch(error => {
      // Manejar errores
      console.error('Error al realizar la solicitud POST:', error.message);
      res.status(500).json({ error: 'Error en el servidor' });
    });
});

// Iniciar el servidor en el puerto 3000
const PORT = 3001;
app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});
