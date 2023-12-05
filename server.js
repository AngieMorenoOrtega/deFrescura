const express = require("express");
const mysql = require("mysql");
const cors = require("cors");
const app = express();
// Habilitar CORS para todas las rutas
app.use(express.json());
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
app.post("/ordenes", (req, res) => {
  const { clienteId, sucursal, fechaPedido, total, productos } = req.body;
  console.log(productos);
  const ordenesQuery =
    "INSERT INTO ordenes (clienteId, sucursal, fechaPedido, total) VALUES (?, ?, ?, ?)";
  db.query(
    ordenesQuery,
    [clienteId, fechaPedido, sucursal, total],
    (ordenError, ordenResult) => {
      if (ordenError) {
        // Manejar el error
        console.error("orden error: " + ordenError);
        res.status(500).send("error en el servidor");
      } else {
        const ordenId = ordenResult.insertId;
        console.log(ordenId);
        // Ahora, puedes usar ordenId para la inserción en productos_seleccionados
        const productosSeleccionadosQuery = `
          INSERT INTO productos_seleccionados (ordenId, productoId, cantidad, nombre,subTotal)
          VALUES (?, ?, ?, ?,?)
        `;
        productos.forEach((element) => {
          // element.append("ordenId", ordenId);
          const { productoId, nombre, cantidad, subTotal } = element;
          db.query(
            productosSeleccionadosQuery,
            [ordenId, productoId, cantidad, nombre, subTotal],
            (productosError) => {
              if (productosError) {
                console.error(
                  "insercion en productos seleccionados fallida: " +
                    productosError
                );
                res.status(500).send("error en el servidor");
              } else {
                console.log("Inserción exitosa en productos_seleccionados");
                res
                  .status(200)
                  .json({ message: "Orden insertada correctamente" });
              }
            }
          );
        });
        // // Assuming productosSeleccionados is an array of objects with productoId, cantidad, nombre
        // const productosInsertValues = productos.map(
        //   ({ productoId, cantidad, nombre, subTotal }) => [
        //     ordenId, // Utilizar el ordenId obtenido
        //     productoId,
        //     cantidad,
        //     nombre,
        //     subTotal,
        //   ]
        // );
      }
    }
  );
});

const PORT = 3001;
app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});
