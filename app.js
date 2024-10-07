////////////// Services //////////////
/////// Cuenta ///////
// Registrar cuenta
function registrarCuenta() {
    // Obtener los datos del formulario
    const nombre = document.getElementById('registrarNombre').value;
    const correo = document.getElementById('registrarCorreo').value;
    const contrasena = document.getElementById('registrarContrasena').value;

    // Verificar si los campos están vacíos
    if (!nombre || !correo || !contrasena) {
        alert('Todos los campos son requeridos');
        return;
    }

    // Realizar la petición
    fetch('http://localhost:3000/cuenta/registrar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ nombre, correo, contrasena })
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            alert('Usuario registrado: ' + data.nombre);
        })
        .catch(error => {
            alert('Error al registrar el usuario');
            console.error('Error:', error);
        });
};

document.addEventListener('DOMContentLoaded', function() {
    // Selecciona el formulario y añade un listener al evento 'submit'
    const formulario = document.getElementById('registarCuenta');
    
    formulario.addEventListener('submit', function(event) {
        // Prevenir el comportamiento por defecto (recargar la página)
        event.preventDefault();
        
        // Llamar a la función para registrar la cuenta
        registrarCuenta();
    });
});

// Iniciar sesión
function iniciarSesion() {
    const correo = document.getElementById('inicioSesionCorreo').value;
    const contrasena = document.getElementById('inicioSesionContrasena').value;

    if (!correo || !contrasena) {
        alert('Todos los campos son requeridos');
        return;
    }

    fetch('http://localhost:3000/cuenta/inicio_sesion', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ correo, contrasena })
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            alert('Inicio de sesión exitoso');
        })
        .catch(error => {
            alert('Correo o contraseña incorrectos');
            console.error('Error:', error);
        });
};

// Olvidé mi contraseña
function olvideContrasena() {
    const correo = document.getElementById('olvideContrasenaCorreo').value;

    if (!correo) {
        alert('El correo es requerido');
        return;
    }

    fetch('http://localhost:3000/cuenta/olvide_contrasena', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ correo })
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            alert('Correo enviado a: ' + correo);
        })
        .catch(error => {
            alert('Correo no registrado');
            console.error('Error:', error);
        });
};

/////// Comentarios ///////
// Obtener comentarios privados


// Obtener comentarios públicos


/////// Cotización Determinada ///////
// Obtener estilos
document.addEventListener('DOMContentLoaded', function () {
    // Realizar la petición al cargar la página
    fetch('http://localhost:3000/estilos')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            // Obtener el combobox (select)
            const estilosSelect = document.getElementById('estilosSelect');

            // Limpiar las opciones existentes (excepto la primera)
            estilosSelect.innerHTML = '<option value="">Seleccione un estilo</option>';

            // Verificar si hay datos
            if (data.length > 0) {
                // Agregar cada estilo como opción al combobox
                data.forEach(estilo => {
                    const option = document.createElement('option');
                    option.value = estilo.Nombre;  // Valor de la opción
                    option.textContent = estilo.Nombre;  // Texto de la opción
                    estilosSelect.appendChild(option);  // Añadir la opción al select
                });
            } else {
                // Si no hay estilos, agregar un mensaje en el combobox
                const option = document.createElement('option');
                option.textContent = 'No hay estilos disponibles';
                estilosSelect.appendChild(option);
            }
        })
        .catch(error => {
            // Manejo de errores
            const estilosSelect = document.getElementById('estilosSelect');
            estilosSelect.innerHTML = '<option value="">Ocurrió un error al obtener los datos</option>';
            console.error('Error:', error);
        });
});

// Obtener categorías trabajos
addEventListener('DOMContentLoaded', function () {
    fetch('http://localhost:3000/categorias')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            const categoriasSelect = document.getElementById('categoriasSelect');
            categoriasSelect.innerHTML = '<option value="">Seleccione una categoría</option>';

            if (data.length > 0) {
                data.forEach(categoria => {
                    const option = document.createElement('option');
                    option.value = categoria.Nombre;
                    option.textContent = categoria.Nombre;
                    categoriasSelect.appendChild(option);
                });
            } else {
                const option = document.createElement('option');
                option.textContent = 'No hay categorías disponibles';
                categoriasSelect.appendChild(option);
            }
        })
        .catch(error => {
            const categoriasSelect = document.getElementById('categoriasSelect');
            categoriasSelect.innerHTML = '<option value="">Ocurrió un error al obtener los datos</option>';
            console.error('Error:', error);
        });
});

