-- ************** Base de datos **************
DROP DATABASE IF EXISTS prototipo;
CREATE DATABASE IF NOT EXISTS prototipo;
USE prototipo;

-- ************** Tablas **************
-- Ubicación
CREATE TABLE `Pais` (
  `IDPais` INT AUTO_INCREMENT,
  `Pais` VARCHAR(100),
  PRIMARY KEY (`IDPais`)
);

CREATE TABLE `Provincia` (
  `IDProvincia` INT AUTO_INCREMENT,
  `IDPais` INT,
  `Provincia` VARCHAR(100),
  PRIMARY KEY (`IDProvincia`),
  FOREIGN KEY (`IDPais`) REFERENCES `Pais`(`IDPais`)
);

CREATE TABLE `Canton` (
  `IDCanton` INT AUTO_INCREMENT,
  `IDProvincia` INT,
  `Canton` VARCHAR(100),
  PRIMARY KEY (`IDCanton`),
  FOREIGN KEY (`IDProvincia`) REFERENCES `Provincia`(`IDProvincia`)
);

CREATE TABLE `Distrito` (
  `IDDistrito` INT AUTO_INCREMENT,
  `IDCanton` INT,
  `Distrito` VARCHAR(100),
  PRIMARY KEY (`IDDistrito`),
  FOREIGN KEY (`IDCanton`) REFERENCES `Canton`(`IDCanton`)
);

-- Datos de cuenta
CREATE TABLE `TipoCuenta` (
  `IDTipoCuenta` INT AUTO_INCREMENT,
  `TipoCuenta` VARCHAR(100),
  PRIMARY KEY (`IDTipoCuenta`)
);

CREATE TABLE `Cuenta` (
  `IDCuenta` INT AUTO_INCREMENT,
  `IDTipoCuenta` INT,
  `IDDistrito` INT,
  `PrimerNombre` VARCHAR(100),
  `SegundoNombre` VARCHAR(100),
  `PrimerApellido` VARCHAR(100),
  `SegundoApellido` VARCHAR(100),
  `CorreoElectronico` VARCHAR(200),
  `Clave` VARCHAR(100),
  `Estado` BOOL,
  PRIMARY KEY (`IDCuenta`),
  FOREIGN KEY (`IDDistrito`) REFERENCES `Distrito`(`IDDistrito`),
  FOREIGN KEY (`IDTipoCuenta`) REFERENCES `TipoCuenta`(`IDTipoCuenta`)
);

CREATE TABLE `Comentario` (
  `IDComentario` INT AUTO_INCREMENT,
  `IDCuenta` INT,
  `Comentario` VARCHAR(300),
  `Estado` INT, -- 0 sin aprobar, 1 aprobado, 2 rechazado
  PRIMARY KEY (`IDComentario`),
  FOREIGN KEY (`IDCuenta`) REFERENCES `Cuenta`(`IDCuenta`)
);

-- Datos de cotizaciones
CREATE TABLE `Estilo` (
  `IDEstilo` INT AUTO_INCREMENT,
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDEstilo`)
);

CREATE TABLE `ColorPintura` (
    `IDColorPintura` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    `Nombre` VARCHAR(50)
);

CREATE TABLE `TipoTrabajo` (
  `IDTipoTrabajo` INT AUTO_INCREMENT,
  `Nombre` VARCHAR(100),
  `Precio` INT,
  PRIMARY KEY (`IDTipoTrabajo`)
);

CREATE TABLE `EstadoCotizacion` (
    `IDEstadoCotizacion` INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    `Estado` VARCHAR(20)
);

CREATE TABLE `CotizacionDeterminada` (
  `IDCotizacionDet` INT AUTO_INCREMENT,
  `IDCuenta` INT,
  `IDTipoTrabajo` INT,
  `IDEstilo` INT,
  `FechaRecibido` DATETIME,
  `FechaEntregada` DATETIME,
  `Traslado` BOOLEAN,
  `Ancho` FLOAT,
  `Largo` FLOAT,
  `Costo` FLOAT,
  `IDEstadoCotizacion` INT,
  `IDColorPintura` INT,
  PRIMARY KEY (`IDCotizacionDet`),
  FOREIGN KEY (`IDCuenta`) REFERENCES `Cuenta`(`IDCuenta`),
  FOREIGN KEY (`IDTipoTrabajo`) REFERENCES `TipoTrabajo`(`IDTipoTrabajo`),
  FOREIGN KEY (`IDEstilo`) REFERENCES `Estilo`(`IDEstilo`),
  FOREIGN KEY (`IDEstadoCotizacion`) REFERENCES `EstadoCotizacion`(`IDEstadoCotizacion`),
  FOREIGN KEY (`IDColorPintura`) REFERENCES `ColorPintura`(`IDColorPintura`)
);

CREATE TABLE `CotizacionEspecial` (
  `IDCotizacionEsp` INT AUTO_INCREMENT,
  `IDCuenta` INT,
  `Nombre` VARCHAR(100),
  `Descripcion` VARCHAR(500),
  `FechaRecibido` DATETIME,
  `Traslado` BOOLEAN,
  `Costo` FLOAT,
  `IDEstadoCotizacion` INT,
  `IDColorPintura` INT,
  PRIMARY KEY (`IDCotizacionEsp`),
  FOREIGN KEY (`IDCuenta`) REFERENCES `Cuenta`(`IDCuenta`),
  FOREIGN KEY (`IDEstadoCotizacion`) REFERENCES `EstadoCotizacion`(`IDEstadoCotizacion`),
  FOREIGN KEY (`IDColorPintura`) REFERENCES `ColorPintura`(`IDColorPintura`)
);

-- Materiales
CREATE TABLE `UnidadMedida` (
  `IDUnidadMedida` INT AUTO_INCREMENT,
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDUnidadMedida`)
);

