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

app.get('/cotizaciones', (req, res) => {
  // Query for Cotizaciones Determinadas
  const queryDeterminadas = `
    SELECT 
    CD.IDCotizacionDet AS IDCotizacion,
    C.PrimerNombre,
    C.SegundoNombre,
    C.PrimerApellido,
    C.SegundoApellido,
    'Determinada' AS TipoCotizacion,
    TT.Nombre AS Categoria,
    E.Nombre AS Estilo,
    CD.Ancho,
    CD.Largo,
    CD.Traslado,
    CD.Costo,
    CONCAT(D.Distrito, ', ', CT.Canton, ', ', P.Provincia) AS Ubicacion,
    EC.Estado AS EstadoCotizacion,  -- Estado de la cotización
    CD.FechaRecibido
FROM 
    CotizacionDeterminada CD
JOIN 
    Cuenta C ON CD.IDCuenta = C.IDCuenta
JOIN 
    TipoTrabajo TT ON CD.IDTipoTrabajo = TT.IDTipoTrabajo
JOIN 
    Estilo E ON CD.IDEstilo = E.IDEstilo
JOIN 
    Distrito D ON C.IDDistrito = D.IDDistrito
JOIN 
    Canton CT ON D.IDCanton = CT.IDCanton
JOIN 
    Provincia P ON CT.IDProvincia = P.IDProvincia
LEFT JOIN 
    EstadoCotizacion EC ON CD.IDEstadoCotizacion = EC.IDEstadoCotizacion  -- Usar LEFT JOIN
ORDER BY 
    CD.FechaRecibido DESC;
  `;

  // Query for Cotizaciones Especiales
  const queryEspeciales = `
    SELECT
      CE.IDCotizacionEsp AS IDCotizacion,
      C.PrimerNombre,
      C.SegundoNombre,
      C.PrimerApellido,
      C.SegundoApellido,
      'Especial' AS TipoCotizacion,
      CE.Nombre AS NombreEspecial,
      CE.Descripcion,
      CE.Traslado,
      CE.Costo,
      EC.Estado AS EstadoCotizacion,  -- Agregamos el estado de la cotización
      CE.FechaRecibido
    FROM CotizacionEspecial CE
    JOIN Cuenta C ON CE.IDCuenta = C.IDCuenta
    LEFT JOIN EstadoCotizacion EC ON CE.IDEstadoCotizacion = EC.IDEstadoCotizacion  -- Relación con EstadoCotizacion
    ORDER BY CE.FechaRecibido DESC;
  `;

  // Execute both queries and combine results
  db.query(queryDeterminadas, (err, determinadasResults) => {
    if (err) {
      console.error('Error fetching determinadas:', err.sqlMessage || err); // Log the actual SQL error
      return res.status(500).json({ error: 'Error fetching cotizaciones determinadas' });
    }

    db.query(queryEspeciales, (err, especialesResults) => {
      if (err) {
        console.error('Error fetching especiales:', err.sqlMessage || err); // Log the actual SQL error
        return res.status(500).json({ error: 'Error fetching cotizaciones especiales' });
      }

      // Combine both results into one response
      const combinedResults = [...determinadasResults, ...especialesResults];
      res.json(combinedResults);
    });
  });
});
// Obtener cotizaciones especiales y determinadas por ID de cuenta
// Obtener cotizaciones de un usuario mediante su correo electrónico
app.get('/cotizacion', (req, res) => {
  const { correo } = req.query;

  if (!correo) {
      return res.status(400).json({ error: 'Correo electrónico es requerido' });
  }

  // Consulta para obtener el IDCuenta basado en el correo
  const queryCuenta = 'SELECT IDCuenta FROM Cuenta WHERE CorreoElectronico = ?';

  db.query(queryCuenta, [correo], (err, result) => {
      if (err) {
          return res.status(500).json({ error: 'Error al obtener el IDCuenta' });
      }

      if (result.length === 0) {
          return res.status(404).json({ error: 'Usuario no encontrado' });
      }

      const idCuenta = result[0].IDCuenta;

      // Consultas para obtener cotizaciones determinadas y especiales
      const queryCotizacionesDeterminadas = `
          SELECT 
              CD.IDCotizacionDet,
              TT.Nombre AS Categoria,
              E.Nombre AS Estilo,
              CD.Ancho,
              CD.Largo,
              CD.Costo,
              CONCAT(P.Pais, ', ', PRO.Provincia, ', ', C.Canton, ', ', D.Distrito) AS Ubicacion,
              CD.FechaRecibido
          FROM 
              CotizacionDeterminada CD
          JOIN 
              TipoTrabajo TT ON CD.IDTipoTrabajo = TT.IDTipoTrabajo
          JOIN 
              Estilo E ON CD.IDEstilo = E.IDEstilo
          JOIN 
              Cuenta CU ON CD.IDCuenta = CU.IDCuenta
          JOIN 
              Distrito D ON CU.IDDistrito = D.IDDistrito
          JOIN 
              Canton C ON D.IDCanton = C.IDCanton
          JOIN 
              Provincia PRO ON C.IDProvincia = PRO.IDProvincia
          JOIN 
              Pais P ON PRO.IDPais = P.IDPais
          WHERE 
              CD.IDCuenta = ?
          ORDER BY 
              CD.FechaRecibido DESC;
      `;

      const queryCotizacionesEspeciales = `
          SELECT 
              CE.IDCotizacionEsp,
              CE.Nombre,
              CE.Descripcion,
              CE.FechaRecibido
          FROM 
              CotizacionEspecial CE
          WHERE 
              CE.IDCuenta = ?
          ORDER BY 
              CE.FechaRecibido DESC;
      `;

      // Ejecutar las dos consultas
      db.query(queryCotizacionesDeterminadas, [idCuenta], (err, cotizacionesDeterminadas) => {
          if (err) {
              return res.status(500).json({ error: 'Error al obtener cotizaciones determinadas' });
          }

          db.query(queryCotizacionesEspeciales, [idCuenta], (err, cotizacionesEspeciales) => {
              if (err) {
                  return res.status(500).json({ error: 'Error al obtener cotizaciones especiales' });
              }

              // Responder con ambas listas
              res.json({
                  cotizacionesDeterminadas,
                  cotizacionesEspeciales
              });
          });
      });
  });
});
// Endpoint para estadísticas generales de cotizaciones
// Endpoint para estadísticas generales de cotizaciones
app.get('/estadisticas/cotizaciones/generales', (req, res) => {
  const query = `
    (SELECT 
    'Categoria' AS Aspecto,
    TT.Nombre AS Valor,
    COUNT(*) AS Cantidad
FROM 
    CotizacionDeterminada CD
JOIN 
    TipoTrabajo TT ON CD.IDTipoTrabajo = TT.IDTipoTrabajo
GROUP BY 
    TT.Nombre
ORDER BY 
    Cantidad DESC
LIMIT 1)

UNION ALL

(SELECT 
    'Estilo' AS Aspecto,
    E.Nombre AS Valor,
    COUNT(*) AS Cantidad
FROM 
    CotizacionDeterminada CD
JOIN 
    Estilo E ON CD.IDEstilo = E.IDEstilo
GROUP BY 
    E.Nombre
ORDER BY 
    Cantidad DESC
LIMIT 1)

UNION ALL

(SELECT 
    'Traslado' AS Aspecto,
    IF(CD.Traslado = 1, 'Con Traslado', 'Sin Traslado') AS Valor,
    COUNT(*) AS Cantidad
FROM 
    CotizacionDeterminada CD
GROUP BY 
    CD.Traslado
ORDER BY 
    Cantidad DESC
LIMIT 1)

UNION ALL

(SELECT 
    'Provincia' AS Aspecto,
    P.Provincia AS Valor,
    COUNT(*) AS Cantidad
FROM 
    Cuenta C
JOIN 
    Distrito D ON C.IDDistrito = D.IDDistrito
JOIN 
    Canton CT ON D.IDCanton = CT.IDCanton
JOIN 
    Provincia P ON CT.IDProvincia = P.IDProvincia
GROUP BY 
    P.Provincia
ORDER BY 
    Cantidad DESC
LIMIT 1)

UNION ALL

(SELECT 
    'Canton' AS Aspecto,
    CT.Canton AS Valor,
    COUNT(*) AS Cantidad
FROM 
    Cuenta C
JOIN 
    Distrito D ON C.IDDistrito = D.IDDistrito
JOIN 
    Canton CT ON D.IDCanton = CT.IDCanton
GROUP BY 
    CT.Canton
ORDER BY 
    Cantidad DESC
LIMIT 1)

UNION ALL

(SELECT 
    'Distrito' AS Aspecto,
    D.Distrito AS Valor,
    COUNT(*) AS Cantidad
FROM 
    Cuenta C
JOIN 
    Distrito D ON C.IDDistrito = D.IDDistrito
GROUP BY 
    D.Distrito
ORDER BY 
    Cantidad DESC
LIMIT 1);
  `;
  
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Error al obtener las estadísticas generales' });
    }
    res.json(results);
  });
});