// Obtener Paises
document.addEventListener('DOMContentLoaded', function () {
    fetch('http://localhost:3000/paises')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            const paisesSelect = document.getElementById('paisesSelect');
            paisesSelect.innerHTML = '<option value="">Seleccione un país</option>';

            if (data.length > 0) {
                data.forEach(pais => {
                    const option = document.createElement('option');
                    option.value = pais.Pais;
                    option.textContent = pais.Pais;
                    paisesSelect.appendChild(option);
                });
            } else {
                const option = document.createElement('option');
                option.textContent = 'No hay países disponibles';
                paisesSelect.appendChild(option);
            }
        })
        .catch(error => {
            const paisesSelect = document.getElementById('paisesSelect');
            paisesSelect.innerHTML = '<option value="">Ocurrió un error al obtener los datos</option>';
            console.error('Error:', error);
        });
});

// Obtener Provincias
document.addEventListener('DOMContentLoaded', function () {
    fetch('http://localhost:3000/provincias')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            const provinciasSelect = document.getElementById('provinciasSelect');
            provinciasSelect.innerHTML = '<option value="">Seleccione una provincia</option>';

            if (data.length > 0) {
                data.forEach(provincia => {
                    const option = document.createElement('option');
                    option.value = provincia.Provincia;
                    option.textContent = provincia.Provincia;
                    provinciasSelect.appendChild(option);
                });
            } else {
                const option = document.createElement('option');
                option.textContent = 'No hay provincias disponibles';
                provinciasSelect.appendChild(option);
            }
        })
        .catch(error => {
            const provinciasSelect = document.getElementById('provinciasSelect');
            provinciasSelect.innerHTML = '<option value="">Ocurrió un error al obtener los datos</option>';
            console.error('Error:', error);
        });
});

// Obtener Cantones
document.addEventListener('DOMContentLoaded', function () {
    fetch('http://localhost:3000/cantones')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            const cantonesSelect = document.getElementById('cantonesSelect');
            cantonesSelect.innerHTML = '<option value="">Seleccione un cantón</option>';

            if (data.length > 0) {
                data.forEach(canton => {
                    const option = document.createElement('option');
                    option.value = canton.Canton;
                    option.textContent = canton.Canton;
                    cantonesSelect.appendChild(option);
                });
            } else {
                const option = document.createElement('option');
                option.textContent = 'No hay cantones disponibles';
                cantonesSelect.appendChild(option);
            }
        })
        .catch(error => {
            const cantonesSelect = document.getElementById('cantonesSelect');
            cantonesSelect.innerHTML = '<option value="">Ocurrió un error al obtener los datos</option>';
            console.error('Error:', error);
        });
});

// Obtener Distritos
document.addEventListener('DOMContentLoaded', function () {
    fetch('http://localhost:3000/distritos')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            const distritosSelect = document.getElementById('distritosSelect');
            distritosSelect.innerHTML = '<option value="">Seleccione un distrito</option>';

            if (data.length > 0) {
                data.forEach(distrito => {
                    const option = document.createElement('option');
                    option.value = distrito.Distrito;
                    option.textContent = distrito.Distrito;
                    distritosSelect.appendChild(option);
                });
            } else {
                const option = document.createElement('option');
                option.textContent = 'No hay distritos disponibles';
                distritosSelect.appendChild(option);
            }
        })
        .catch(error => {
            const distritosSelect = document.getElementById('distritosSelect');
            distritosSelect.innerHTML = '<option value="">Ocurrió un error al obtener los datos</option>';
            console.error('Error:', error);
        });
});

