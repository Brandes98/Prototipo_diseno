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

// Conexión
db.connect((err) => {
  if (err) {
    console.error('Error conectando a la base de datos:', err);
    return;
  }
  console.log('Conectado a MySQL');
});

////////////// Endpoints //////////////
/////// Cuenta ///////
// Registrar cuenta
app.post('/cuenta/registrar', (req, res) => {
  const { nombre, correo, contrasena } = req.body;

  if (!nombre || !correo || !contrasena) {
    return res.status(400).json({ error: 'Todos los campos son requeridos' });
  }

  const query = 'INSERT INTO Cuenta (PrimerNombre, CorreoElectronico, Clave) VALUES (?, ?, ?)';
  db.query(query, [nombre, correo, contrasena], (err) => {
    if (err) {
      return res.status(500).json({ error: 'Error al insertar en la base de datos' });
    }
    res.json({ message: 'Usuario registrado', nombre: nombre });
  });
});

// Iniciar sesión
app.post('/cuenta/inicio_sesion', (req, res) => {
  const { correo, contrasena } = req.body;

  if (!correo || !contrasena) {
    return res.status(400).json({ error: 'Todos los campos son requeridos' });
  }

  const query = 'SELECT PrimerNombre FROM Cuenta WHERE CorreoElectronico = ? AND Clave = ?';
  db.query(query, [correo, contrasena], (err, result) => {
    if (err) {
      return res.status(500).json({ error: 'Error al consultar la base de datos' });
    }
    if (result.length === 0) {
      return res.status(401).json({ error: 'Correo o contraseña incorrectos' });
    }
    res.json({ message: 'Inicio de sesión exitoso'});
  });
});

// Olvidé mi contraseña
app.post('/cuenta/olvide_contrasena', (req, res) => {
  const { correo } = req.body;

  if (!correo) {
    return res.status(400).json({ error: 'El correo es requerido' });
  }

  const query = 'SELECT PrimerNombre FROM Cuenta WHERE CorreoElectronico = ?';
  db.query(query, [correo], (err, result) => {
    if (err) {
      return res.status(500).json({ error: 'Error al consultar la base de datos' });
    }
    if (result.length === 0) {
      return res.status(404).json({ error: 'Correo no registrado' });
    }
    res.json({ message: 'Correo enviado a ' + correo });
  });
});

// Bloquear cuenta
app.put('/cuenta/bloquear', (req, res) => {
  const { IDCuenta } = req.body;

  if (!IDCuenta) {
    return res.status(400).json({ error: 'El ID de la cuenta es requerido' });
  }

  const query = 'UPDATE Cuenta SET Estado = 0 WHERE IDCuenta = ?';
  db.query(query, [IDCuenta], (err, result) => {
    if (err) {
      return res.status(500).json({ error: 'Error al actualizar en la base de datos' });
    }
    res.json({ message: 'Cuenta bloqueada', IDCuenta: IDCuenta });
  });
});
  

/////// Comentarios ///////
// Obtener comentarios privados
app.get('/comentarios/privados', (req, res) => {
  const query = 'SELECT C.IDComentario, C.Comentario, C.Estado, CC.PrimerNombre, CC.PrimerApellido'+
                'FROM Comentario AS C JOIN Cuenta AS CC ON Comentario.IDCuenta = Cuenta.IDCuenta'+
                'WHERE C.Estado = 0;';
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Error al obtener los datos de la base de datos' });
    }
    res.json(results);  // Enviar los datos obtenidos como respuesta en formato JSON
  });
});

// Obtener comentarios públicos
app.get('/comentarios/publicos', (req, res) => {
  const query = 'SELECT C.IDComentario, C.Comentario, C.Estado, CC.PrimerNombre, CC.PrimerApellido'+
                'FROM Comentario AS C JOIN Cuenta AS CC ON Comentario.IDCuenta = Cuenta.IDCuenta'+
                'WHERE C.Estado = 1;';
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Error al obtener los datos de la base de datos' });
    }
    res.json(results);  // Enviar los datos obtenidos como respuesta en formato JSON
  });
});

