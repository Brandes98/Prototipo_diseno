CREATE TABLE `Pais` (
  `IDPais` INT(10),
  `Pais` VARCHAR(100),
  PRIMARY KEY (`IDPais`)
);

CREATE TABLE `Provincia` (
  `IDProvincia` INT(20),
  `IDPais` INT(10),
  `Provincia` VARCHAR(100),
  PRIMARY KEY (`IDProvincia`),
  FOREIGN KEY (`IDPais`) REFERENCES `Pais`(`IDPais`)
);

CREATE TABLE `Canton` (
  `IDCanton` INT(20),
  `IDProvincia` INT(20),
  `Canton` VARCHAR(100),
  PRIMARY KEY (`IDCanton`),
  FOREIGN KEY (`IDProvincia`) REFERENCES `Provincia`(`IDProvincia`)
);

CREATE TABLE `Distrito` (
  `IDDistrito` INT(20),
  `IDCanton` INT(20),
  `Distrito` VARCHAR(100),
  PRIMARY KEY (`IDDistrito`),
  FOREIGN KEY (`IDCanton`) REFERENCES `Canton`(`IDCanton`)
);

CREATE TABLE `TipoCuenta` (
  `IDTipoCuenta` INT(2),
  `TipoCuenta` VARCHAR(100),
  PRIMARY KEY (`IDTipoCuenta`)
);

CREATE TABLE `Cuenta` (
  `IDCuenta` INT(10),
  `IDTipoCuenta` INT(2),
  `IDDistrito` INT(20),
  `PrimerNombre` VARCHAR(100),
  `SegundoNombre` VARCHAR(100),
  `PrimerApellido` VARCHAR(100),
  `SegundoApellido` VARCHAR(100),
  `CorreoElectronico` VARCHAR(200),
  `Clave` VARCHAR(100),
  PRIMARY KEY (`IDCuenta`),
  FOREIGN KEY (`IDDistrito`) REFERENCES `Distrito`(`IDDistrito`),
  FOREIGN KEY (`IDTipoCuenta`) REFERENCES `TipoCuenta`(`IDTipoCuenta`)
);

CREATE TABLE `Estilo` (
  `IDEstilo` INT(50),
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDEstilo`)
);

-- estado de cotizacion --
CREATE TABLE `EstadoCotizacion` (
    `IDEstadoCotizacion` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    `Estado` VARCHAR(20)
);

-- Colores de pinturas
CREATE TABLE `ColorPintura` (
    `IDColorPintura` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    `Nombre` VARCHAR(50)
);

CREATE TABLE `CotizacionEspecial` (
  `IDCotizacionEsp` INT(50),
  `IDCuenta` INT(10),
  `Nombre` VARCHAR(100),
  `Descripcion` VARCHAR(500),
  `FechaRecibido` DATETIME,
  `Traslado` BOOLEAN,
  `Costo` FLOAT(12,2),
  `IDEstadoCotizacion` INT(10),
  `IDColorPintura` INT(10),
  PRIMARY KEY (`IDCotizacionEsp`),
  FOREIGN KEY (`IDCuenta`) REFERENCES `Cuenta`(`IDCuenta`),
  FOREIGN KEY (`IDEstadoCotizacion`) REFERENCES `EstadoCotizacion`(`IDEstadoCotizacion`),
  FOREIGN KEY (`IDColorPintura`) REFERENCES `ColorPintura`(`IDColorPintura`)
);

CREATE TABLE `UnidadMedida` (
  `IDUnidadMedida` INT(5),
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDUnidadMedida`)
);

CREATE TABLE `TipoMaterial` (
  `IDTipoMaterial` INT(10),
  `IDUnidadMedida` INT(5),
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDTipoMaterial`),
  FOREIGN KEY (`IDUnidadMedida`) REFERENCES `UnidadMedida`(`IDUnidadMedida`)
);

CREATE TABLE `MaterialTrabajo` (
  `IDMaterialTrabajo` INT(20),
  `IDTipoMaterial` INT(10),
  `Nombre` VARCHAR(100),
  `Costo` FLOAT(12,2),
  PRIMARY KEY (`IDMaterialTrabajo`),
  FOREIGN KEY (`IDTipoMaterial`) REFERENCES `TipoMaterial`(`IDTipoMaterial`)
);

CREATE TABLE `TipoTrabajo` (
  `IDTipoTrabajo` INT(50),
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDTipoTrabajo`)
);