document.getElementById('btnCotizaciones').addEventListener('click', function() {
    fetch('http://localhost:3000/cotizaciones')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            const resultadoCotizaciones = document.getElementById('resultadoCotizaciones');
            resultadoCotizaciones.innerHTML = '';  // Limpiar el contenido

            data.forEach(cotizacion => {
                const div = document.createElement('div');
                div.innerHTML = `
                    <p><strong>Tipo de Cotización:</strong> ${cotizacion.TipoCotizacion}</p>
                    <p><strong>Cliente:</strong> ${cotizacion.PrimerNombre} ${cotizacion.SegundoNombre} ${cotizacion.PrimerApellido} ${cotizacion.SegundoApellido}</p>
                    ${cotizacion.TipoCotizacion === 'Determinada' ? `
                      <p><strong>Categoría:</strong> ${cotizacion.Categoria}</p>
                      <p><strong>Estilo:</strong> ${cotizacion.Estilo}</p>
                      <p><strong>Dimensiones:</strong> ${cotizacion.Ancho} x ${cotizacion.Largo}</p>
                      <p><strong>Ubicación:</strong> ${cotizacion.Ubicacion}</p>
                      <p><strong>Precio:</strong> ${cotizacion.Costo}</p>
                    ` : `
                      <p><strong>Descripción:</strong> ${cotizacion.Descripcion}</p>
                      <p><strong>Precio:</strong> ${cotizacion.Costo}</p>
                    `}
                    <hr>
                `;
                resultadoCotizaciones.appendChild(div);
            });
        })
        .catch(error => {
            alert('Error al obtener las cotizaciones');
            console.error('Error:', error);
        });
});
// Obtener cotizaciones por correo electrónico
document.getElementById('consultarCotizaciones').addEventListener('submit', function(event) {
    event.preventDefault();

    const correo = document.getElementById('consultarCorreo').value;

    fetch(`http://localhost:3000/cotizacion?correo=${correo}`)
        .then(response => response.json())
        .then(data => {
            const resultDiv = document.getElementById('resultadoCotizaciones');
            resultDiv.innerHTML = '';

            if (data.error) {
                resultDiv.textContent = data.error;
                return;
            }

            resultDiv.innerHTML += '<h3>Cotizaciones Determinadas</h3>';
            data.cotizacionesDeterminadas.forEach(cot => {
                resultDiv.innerHTML += `
                    <p>
                        Categoría: ${cot.Categoria}<br>
                        Estilo: ${cot.Estilo}<br>
                        Ancho: ${cot.Ancho}<br>
                        Largo: ${cot.Largo}<br>
                        Costo: ${cot.Costo}<br>
                        Ubicación: ${cot.Ubicacion}<br>
                        Fecha: ${cot.FechaRecibido}
                    </p>`;
            });

            resultDiv.innerHTML += '<h3>Cotizaciones Especiales</h3>';
            data.cotizacionesEspeciales.forEach(cot => {
                resultDiv.innerHTML += `
                    <p>
                        Nombre: ${cot.Nombre}<br>
                        Descripción: ${cot.Descripcion}<br>
                        Fecha: ${cot.FechaRecibido}
                    </p>`;
            });
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error al consultar las cotizaciones');
        });
});
// Consultar estadísticas generales
function consultarEstadisticasGenerales() {
    fetch('http://localhost:3000/estadisticas/cotizaciones/generales')
        .then(response => response.json())
        .then(data => {
            const resultDiv = document.getElementById('resultadoEstadisticasGenerales');
            resultDiv.innerHTML = JSON.stringify(data, null, 2);
        })
        .catch(error => console.error('Error:', error));
}

// Consultar estadísticas por cliente
function consultarEstadisticasPorCliente() {
    fetch('http://localhost:3000/estadisticas/cotizaciones/por_cliente')
        .then(response => response.json())
        .then(data => {
            const resultDiv = document.getElementById('resultadoEstadisticasPorCliente');
            resultDiv.innerHTML = JSON.stringify(data, null, 2);
        })
        .catch(error => console.error('Error:', error));
}
document.getElementById('formCambiarEstado').addEventListener('submit', function(event) {
    event.preventDefault();

    const idCotizacion = document.getElementById('idCotizacion').value;
    const tipoCotizacion = document.getElementById('tipoCotizacion').value;
    const nuevoEstado = document.getElementById('nuevoEstado').value;

    fetch('http://localhost:3000/cotizacion/estado', {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ idCotizacion, tipoCotizacion, nuevoEstado })
    })
    .then(response => response.json())
    .then(data => {
        const resultDiv = document.getElementById('resultadoCambioEstado');
        resultDiv.textContent = data.message || data.error;
    })
    .catch(error => console.error('Error:', error));
});