// Endpoint para estadísticas por cliente
app.get('/estadisticas/cotizaciones/por_cliente', (req, res) => {
  const query = `
    (SELECT 
    C.PrimerNombre,
    C.PrimerApellido,
    'Categoria' AS Aspecto,
    TT.Nombre AS Valor,
    COUNT(*) AS Cantidad
FROM 
    CotizacionDeterminada CD
JOIN 
    TipoTrabajo TT ON CD.IDTipoTrabajo = TT.IDTipoTrabajo
JOIN 
    Cuenta C ON CD.IDCuenta = C.IDCuenta
GROUP BY 
    C.IDCuenta, TT.Nombre)

UNION ALL

(SELECT 
    C.PrimerNombre,
    C.PrimerApellido,
    'Estilo' AS Aspecto,
    E.Nombre AS Valor,
    COUNT(*) AS Cantidad
FROM 
    CotizacionDeterminada CD
JOIN 
    Estilo E ON CD.IDEstilo = E.IDEstilo
JOIN 
    Cuenta C ON CD.IDCuenta = C.IDCuenta
GROUP BY 
    C.IDCuenta, E.Nombre)

UNION ALL

(SELECT 
    C.PrimerNombre,
    C.PrimerApellido,
    'Traslado' AS Aspecto,
    IF(CD.Traslado = 1, 'Con Traslado', 'Sin Traslado') AS Valor,
    COUNT(*) AS Cantidad
FROM 
    CotizacionDeterminada CD
JOIN 
    Cuenta C ON CD.IDCuenta = C.IDCuenta
GROUP BY 
    C.IDCuenta, CD.Traslado)

ORDER BY 
    1, 2;

  `;
  
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Error al obtener las estadísticas por cliente' });
    }
    res.json(results);
  });
});
// Endpoint para cambiar estado de
app.put('/cotizacion/estado', (req, res) => {
  const { idCotizacion, tipoCotizacion, nuevoEstado } = req.body;

  if (!idCotizacion || !tipoCotizacion || !nuevoEstado) {
    return res.status(400).json({ error: 'Todos los campos son requeridos' });
  }

  // Primero, obtenemos el IDEstadoCotizacion basado en el nuevo estado
  const queryEstado = 'SELECT IDEstadoCotizacion FROM EstadoCotizacion WHERE Estado = ?';
  
  db.query(queryEstado, [nuevoEstado], (err, resultEstado) => {
    if (err) {
      return res.status(500).json({ error: 'Error al obtener el estado de la cotización' });
    }

    if (resultEstado.length === 0) {
      return res.status(404).json({ error: 'Estado no encontrado' });
    }

    const idEstadoCotizacion = resultEstado[0].IDEstadoCotizacion;

    // Ahora, actualizamos la cotización según sea determinada o especial
    let query;
    
    if (tipoCotizacion === 'determinada') {
      query = 'UPDATE CotizacionDeterminada SET IDEstadoCotizacion = ? WHERE IDCotizacionDet = ?';
    } else if (tipoCotizacion === 'especial') {
      query = 'UPDATE CotizacionEspecial SET IDEstadoCotizacion = ? WHERE IDCotizacionEsp = ?';
    } else {
      return res.status(400).json({ error: 'Tipo de cotización no válido' });
    }

    db.query(query, [idEstadoCotizacion, idCotizacion], (err, result) => {
      if (err) {
        return res.status(500).json({ error: 'Error al actualizar el estado de la cotización' });
      }
      res.json({ message: 'Estado de la cotización actualizado correctamente' });
    });
  });
});

// Servidor
app.listen(3000, () => {
  console.log('Servidor corriendo en el puerto 3000');
});