CREATE TABLE `CotizacionDeterminada` (
  `IDCotizacionDet` INT(50),
  `IDCuenta` INT(10),
  `IDTipoTrabajo` INT(10),
  `IDEstilo` INT(10),
  `FechaRecibido` DATETIME,
  `FechaEntregada` DATETIME,
  `Traslado` BOOLEAN,
  `Ancho` FLOAT(12,2),
  `Largo` FLOAT(12,2),
  `Costo` FLOAT(22,2),
  `IDEstadoCotizacion` INT(10),
  `IDColorPintura` INT(10),
  PRIMARY KEY (`IDCotizacionDet`),
  FOREIGN KEY (`IDCuenta`) REFERENCES `Cuenta`(`IDTipoCuenta`),
  FOREIGN KEY (`IDTipoTrabajo`) REFERENCES `TipoTrabajo`(`IDTipoTrabajo`),
  FOREIGN KEY (`IDEstilo`) REFERENCES `Estilo`(`IDEstilo`),
  FOREIGN KEY (`IDEstadoCotizacion`) REFERENCES `EstadoCotizacion`(`IDEstadoCotizacion`),
  FOREIGN KEY (`IDColorPintura`) REFERENCES `ColorPintura`(`IDColorPintura`)
);

CREATE TABLE `MaterialesPorTrabajoDeterminado` (
  `IDMaterial` INT(20),
  `IDCortizacionDet` INT(50),
  `Cantidad` FLOAT(12,2),
  PRIMARY KEY (`IDMaterial`, `IDCortizacionDet`),
  FOREIGN KEY (`IDMaterial`) REFERENCES `MaterialTrabajo`(`IDMaterialTrabajo`),
  FOREIGN KEY (`IDCortizacionDet`) REFERENCES `CotizacionDeterminada`(`IDCotizacionDet`)
);

CREATE TABLE `MaterialesPorTrabajoEspecial` (
  `IDMaterial` INT(20),
  `IDCortizacionEsp` INT(50),
  PRIMARY KEY (`IDMaterial`, `IDCortizacionEsp`),
  FOREIGN KEY (`IDCortizacionEsp`) REFERENCES `CotizacionEspecial`(`IDCotizacionEsp`),
  FOREIGN KEY (`IDMaterial`) REFERENCES `MaterialTrabajo`(`IDMaterialTrabajo`)
);

CREATE TABLE `Comentario` (
  `IDComentario` INT(50),
  `IDCuenta` INT(50),
  `Comentario` VARCHAR(300),
  PRIMARY KEY (`IDComentario`),
  FOREIGN KEY (`IDCuenta`) REFERENCES `Cuenta`(`IDCuenta`)
);
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

INSERT INTO Cuenta (IDTipoCuenta, IDDistrito, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, CorreoElectronico, Clave) VALUES 
(1, 1, 'Juan', 'Carlos', 'Gómez', 'Pérez', 'juan.gomez@example.com', 'pass123'),
(2, 3, 'Ana', 'María', 'Rodríguez', 'Lopez', 'ana.rodriguez@example.com', 'securePass456');

-- Tipo Cuenta --
insert into tipocuenta(TipoCuenta) values ('Administrador');
insert into tipocuenta(TipoCuenta) values ('Cliente');
-- Unidad de Medida --
insert into unidadmedida(Nombre) values ('Milimetro');
insert into unidadmedida(Nombre) values ('Metro');
insert into unidadmedida(Nombre) values ('Gramo');
insert into unidadmedida(Nombre) values ('Kilogramo');
insert into unidadmedida(Nombre) values ('Metro cuadrado');
insert into unidadmedida(Nombre) values ('Metro cubico');
insert into unidadmedida(Nombre) values ('Micron');
insert into unidadmedida(Nombre) values ('Pulgada');
insert into unidadmedida(Nombre) values ( 'Galon');
-- Tipo de trabajo --
insert into tipotrabajo(Nombre) values ('Porton');
insert into tipotrabajo(Nombre) values ('Verja');
insert into tipotrabajo(Nombre) values ('Mueble');
insert into tipotrabajo(Nombre) values ('Escalera');
insert into tipotrabajo(Nombre) values ('Barandal');
insert into tipotrabajo(Nombre) values ('Estructura para techos');
insert into tipotrabajo(Nombre) values ('Puertas Metalicas');
insert into tipotrabajo(Nombre) values ('Marcos de ventanas');
insert into tipotrabajo(Nombre) values ('Rejas de seguridad');
insert into tipotrabajo(Nombre) values ('Toldos');
insert into tipotrabajo(Nombre) values ('Mesas');
insert into tipotrabajo(Nombre) values ('Sillas');
insert into tipotrabajo(Nombre) values ('Soportes estructurales');
insert into tipotrabajo(Nombre) values ('Pasamanos');
insert into tipotrabajo(Nombre) values ('Pergolas');
insert into tipotrabajo(Nombre) values ('Estanterias');
insert into tipotrabajo(Nombre) values ('Puentes pequenos');
-- TIPO DE MATERIAL --
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'Acero Estructural');
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'Hierro Fundido');
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'Aluminio');
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'Cobre');
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'Acero Galvanizado');
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'Acero Inoxidable');
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'Bronce');
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'Laton');
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'Titanio');
insert into tipomaterial(IDUnidadMedida, Nombre) values (10, 'Pintura');
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'Vidrio');
insert into tipomaterial(IDUnidadMedida, Nombre) values (3, 'PVC');
insert into tipomaterial(IDUnidadMedida, Nombre) values (6, 'Cemento');

