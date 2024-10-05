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