// Obtener materiales por tipo de material
function obtenerMateriales() {
    const idTipoMaterial = document.getElementById('tipoMaterialSelect').value; // Obtenemos el valor seleccionado

    if (!idTipoMaterial) {
        alert('Por favor, selecciona un tipo de material');
        return;
    }

    // Realizar la petición al endpoint del servidor
    fetch(`http://localhost:3000/materiales/${idTipoMaterial}`)
        .then(response => response.json())
        .then(data => {
            const resultadoMateriales = document.getElementById('resultadoMateriales');
            resultadoMateriales.innerHTML = '';  // Limpiar el contenido

            if (data.length === 0) {
                resultadoMateriales.innerHTML = '<p>No se encontraron materiales para este tipo de material</p>';
                return;
            }

            data.forEach(material => {
                const div = document.createElement('div');
                div.innerHTML = `<p>Material: ${material.nombre}</p>`;
                resultadoMateriales.appendChild(div);
            });
        })
        .catch(error => {
            alert('Error al obtener los materiales');
            console.error('Error:', error);
        });
}
// Inserción de cotización determinada
function insertarCotizacionDeterminada() {
    const cotizacion = {
        IDCuenta: document.getElementById('IDCuenta').value,
        IDTipoTrabajo: document.getElementById('IDTipoTrabajo').value,
        IDEstilo: document.getElementById('IDEstilo').value,
        Ancho: document.getElementById('Ancho').value,
        Largo: document.getElementById('Largo').value,
        Traslado: document.getElementById('Traslado').value,
        Costo: document.getElementById('Costo').value,
        IDEstadoCotizacion: document.getElementById('IDEstadoCotizacion').value
    };

    fetch('http://localhost:3000/cotizacion/determinada', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(cotizacion)
    })
    .then(response => response.json())
    .then(data => {
        alert('Cotización determinada insertada con éxito');
        console.log(data);
    })
    .catch(error => {
        alert('Error al insertar cotización determinada');
        console.error('Error:', error);
    });
}

// Inserción de cotización especial
function insertarCotizacionEspecial() {
    const cotizacion = {
        IDCuenta: document.getElementById('IDCuentaEspecial').value,
        Nombre: document.getElementById('NombreEspecial').value,
        Descripcion: document.getElementById('Descripcion').value,
        Traslado: document.getElementById('TrasladoEspecial').value,
        Costo: document.getElementById('CostoEspecial').value,
        IDEstadoCotizacion: document.getElementById('IDEstadoCotizacionEspecial').value
    };

    fetch('http://localhost:3000/cotizacion/especial', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(cotizacion)
    })
    .then(response => response.json())
    .then(data => {
        alert('Cotización especial insertada con éxito');
        console.log(data);
    })
    .catch(error => {
        alert('Error al insertar cotización especial');
        console.error('Error:', error);
    });
}

// Obtener comentarios con estado TRUE
function obtenerComentariosTrue() {
    fetch('http://localhost:3000/comentarios/true')
        .then(response => {
            if (!response.ok) {
                throw new Error('Error al obtener los comentarios con estado TRUE');
            }
            return response.json();
        })
        .then(data => {
            const resultDiv = document.getElementById('resultadoComentariosTrue');
            resultDiv.innerHTML = '';  // Limpiar el contenido
            data.forEach(comentario => {
                const p = document.createElement('p');
                p.textContent = `IDComentario: ${comentario.IDComentario}, Comentario: ${comentario.Comentario}`;
                resultDiv.appendChild(p);
            });
        })
        .catch(error => console.error('Error:', error));
}