// Crear comentario
app.post('/comentario/crear', (req, res) => {
  const { comentario, idCuenta } = req.body;

  if (!comentario || !idCuenta) {
    return res.status(400).json({ error: 'Todos los campos son requeridos' });
  }

  const query = 'INSERT INTO Comentario (Comentario, Estado, IDCuenta) VALUES (?, 0, ?)';
  db.query(query, [comentario, idCuenta], (err, result) => {
    if (err) {
      return res.status(500).json({ error: 'Error al insertar en la base de datos' });
    }
    res.json({ message: 'Comentario creado', comentario: comentario });
  });
});

// Aprobar comentario
app.put('/comentario/aprobar', (req, res) => {
  const { idComentario } = req.body;

  if (!idComentario) {
    return res.status(400).json({ error: 'El ID del comentario es requerido' });
  }

  const query = 'UPDATE Comentario SET Estado = 1 WHERE IDComentario = ?';
  db.query(query, [idComentario], (err, result) => {
    if (err) {
      return res.status(500).json({ error: 'Error al actualizar en la base de datos' });
    }
    res.json({ message: 'Comentario aprobado', idComentario: idComentario });
  });
});

// Rechazar comentario
app.put('/comentario/rechazar', (req, res) => {
  const { idComentario } = req.body;

  if (!idComentario) {
    return res.status(400).json({ error: 'El ID del comentario es requerido' });
  }

  const query = 'DELETE FROM Comentario WHERE IDComentario = ?';
  db.query(query, [idComentario], (err, result) => {
    if (err) {
      return res.status(500).json({ error: 'Error al actualizar en la base de datos' });
    }
    res.json({ message: 'Comentario rechazado', idComentario: idComentario });
  });
});

/////// Cotización Determinada ///////
// Obtener estilos
app.get('/estilos', (req, res) => {
  const query = 'SELECT Nombre FROM Estilo;';

  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Error al obtener los datos de la base de datos' });
    }
    res.json(results);  // Enviar los datos obtenidos como respuesta en formato JSON
  });
});

// Obtener categorías trabajos
app.get('/categorias', (req, res) => {
  const query = 'SELECT Nombre FROM TipoTrabajo;';

  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Error al obtener los datos de la base de datos' });
    }
    res.json(results);  // Enviar los datos obtenidos como respuesta en formato JSON
  });
});

// Obtener paises
app.get('/paises', (req, res) => {
  const query = 'SELECT Pais FROM Pais;'; // Ajusta esta consulta según tu esquema de base de datos
  db.query(query, (err, results) => {
      if (err) {
          return res.status(500).json({ error: 'Error al obtener los datos de la base de datos' });
      }
      res.json(results);
  });
});

// Obtener provincias
app.get('/provincias', (req, res) => {
  const { pais } = req.query;
  const query = 'SELECT Provincia FROM Provincia';
  db.query(query, [pais], (err, results) => {
      if (err) {
          return res.status(500).json({ error: 'Error al obtener los datos de la base de datos' });
      }
      res.json(results);
  });
});

// Obtener cantones
app.get('/cantones', (req, res) => {
  const { provincia } = req.query;
  const query = 'SELECT Canton FROM Canton'; // Ajusta esta consulta según tu esquema de base de datos
  db.query(query, [provincia], (err, results) => {
      if (err) {
          return res.status(500).json({ error: 'Error al obtener los datos de la base de datos' });
      }
      res.json(results);
  });
});

// Obtener distritos
app.get('/distritos', (req, res) => {
  const { canton } = req.query;
  const query = 'SELECT Distrito FROM Distrito'; // Ajusta esta consulta según tu esquema de base de datos
  db.query(query, [canton], (err, results) => {
      if (err) {
          return res.status(500).json({ error: 'Error al obtener los datos de la base de datos' });
      }
      res.json(results);
  });
});

// Servidor
app.listen(3000, () => {
  console.log('Servidor corriendo en el puerto 3000');
});