USE prototipo;

/*********************** PROTOTIPO INSERTS ***********************/
INSERT INTO Pais (Pais) VALUES ('Costa Rica'), ('Panamá'), ('Nicaragua');

INSERT INTO Provincia (IDPais, Provincia) VALUES 
(1, 'San José'),
(1, 'Alajuela'),
(1, 'Heredia'),
(2, 'Panamá Oeste'),
(2, 'Coclé'),
(3, 'Managua');

INSERT INTO Canton (IDProvincia, Canton) VALUES 
(1, 'Central'),
(1, 'Desamparados'),
(2, 'Central'),
(2, 'Grecia'),
(3, 'Central'),
(3, 'Belén'),
(4, 'La Chorrera'),
(5, 'Aguadulce'),
(6, 'Tipitapa');

INSERT INTO Distrito (IDCanton, Distrito) VALUES 
(1, 'Carmen'),
(1, 'Merced'),
(2, 'San Miguel'),
(3, 'San José'),
(4, 'Grecia Central'),
(5, 'San Antonio'),
(6, 'El Espino'),
(7, 'Aguadulce Central'),
(8, 'Tipitapa Centro');

INSERT INTO TipoCuenta (TipoCuenta) VALUES 
('Administrador'),
('Cliente');

INSERT INTO Cuenta (IDTipoCuenta, IDDistrito, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, CorreoElectronico, Clave, Estado) VALUES 
(1, 1, 'Juan', 'Carlos', 'Gómez', 'Pérez', 'juan.gomez@example.com', 'pass123', 1),
(2, 3, 'Ana', 'María', 'Rodríguez', 'Lopez', 'ana.rodriguez@example.com', 'securePass456', 1);

INSERT INTO Estilo (Nombre) VALUES 
('Moderno'),
('Clásico'),
('Colonial');

INSERT INTO CotizacionEspecial (IDCuenta, Nombre, Descripcion, FechaRecibido, Traslado, Costo) VALUES 
(1, 'Trabajo Especial 1', 'Descripción del trabajo especial 1', '2024-09-01 12:00:00', TRUE, 1500.00),
(2, 'Trabajo Especial 2', 'Descripción del trabajo especial 2', '2024-09-05 14:00:00', FALSE, 2500.00);

INSERT INTO UnidadMedida (Nombre) VALUES 
('Metros'),
('Kilogramos'),
('Unidades');

INSERT INTO TipoMaterial (IDUnidadMedida, Nombre) VALUES 
(1, 'Tubo Cuadrado'),
(2, 'Placa de Acero'),
(3, 'Pintura');

INSERT INTO MaterialTrabajo (IDTipoMaterial, Nombre, Costo) VALUES 
(1, 'Tubo Cuadrado 5x5', 1200.00),
(2, 'Placa de Acero 1cm', 500.00),
(3, 'Pintura Epoxi', 300.00);

INSERT INTO TipoTrabajo (Nombre) VALUES 
('Estructura Metálica'),
('Puerta'),
('Escalera');

INSERT INTO CotizacionDeterminada (IDCuenta, IDTipoTrabajo, IDEstilo, FechaRecibido, FechaEntregada, Traslado, Ancho, Largo, Costo) VALUES 
(1, 1, 1, '2024-09-10 08:30:00', '2024-09-20 16:00:00', TRUE, 2.5, 1.5, 3000.00),
(2, 2, 2, '2024-09-12 09:00:00', '2024-09-22 14:00:00', FALSE, 3.0, 2.0, 4500.00);

INSERT INTO MaterialesPorTrabajoDeterminado (IDMaterial, IDCortizacionDet, Cantidad) VALUES 
(1, 1, 5.0),
(2, 1, 3.0),
(3, 2, 2.0);

INSERT INTO MaterialesPorTrabajoEspecial (IDMaterial, IDCortizacionEsp) VALUES 
(1, 1),
(2, 2);

INSERT INTO Comentario (IDCuenta, Comentario, Estado) VALUES 
(1, 'Muy buen trabajo, recomendable.', FALSE),
(2, 'Excelente servicio y materiales de calidad.', TRUE);