CREATE TABLE `TipoMaterial` (
  `IDTipoMaterial` INT AUTO_INCREMENT,
  `IDUnidadMedida` INT,
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDTipoMaterial`),
  FOREIGN KEY (`IDUnidadMedida`) REFERENCES `UnidadMedida`(`IDUnidadMedida`)
);

CREATE TABLE `MaterialTrabajo` (
  `IDMaterialTrabajo` INT AUTO_INCREMENT,
  `IDTipoMaterial` INT,
  `Nombre` VARCHAR(100),
  `Costo` FLOAT,
  PRIMARY KEY (`IDMaterialTrabajo`),
  FOREIGN KEY (`IDTipoMaterial`) REFERENCES `TipoMaterial`(`IDTipoMaterial`)
);

-- Materiales con cotizaciones
CREATE TABLE `MaterialesPorTrabajoDeterminado` (
  `IDMaterial` INT AUTO_INCREMENT,
  `IDCortizacionDet` INT,
  `Cantidad` FLOAT,
  PRIMARY KEY (`IDMaterial`, `IDCortizacionDet`),
  FOREIGN KEY (`IDMaterial`) REFERENCES `MaterialTrabajo`(`IDMaterialTrabajo`),
  FOREIGN KEY (`IDCortizacionDet`) REFERENCES `CotizacionDeterminada`(`IDCotizacionDet`)
);

CREATE TABLE `MaterialesPorTrabajoEspecial` (
  `IDMaterial` INT AUTO_INCREMENT,
  `IDCortizacionEsp` INT,
  PRIMARY KEY (`IDMaterial`, `IDCortizacionEsp`),
  FOREIGN KEY (`IDCortizacionEsp`) REFERENCES `CotizacionEspecial`(`IDCotizacionEsp`),
  FOREIGN KEY (`IDMaterial`) REFERENCES `MaterialTrabajo`(`IDMaterialTrabajo`)
);

-- ************** Datos **************
-- Ubicación
INSERT INTO Pais (Pais) VALUES 
('Costa Rica'), 
('Panamá'), 
('Nicaragua');

INSERT INTO Provincia (IDPais, Provincia) VALUES
(1, 'San José'),
(1, 'Alajuela'),
(1, 'Cartago'),
(1, 'Heredia'),
(1, 'Guanacaste'),
(1, 'Puntarenas'),
(1, 'Limón');

INSERT INTO Canton (IDProvincia, Canton) VALUES
-- San José
(1, 'San José'),
(1, 'Escazú'),
(1, 'Desamparados'),
(1, 'Puriscal'),
(1, 'Tarrazú'),
(1, 'Aserrí'),
(1, 'Mora'),
(1, 'Goicoechea'),
(1, 'Santa Ana'),
(1, 'Alajuelita'),
(1, 'Vázquez de Coronado'),
(1, 'Acosta'),
(1, 'Tibás'),
(1, 'Moravia'),
(1, 'Montes de Oca'),
(1, 'Turrubares'),
(1, 'Dota'),
(1, 'Curridabat'),
(1, 'Pérez Zeledón'),
(1, 'León Cortés'),
-- Alajuela
(2, 'Alajuela'),
(2, 'San Ramón'),
(2, 'Grecia'),
(2, 'San Mateo'),
(2, 'Atenas'),
(2, 'Naranjo'),
(2, 'Palmares'),
(2, 'Poás'),
(2, 'Orotina'),
(2, 'San Carlos'),
(2, 'Zarcero'),
(2, 'Valverde Vega'),
(2, 'Upala'),
(2, 'Los Chiles'),
(2, 'Guatuso'),
-- Cartago
(3, 'Cartago'),
(3, 'Paraíso'),
(3, 'La Unión'),
(3, 'Jiménez'),
(3, 'Turrialba'),
(3, 'Alvarado'),
(3, 'Oreamuno'),
(3, 'El Guarco'),
-- Heredia
(4, 'Heredia'),
(4, 'Barva'),
(4, 'Santo Domingo'),
(4, 'Santa Bárbara'),
(4, 'San Rafael'),
(4, 'San Isidro'),
(4, 'Belén'),
(4, 'Flores'),
(4, 'San Pablo'),
(4, 'Sarapiquí'),
-- Guanacaste
(5, 'Liberia'),
(5, 'Nicoya'),
(5, 'Santa Cruz'),
(5, 'Bagaces'),
(5, 'Carrillo'),
(5, 'Cañas'),
(5, 'Abangares'),
(5, 'Tilarán'),
(5, 'Nandayure'),
(5, 'La Cruz'),
(5, 'Hojancha'),
-- Puntarenas
(6, 'Puntarenas'),
(6, 'Esparza'),
(6, 'Buenos Aires'),
(6, 'Montes de Oro'),
(6, 'Osa'),
(6, 'Quepos'),
(6, 'Golfito'),
(6, 'Coto Brus'),
(6, 'Parrita'),
(6, 'Corredores'),
(6, 'Garabito'),
-- Limón
(7, 'Limón'),
(7, 'Pococí'),
(7, 'Siquirres'),
(7, 'Talamanca'),
(7, 'Matina'),
(7, 'Guácimo');

-- Cantón: San José (ID 1)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(1, 'Carmen'),
(1, 'Merced'),
(1, 'Hospital'),
(1, 'Catedral'),
(1, 'Zapote'),
(1, 'San Francisco de Dos Ríos'),
(1, 'Uruca'),
(1, 'Mata Redonda'),
(1, 'Pavas'),
(1, 'Hatillo'),
(1, 'San Sebastián');

-- Cantón: Escazú (ID 2)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(2, 'Escazú'),
(2, 'San Rafael'),
(2, 'San Antonio');

-- Cantón: Desamparados (ID 3)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(3, 'Desamparados'),
(3, 'San Miguel'),
(3, 'San Juan de Dios'),
(3, 'San Rafael Arriba'),
(3, 'San Rafael Abajo'),
(3, 'Gravilias'),
(3, 'Damas'),
(3, 'San Cristóbal'),
(3, 'Rosario'),
(3, 'Frailes'),
(3, 'Patarrá'),
(3, 'San Antonio'),
(3, 'Dos Cercas'),
(3, 'Los Guido');

-- Cantón: Puriscal (ID 4)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(4, 'Santiago'),
(4, 'Mercedes Sur'),
(4, 'Barbacoas'),
(4, 'Grifo Alto'),
(4, 'San Rafael'),
(4, 'Candelarita'),
(4, 'Desamparaditos'),
(4, 'San Antonio'),
(4, 'Chires');

-- Cantón: Tarrazú (ID 5)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(5, 'San Marcos'),
(5, 'San Lorenzo'),
(5, 'San Carlos');

-- Cantón: Aserrí (ID 6)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(6, 'Aserrí'),
(6, 'Tarbaca'),
(6, 'Vuelta de Jorco'),
(6, 'San Gabriel'),
(6, 'Legua'),
(6, 'Monterrey'),
(6, 'Salitrillos');

-- Cantón: Mora (ID 7)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(7, 'Colón'),
(7, 'Guayabo'),
(7, 'Tabarcia'),
(7, 'Piedras Negras'),
(7, 'Picagres'),
(7, 'Jaris'),
(7, 'Quitirrisí');

-- Cantón: Goicoechea (ID 8)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(8, 'Guadalupe'),
(8, 'San Francisco'),
(8, 'Calle Blancos'),
(8, 'Mata de Plátano'),
(8, 'Ipís'),
(8, 'Rancho Redondo'),
(8, 'Purral');

-- Cantón: Santa Ana (ID 9)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(9, 'Santa Ana'),
(9, 'Salitral'),
(9, 'Pozos'),
(9, 'Uruca'),
(9, 'Piedades'),
(9, 'Brasil');

-- Cantón: Alajuelita (ID 10)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(10, 'Alajuelita'),
(10, 'San Josecito'),
(10, 'San Antonio'),
(10, 'Concepción'),
(10, 'San Felipe');

-- Cantón: Vázquez de Coronado (ID 11)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(11, 'San Isidro'),
(11, 'San Rafael'),
(11, 'Dulce Nombre de Jesús'),
(11, 'Patalillo'),
(11, 'Cascajal');

-- Cantón: Acosta (ID 12)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(12, 'San Ignacio'),
(12, 'Guaitil'),
(12, 'Palmichal'),
(12, 'Cangrejal'),
(12, 'Sabanillas');

-- Cantón: Tibás (ID 13)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(13, 'San Juan'),
(13, 'Cinco Esquinas'),
(13, 'Anselmo Llorente'),
(13, 'León XIII'),
(13, 'Colima');

-- Cantón: Moravia (ID 14)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(14, 'San Vicente'),
(14, 'San Jerónimo'),
(14, 'La Trinidad');

-- Cantón: Montes de Oca (ID 15)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(15, 'San Pedro'),
(15, 'Sabanilla'),
(15, 'Mercedes'),
(15, 'San Rafael');

-- Cantón: Turrubares (ID 16)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(16, 'San Pablo'),
(16, 'San Pedro'),
(16, 'San Juan de Mata'),
(16, 'San Luis'),
(16, 'Carara');

-- Cantón: Dota (ID 17)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(17, 'Santa María'),
(17, 'Jardín'),
(17, 'Copey');

-- Cantón: Curridabat (ID 18)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(18, 'Curridabat'),
(18, 'Granadilla'),
(18, 'Sánchez'),
(18, 'Tirrases');

-- Cantón: Pérez Zeledón (ID 19)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(19, 'San Isidro de El General'),
(19, 'El General'),
(19, 'Daniel Flores'),
(19, 'Rivas'),
(19, 'San Pedro'),
(19, 'Platanares'),
(19, 'Pejibaye'),
(19, 'Cajón'),
(19, 'Barú'),
(19, 'Río Nuevo'),
(19, 'Páramo');

-- Cantón: León Cortés (ID 20)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(20, 'San Pablo'),
(20, 'San Andrés'),
(20, 'Llano Bonito'),
(20, 'San Isidro'),
(20, 'Santa Cruz'),
(20, 'San Antonio');

-- Cantón: Alajuela (ID 21)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(21, 'Alajuela'),
(21, 'San José'),
(21, 'Carrizal'),
(21, 'San Antonio'),
(21, 'Guácima'),
(21, 'San Isidro'),
(21, 'Sabanilla'),
(21, 'San Rafael'),
(21, 'Río Segundo'),
(21, 'Desamparados'),
(21, 'Turrúcares'),
(21, 'Tambor'),
(21, 'Garita'),
(21, 'Sarapiquí');

-- Cantón: San Ramón (ID 22)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(22, 'San Ramón'),
(22, 'Santiago'),
(22, 'San Juan'),
(22, 'Piedades Norte'),
(22, 'Piedades Sur'),
(22, 'San Rafael'),
(22, 'San Isidro'),
(22, 'Angeles'),
(22, 'Alfaro'),
(22, 'Volio'),
(22, 'Concepción'),
(22, 'Zapotal'),
(22, 'Peñas Blancas');

-- Cantón: Grecia (ID 23)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(23, 'Grecia'),
(23, 'San Isidro'),
(23, 'San José'),
(23, 'San Roque'),
(23, 'Tacares'),
(23, 'Puente de Piedra'),
(23, 'Bolívar');

-- Cantón: San Mateo (ID 24)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(24, 'San Mateo'),
(24, 'Desmonte'),
(24, 'Jesús María'),
(24, 'Labrador');

-- Cantón: Atenas (ID 25)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(25, 'Atenas'),
(25, 'Jesús'),
(25, 'Mercedes'),
(25, 'San Isidro'),
(25, 'Concepción'),
(25, 'San José'),
(25, 'Santa Eulalia'),
(25, 'Escobal');

-- Cantón: Naranjo (ID 26)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(26, 'Naranjo'),
(26, 'San Miguel'),
(26, 'San José'),
(26, 'Cirrí Sur'),
(26, 'San Jerónimo'),
(26, 'San Juan'),
(26, 'El Rosario'),
(26, 'Palmitos');

-- Cantón: Palmares (ID 27)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(27, 'Palmares'),
(27, 'Zaragoza'),
(27, 'Buenos Aires'),
(27, 'Santiago'),
(27, 'Candelaria'),
(27, 'Esquipulas'),
(27, 'La Granja');

-- Cantón: Poás (ID 28)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(28, 'San Pedro'),
(28, 'San Juan'),
(28, 'San Rafael'),
(28, 'Carrillos'),
(28, 'Sabana Redonda');

-- Cantón: Orotina (ID 29)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(29, 'Orotina'),
(29, 'Mastate'),
(29, 'Hacienda Vieja'),
(29, 'Coyolar'),
(29, 'La Ceiba');

-- Cantón: San Carlos (ID 30)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(30, 'Quesada'),
(30, 'Florencia'),
(30, 'Buenavista'),
(30, 'Aguas Zarcas'),
(30, 'Venecia'),
(30, 'Pital'),
(30, 'Fortuna'),
(30, 'Tigra'),
(30, 'Palmera'),
(30, 'Venado'),
(30, 'Cutris'),
(30, 'Monterrey'),
(30, 'Pocosol');

-- Cantón: Zarcero (ID 31)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(31, 'Zarcero'),
(31, 'Laguna'),
(31, 'Tapezco'),
(31, 'Guadalupe'),
(31, 'Palmira'),
(31, 'Zapote'),
(31, 'Brisas');

-- Cantón: Valverde Vega (ID 32)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(32, 'Sarchí Norte'),
(32, 'Sarchí Sur'),
(32, 'Toro Amarillo'),
(32, 'San Pedro'),
(32, 'Rodríguez');

-- Cantón: Upala (ID 33)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(33, 'Upala'),
(33, 'Aguas Claras'),
(33, 'San José'),
(33, 'Bijagua'),
(33, 'Delicias'),
(33, 'Dos Ríos'),
(33, 'Yolillal'),
(33, 'Canalete');

-- Cantón: Los Chiles (ID 34)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(34, 'Los Chiles'),
(34, 'Caño Negro'),
(34, 'El Amparo'),
(34, 'San Jorge');

-- Cantón: Guatuso (ID 35)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(35, 'San Rafael'),
(35, 'Buenavista'),
(35, 'Cote'),
(35, 'Katira');

-- Cantón: Cartago (ID 36)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(36, 'Oriental'),
(36, 'Occidental'),
(36, 'Carmen'),
(36, 'San Nicolás'),
(36, 'Agua Caliente'),
(36, 'Guadalupe'),
(36, 'Corralillo'),
(36, 'Tierra Blanca'),
(36, 'Dulce Nombre'),
(36, 'Llano Grande'),
(36, 'Quebradilla');

-- Cantón: Paraíso (ID 37)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(37, 'Paraíso'),
(37, 'Santiago'),
(37, 'Orosi'),
(37, 'Cachí'),
(37, 'Llanos de Santa Lucía');

-- Cantón: La Unión (ID 38)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(38, 'Tres Ríos'),
(38, 'San Diego'),
(38, 'San Juan'),
(38, 'San Rafael'),
(38, 'Concepción'),
(38, 'Dulce Nombre'),
(38, 'San Ramón'),
(38, 'Río Azul');

-- Cantón: Jiménez (ID 39)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(39, 'Juan Viñas'),
(39, 'Tucurrique'),
(39, 'Pejibaye');

-- Cantón: Turrialba (ID 40)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(40, 'Turrialba'),
(40, 'La Suiza'),
(40, 'Peralta'),
(40, 'Santa Cruz'),
(40, 'Santa Teresita'),
(40, 'Pavones'),
(40, 'Tuis'),
(40, 'Tayutic'),
(40, 'Santa Rosa'),
(40, 'Tres Equis'),
(40, 'La Isabel'),
(40, 'Chirripó');

-- Cantón: Alvarado (ID 41)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(41, 'Pacayas'),
(41, 'Cervantes'),
(41, 'Capellades');

-- Cantón: Oreamuno (ID 42)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(42, 'San Rafael'),
(42, 'Cot'),
(42, 'Potrero Cerrado'),
(42, 'Cipreses'),
(42, 'Santa Rosa');

-- Cantón: El Guarco (ID 43)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(43, 'El Tejar'),
(43, 'San Isidro'),
(43, 'Tobosi'),
(43, 'Patio de Agua');

-- Cantón: Heredia (ID 44)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(44, 'Heredia'),
(44, 'Mercedes'),
(44, 'San Francisco'),
(44, 'Ulloa'),
(44, 'Varablanca'),
(44, 'San José de la Montaña'),
(44, 'Río Segundo'),
(44, 'San Isidro');

-- Cantón: Barva (ID 45)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(45, 'Barva'),
(45, 'San Pablo'),
(45, 'San José de la Montaña'),
(45, 'San Antonio'),
(45, 'San Pedro'),
(45, 'Santo Domingo'),
(45, 'San Rafael');

-- Cantón: Santo Domingo (ID 46)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(46, 'Santo Domingo'),
(46, 'Santiago'),
(46, 'San Vicente'),
(46, 'San Miguel');

-- Cantón: Santa Bárbara (ID 47)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(47, 'Santa Bárbara'),
(47, 'San José'),
(47, 'San Pedro'),
(47, 'San Juan de Mata');

-- Cantón: San Rafael (ID 48)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(48, 'San Rafael'),
(48, 'San Isidro'),
(48, 'San José'),
(48, 'Concepción');

-- Cantón: San Isidro (ID 49)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(49, 'San Isidro'),
(49, 'San José'),
(49, 'San Rafael'),
(49, 'La Cecilia');

-- Cantón: Belén (ID 50)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(50, 'Belén'),
(50, 'La Asunción'),
(50, 'San Antonio'),
(50, 'San José'),
(50, 'Río Segundo');

-- Cantón: Flores (ID 51)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(51, 'Flores'),
(51, 'San Joaquín'),
(51, 'San Vicente'),
(51, 'La Cruz'),
(51, 'San Luis');

-- Cantón: San Pablo (ID 52)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(52, 'San Pablo'),
(52, 'San José'),
(52, 'San Vicente'),
(52, 'San Rafael'),
(52, 'San Isidro');

-- Cantón: Liberia (ID 53)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(53, 'Liberia'),
(53, 'Cañas Dulces'),
(53, 'Curubandé'),
(53, 'Cañas'),
(53, 'Diriá'),
(53, 'Bagaces'),
(53, 'La Cruz'),
(53, 'Bebedero');

-- Cantón: Nicoya (ID 54)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(54, 'Nicoya'),
(54, 'San Antonio'),
(54, 'San José'),
(54, 'Quebrada Honda'),
(54, 'Sámara'),
(54, 'Nosara'),
(54, 'Carmen'),
(54, 'Belén');

-- Cantón: Santa Cruz (ID 55)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(55, 'Santa Cruz'),
(55, 'Bagaces'),
(55, 'Diriá'),
(55, 'Bebedero'),
(55, 'Carrillo'),
(55, 'Sámara'),
(55, 'Nosara');

-- Cantón: Carrillo (ID 56)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(56, 'Carrillo'),
(56, 'Sámara'),
(56, 'Nosara'),
(56, 'San Blas'),
(56, 'El Jobo'),
(56, 'San José de la Montaña');

-- Cantón: Cañas (ID 57)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(57, 'Cañas'),
(57, 'Palmira'),
(57, 'Esparza'),
(57, 'Cañas Dulces'),
(57, 'Quebrada Honda');

-- Cantón: Abangares (ID 58)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(58, 'Las Juntas'),
(58, 'San Juan'),
(58, 'Sierra'),
(58, 'San Vicente');

-- Cantón: Bagaces (ID 59)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(59, 'Bagaces'),
(59, 'La Libertad'),
(59, 'Cañas Dulces'),
(59, 'Río Naranjo');

-- Cantón: La Cruz (ID 60)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(60, 'La Cruz'),
(60, 'Santa Cecilia'),
(60, 'La Esperanza'),
(60, 'San Antonio'),
(60, 'San Blas');

-- Cantón: Hojancha (ID 61)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(61, 'Hojancha'),
(61, 'Carmona'),
(61, 'Mogote'),
(61, 'Puente de Piedra');

-- Cantón: Puntarenas (ID 62)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(62, 'Puntarenas'),
(62, 'Chacarita'),
(62, 'El Roble'),
(62, 'Cóbano'),
(62, 'Paquera'),
(62, 'Lepanto'),
(62, 'Barranca'),
(62, 'Isla del Coco');

-- Cantón: Esparza (ID 63)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(63, 'Esparza'),
(63, 'Buenos Aires'),
(63, 'San Juan Grande'),
(63, 'San Rafael'),
(63, 'La Rita');

-- Cantón: San Ramón (ID 64)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(64, 'San Ramón'),
(64, 'San Antonio'),
(64, 'La Guaria'),
(64, 'San Juan'),
(64, 'El Llano');

-- Cantón: Golfito (ID 65)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(65, 'Golfito'),
(65, 'Puerto Jiménez'),
(65, 'Guaycará'),
(65, 'Pavones'),
(65, 'Paso Canoas');

-- Cantón: Osa (ID 66)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(66, 'Ciudad Cortés'),
(66, 'Rincón'),
(66, 'Palmar'),
(66, 'Sierpe'),
(66, 'Bahía Ballena'),
(66, 'Piedras Blancas');

-- Cantón: Quepos (ID 67)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(67, 'Quepos'),
(67, 'Naranjito'),
(67, 'Savegre'),
(67, 'Damas'),
(67, 'London'),
(67, 'El Cocal');

-- Cantón: Parrita (ID 68)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(68, 'Parrita'),
(68, 'Playón'),
(68, 'Ojochal');

-- Cantón: Coto Brus (ID 69)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(69, 'San Vito'),
(69, 'Pittier'),
(69, 'Limoncito'),
(69, 'Sabalito');

-- Cantón: Corredores (ID 70)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(70, 'Ciudad Neily'),
(70, 'San Vito'),
(70, 'La Cuesta'),
(70, 'Palmar Sur'),
(70, 'La Palma');

-- Cantón: Limón (ID 71)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(71, 'Limón'),
(71, 'Valle la Estrella'),
(71, 'Río Blanco'),
(71, 'Matama'),
(71, 'Cieneguita'),
(71, 'Bataan'),
(71, 'La Colonia');

-- Cantón: Guácimo (ID 72)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(72, 'Guácimo'),
(72, 'Mercedes'),
(72, 'Cariari'),
(72, 'Volio'),
(72, 'La Lucha');

-- Cantón: Pococí (ID 73)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(73, 'Puerto Viejo'),
(73, 'La Rita'),
(73, 'Colorado'),
(73, 'Río Jiménez'),
(73, 'Río Claro'),
(73, 'Pacuarito'),
(73, 'Río Sucio');

-- Cantón: Siquirres (ID 74)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(74, 'Siquirres'),
(74, 'Río Blanco'),
(74, 'Guápiles'),
(74, 'La Colonia'),
(74, 'La Trocha');

-- Cantón: Talamanca (ID 75)
INSERT INTO Distrito (IDCanton, Distrito) VALUES
(75, 'Bratsi'),
(75, 'Talamanca'),
(75, 'Cahuita'),
(75, 'Puerto Viejo de Talamanca'),
(75, 'Sixaola');


-- Cuenta
INSERT INTO TipoCuenta (TipoCuenta) VALUES 
('Administrador'), 
('Cliente');

INSERT INTO Cuenta (IDTipoCuenta, IDDistrito, PrimerNombre, SegundoNombre, 
					PrimerApellido, SegundoApellido, CorreoElectronico, Clave) VALUES 
                    (1, 1, 'Juan', 'Carlos', 'Gómez', 'Pérez', 'juan.gomez@example.com', 'pass123'), 
                    (2, 3, 'Ana', 'María', 'Rodríguez', 'Lopez', 'ana.rodriguez@example.com', 'securePass456'),
                    (2, 5, 'Ian', 'Steven', 'Coto', 'Soto', 'iancotosoto@gmail.com', 'a');
         
INSERT INTO Comentario (IDCuenta, Comentario, Estado) VALUES 
(1, 'Muy buen trabajo, recomendable.', 1), 
(2, 'Excelente servicio y materiales de calidad.', 1),
(1, 'Muy buen trabajo, recomendable.', 1), 
(2, 'Mal todo, no me quisieron regalar el trabajo.', 0),
(1, 'Dale like a mi canal de yutu xd.', 0), 
(2, 'Genial experiencia.', 0);

INSERT INTO unidadmedida(Nombre) VALUES 
('Milimetro'), 
('Metro'), 
('Gramo'), 
('Kilogramo'), 
('Metro cuadrado'), 
('Metro cubico'), 
('Micron'), 
('Pulgada'), 
('Galon');        
        
INSERT INTO tipomaterial(IDUnidadMedida, Nombre) VALUES 
(3, 'Acero Estructural'), 
(3, 'Hierro Fundido'), 
(3, 'Aluminio'), 
(3, 'Cobre'), 
(3, 'Acero Galvanizado'), 
(3, 'Acero Inoxidable'), 
(3, 'Bronce'), 
(3, 'Laton'), 
(3, 'Titanio'), 
(9, 'Pintura'), 
(3, 'Vidrio'), 
(3, 'PVC'), 
(6, 'Cemento');

INSERT INTO materialtrabajo (IDTipoMaterial, Nombre, Costo) VALUES 
(1, 'Tubo cuadrado',5000), 
(1, 'Tubo redondo',6000), 
(5, 'Tubo rectangular',10000), 
(2, 'Vigas en I',13000), 
(2, 'Vigas en H',20000), 
(2, 'Platinas',23000), 
(3, 'Perfiles U',23000), 
(3, 'Malla de alambre soldado',32000), 
(6, 'Tornillos autoperforantes',2000), 
(6, 'Tornillos de cabeza hexagonal',2300), 
(6, 'Tornillos de rosca fina',1300), 
(4, 'Clavos galvanizados',4000), 
(4, 'Clavos de concreto',4000), 
(1, 'Tornillos de anclaje',4000), 
(3, 'Remaches',12300), 
(12, 'Tornillos de expansión',2300), 
(1, 'Placas de anclaje',10000), 
(1, 'Tuercas',200), 
(1, 'Arandelas',100), 
(9, 'Bisagras',2300), 
(1, 'Pernos',1000), 
(6, 'Cadenas',3000), 
(3, 'Abrazaderas para tubos',4000), 
(11, 'Repisa',5000), 
(10, 'Pintura exteriores',13000), 
(10, 'Pintura acero',13000);

-- Cotizaciones
INSERT INTO ColorPintura (Nombre) VALUES ('Gris'), ('Añejado');

INSERT INTO Estilo (Nombre) VALUES 
('Moderno'), 
('Clásico'), 
('Colonial');

INSERT INTO EstadoCotizacion (Estado) VALUES 
('Pagado'), 
('Pendiente'), 
('En proceso'), 
('Cotizado');

INSERT INTO tipotrabajo(Nombre, Precio) VALUES 
('Porton', 750000), 
('Verja', 250000), 
('Mueble', 450000), 
('Escalera', 300000), 
('Barandal', 200000), 
('Estructura para techos', 800000), 
('Puertas Metalicas', 600000), 
('Marcos de ventanas', 150000), 
('Rejas de seguridad', 400000), 
('Toldos', 350000), 
('Mesas', 500000), 
('Sillas', 120000), 
('Soportes estructurales', 900000), 
('Pasamanos', 180000), 
('Pergolas', 700000), 
('Estanterias', 320000), 
('Puentes pequeños', 950000);

INSERT INTO CotizacionEspecial (IDCuenta, Nombre, Descripcion, FechaRecibido, 
								Traslado, Costo, IDEstadoCotizacion, IDColorPintura) VALUES 
(1, 'Trabajo Especial 1', 'Descripción del trabajo especial 1', '2024-09-01 12:00:00', TRUE, 1500000.00, 1, 2), 
(2, 'Trabajo Especial 2', 'Descripción del trabajo especial 2', '2024-09-05 14:00:00', FALSE, 250000.00, 3, 2);

INSERT INTO CotizacionDeterminada (IDCuenta, IDTipoTrabajo, IDEstilo, FechaRecibido, 
									FechaEntregada, Traslado, Ancho, Largo, Costo, IDColorPintura) VALUES 
(1, 1, 1, '2024-09-10 08:30:00', '2024-09-20 16:00:00', TRUE, 2.5, 1.5, 750000.00, 1), 
(2, 2, 2, '2024-09-12 09:00:00', '2024-09-22 14:00:00', FALSE, 3.0, 2.0, 250000.00, 1);


-- Materiales con trabajo
INSERT INTO MaterialesPorTrabajoDeterminado (IDMaterial, IDCortizacionDet, Cantidad) VALUES 
(1, 1, 5.0), 
(1, 2, 3.0), 
(2, 1, 2.0),
(25, 1, 4.0),
(25, 2, 1.5);

INSERT INTO MaterialesPorTrabajoEspecial (IDMaterial, IDCortizacionEsp) VALUES (1, 1), (2, 2);