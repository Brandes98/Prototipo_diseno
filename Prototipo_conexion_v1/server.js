const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json()); 
app.use(cors()); 


const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'abc123',  
  database: 'prototipo',
  port: 3306,
  ssl: {
    rejectUnauthorized: false  
  }
});

// Conectar a la base de datos
db.connect((err) => {
  if (err) {
    console.error('Error conectando a la base de datos:', err);
    return;
  }
  console.log('Conectado a MySQL');
});

// Endpoint para insertar datos
app.post('/insert', (req, res) => {
  const { nombre } = req.body; 

  if (!nombre) {
    return res.status(400).json({ error: 'El campo nombre es requerido' });
  }

  const query = 'INSERT INTO unidadmedida (Nombre) VALUES (?)';
  db.query(query, [nombre], (err, result) => {
    if (err) {
      return res.status(500).json({ error: 'Error al insertar en la base de datos' });
    }
    res.json({ message: 'Inserción exitosa', nombre: nombre });
  });
});

// Iniciar el servidor
app.listen(3000, () => {
  console.log('Servidor corriendo en el puerto 3000');
});