-- Material Trabajo --
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (1, 'Tubo cuadrado',5000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (1, 'Tubo redondo',6000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (5, 'Tubo rectangular',10000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (2, 'Vigas en I',13000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (2, 'Vigas en H',20000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (2, 'Platinas',23000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (3, 'Perfiles U',23000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (3, 'Malla de alambre soldado',32000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (6, 'Tornillos autoperforantes',2000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (6, 'Tornillos de cabeza hexagonal',2300);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (6, 'Tornillos de rosca fina',1300);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (4, 'Clavos galvanizados',4000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (4, 'Clavos de concreto',4000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (1, 'Tornillos de anclaje',4000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (3, 'Remaches',12300);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (12, 'Tornillos de expansión',2300);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (1, 'Placas de anclaje',10000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (1, 'Tuercas',200);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (1, 'Arandelas',100);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (9, 'Bisagras',2300);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (1, 'Pernos',1000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (6, 'Cadenas',3000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (3, 'Abrazaderas para tubos',4000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (11, 'Repisa',5000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (10, 'Pintura exteriores',13000);
INSERT INTO materialtrabajo (IDTipoMaterial, Nombre,Costo) VALUES (10, 'Pintura acero',13000);
INSERT INTO Estilo (Nombre) VALUES 
('Moderno'),
('Clásico'),
('Colonial');

insert into EstadoCotizacion (Estado) values ('Pagado');
insert into EstadoCotizacion (Estado) values ('Pendiente');
insert into EstadoCotizacion (Estado) values ('En proceso');
insert into EstadoCotizacion (Estado) values ('Cotizado');

insert into ColorPintura (Nombre) values ('Gris'), ('Añejado');

INSERT INTO CotizacionEspecial (IDCuenta, Nombre, Descripcion, FechaRecibido, Traslado, Costo, IDEstadoCotizacion, IDColorPintura) VALUES 
(1, 'Trabajo Especial 1', 'Descripción del trabajo especial 1', '2024-09-01 12:00:00', TRUE, 1500.00, 1, 2),
(2, 'Trabajo Especial 2', 'Descripción del trabajo especial 2', '2024-09-05 14:00:00', FALSE, 2500.00, 3, 2);

INSERT INTO CotizacionDeterminada (IDCuenta, IDTipoTrabajo, IDEstilo, FechaRecibido, FechaEntregada, Traslado, Ancho, Largo, Costo) VALUES 
(1, 1, 1, '2024-09-10 08:30:00', '2024-09-20 16:00:00', TRUE, 2.5, 1.5, 3000.00, 4, 1),
(2, 2, 2, '2024-09-12 09:00:00', '2024-09-22 14:00:00', FALSE, 3.0, 2.0, 4500.00, 3, 2);

INSERT INTO MaterialesPorTrabajoDeterminado (IDMaterial, IDCortizacionDet, Cantidad) VALUES 
(1, 3, 5.0),
(1, 4, 3.0),
(2, 3, 2.0);

INSERT INTO MaterialesPorTrabajoEspecial (IDMaterial, IDCortizacionEsp) VALUES 
(1, 1),
(2, 2);

INSERT INTO Comentario (IDCuenta, Comentario) VALUES 
(1, 'Muy buen trabajo, recomendable.'),
(2, 'Excelente servicio y materiales de calidad.');

CREATE TABLE `MaterialesPorTrabajoDeterminado` (
  `IDMaterial` INT,
  `IDCortizacionDet` INT,
  `Cantidad` FLOAT,
  PRIMARY KEY (`IDMaterial`, `IDCortizacionDet`),
  FOREIGN KEY (`IDMaterial`) REFERENCES `MaterialTrabajo`(`IDMaterialTrabajo`),
  FOREIGN KEY (`IDCortizacionDet`) REFERENCES `CotizacionDeterminada`(`IDCotizacionDet`)
);

CREATE TABLE `MaterialesPorTrabajoEspecial` (
  `IDMaterial` INT,
  `IDCortizacionEsp` INT,
  PRIMARY KEY (`IDMaterial`, `IDCortizacionEsp`),
  FOREIGN KEY (`IDCortizacionEsp`) REFERENCES `CotizacionEspecial`(`IDCotizacionEsp`),
  FOREIGN KEY (`IDMaterial`) REFERENCES `MaterialTrabajo`(`IDMaterialTrabajo`)
);