// Obtener comentarios con estado FALSE
function obtenerComentariosFalse() {
    fetch('http://localhost:3000/comentarios/false')
        .then(response => {
            if (!response.ok) {
                throw new Error('Error al obtener los comentarios con estado FALSE');
            }
            return response.json();
        })
        .then(data => {
            const resultDiv = document.getElementById('resultadoComentariosFalse');
            resultDiv.innerHTML = '';  // Limpiar el contenido
            data.forEach(comentario => {
                const p = document.createElement('p');
                p.textContent = `IDComentario: ${comentario.IDComentario}, Comentario: ${comentario.Comentario}`;
                resultDiv.appendChild(p);
            });
        })
        .catch(error => console.error('Error:', error));
}
// Obtener estadísticas por IDCuenta
function obtenerEstadisticasPorCuenta() {
    const idCuenta = document.getElementById('idCuenta').value; // Obtener el IDCuenta desde un campo de entrada

    if (!idCuenta) {
        alert('Por favor, ingresa un ID de cuenta');
        return;
    }

    fetch(`http://localhost:3000/estadisticas/cotizaciones/${idCuenta}`)
        .then(response => response.json())
        .then(data => {
            const resultadoEstadisticas = document.getElementById('resultadoEstadisticas');
            resultadoEstadisticas.innerHTML = '';  // Limpiar el contenido

            if (data.length === 0) {
                resultadoEstadisticas.innerHTML = '<p>No se encontraron estadísticas para esta cuenta</p>';
                return;
            }

            data.forEach(estadistica => {
                const div = document.createElement('div');
                div.innerHTML = `<p>${estadistica.Aspecto}: ${estadistica.Valor} (${estadistica.Cantidad})</p>`;
                resultadoEstadisticas.appendChild(div);
            });
        })
        .catch(error => {
            alert('Error al obtener las estadísticas');
            console.error('Error:', error);
        });
}
function descargarCotizaciones() {
    const idCuenta = prompt("Ingresa el ID de la cuenta:");
  
    if (!idCuenta) {
      alert('ID de cuenta es requerido');
      return;
    }
  
    // Redirigir al servidor para descargar el archivo PDF
    window.location.href = `http://localhost:3000/descargar/cotizaciones/${idCuenta}`;
  }
  
  // Obtener cotizaciones por IDCuenta
// Obtener cotizaciones por IDCuenta (determinadas y especiales)
function obtenerCotizacionesPorUsuario() {
    const idCuenta = document.getElementById('idCuentaUsuario').value;

    if (!idCuenta) {
        alert('Por favor, ingresa un ID de Cuenta válido.');
        return;
    }

    fetch(`http://localhost:3000/cotizaciones/por_usuario/${idCuenta}`)
        .then(response => response.json())
        .then(data => {
            const resultDiv = document.getElementById('resultadoCotizacionesPorUsuario');
            resultDiv.innerHTML = '';  // Limpiar el contenido

            if (!data || (data.cotizacionesDeterminadas.length === 0 && data.cotizacionesEspeciales.length === 0)) {
                resultDiv.innerHTML = '<p>No se encontraron cotizaciones para este usuario.</p>';
                return;
            }

            // Mostrar cotizaciones determinadas
            if (data.cotizacionesDeterminadas.length > 0) {
                resultDiv.innerHTML += '<h3>Cotizaciones Determinadas</h3>';
                data.cotizacionesDeterminadas.forEach(cotizacion => {
                    resultDiv.innerHTML += `
                        <p>
                            ID: ${cotizacion.IDCotizacion}<br>
                            Cliente: ${cotizacion.PrimerNombre} ${cotizacion.PrimerApellido}<br>
                            Categoría: ${cotizacion.Categoria}<br>
                            Estilo: ${cotizacion.Estilo}<br>
                            Dimensiones: ${cotizacion.Ancho} x ${cotizacion.Largo}<br>
                            Costo: ${cotizacion.Costo}<br>
                            Fecha: ${cotizacion.FechaRecibido}
                        </p><hr>`;
                });
            }

            // Mostrar cotizaciones especiales
            if (data.cotizacionesEspeciales.length > 0) {
                resultDiv.innerHTML += '<h3>Cotizaciones Especiales</h3>';
                data.cotizacionesEspeciales.forEach(cotizacion => {
                    resultDiv.innerHTML += `
                        <p>
                            ID: ${cotizacion.IDCotizacion}<br>
                            Cliente: ${cotizacion.PrimerNombre} ${cotizacion.PrimerApellido}<br>
                            Nombre: ${cotizacion.NombreEspecial}<br>
                            Descripción: ${cotizacion.Descripcion}<br>
                            Costo: ${cotizacion.Costo}<br>
                            Fecha: ${cotizacion.FechaRecibido}
                        </p><hr>`;
                });
            }
        })
        .catch(error => {
            console.error('Error al obtener las cotizaciones:', error);
        });
}
