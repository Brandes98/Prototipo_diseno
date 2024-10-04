USE prototipo;

/*********************** PROTOTIPO TABLAS ***********************/
CREATE TABLE `Pais` (
  `IDPais` INT auto_increment,
  `Pais` VARCHAR(100),
  PRIMARY KEY (`IDPais`)
);

CREATE TABLE `Provincia` (
  `IDProvincia` INT auto_increment,
  `IDPais` INT,
  `Provincia` VARCHAR(100),
  PRIMARY KEY (`IDProvincia`),
  FOREIGN KEY (`IDPais`) REFERENCES `Pais`(`IDPais`)
);

CREATE TABLE `Canton` (
  `IDCanton` INT auto_increment,
  `IDProvincia` INT,
  `Canton` VARCHAR(100),
  PRIMARY KEY (`IDCanton`),
  FOREIGN KEY (`IDProvincia`) REFERENCES `Provincia`(`IDProvincia`)
);

CREATE TABLE `Distrito` (
  `IDDistrito` INT auto_increment,
  `IDCanton` INT,
  `Distrito` VARCHAR(100),
  PRIMARY KEY (`IDDistrito`),
  FOREIGN KEY (`IDCanton`) REFERENCES `Canton`(`IDCanton`)
);

CREATE TABLE `TipoCuenta` (
  `IDTipoCuenta` INT auto_increment,
  `TipoCuenta` VARCHAR(100),
  PRIMARY KEY (`IDTipoCuenta`)
);

CREATE TABLE `Cuenta` (
  `IDCuenta` INT auto_increment,
  `IDTipoCuenta` INT,
  `IDDistrito` INT,
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
  `IDEstilo` INT auto_increment ,
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDEstilo`)
);

CREATE TABLE `CotizacionEspecial` (
  `IDCotizacionEsp` INT auto_increment,
  `IDCuenta` INT,
  `Nombre` VARCHAR(100),
  `Descripcion` VARCHAR(500),
  `FechaRecibido` DATETIME,
  `Traslado` BOOLEAN,
  `Costo` FLOAT,
  PRIMARY KEY (`IDCotizacionEsp`),
  FOREIGN KEY (`IDCuenta`) REFERENCES `Cuenta`(`IDCuenta`)
);

CREATE TABLE `UnidadMedida` (
  `IDUnidadMedida` INT auto_increment,
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDUnidadMedida`)
);

CREATE TABLE `TipoMaterial` (
  `IDTipoMaterial` INT auto_increment,
  `IDUnidadMedida` INT,
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDTipoMaterial`),
  FOREIGN KEY (`IDUnidadMedida`) REFERENCES `UnidadMedida`(`IDUnidadMedida`)
);

CREATE TABLE `MaterialTrabajo` (
  `IDMaterialTrabajo` INT auto_increment,
  `IDTipoMaterial` INT,
  `Nombre` VARCHAR(100),
  `Costo` FLOAT,
  PRIMARY KEY (`IDMaterialTrabajo`),
  FOREIGN KEY (`IDTipoMaterial`) REFERENCES `TipoMaterial`(`IDTipoMaterial`)
);

CREATE TABLE `TipoTrabajo` (
  `IDTipoTrabajo` INT auto_increment,
  `Nombre` VARCHAR(100),
  PRIMARY KEY (`IDTipoTrabajo`)
);

CREATE TABLE `CotizacionDeterminada` (
  `IDCotizacionDet` INT auto_increment,
  `IDCuenta` INT,
  `IDTipoTrabajo` INT,
  `IDEstilo` INT,
  `FechaRecibido` DATETIME,
  `FechaEntregada` DATETIME,
  `Traslado` BOOLEAN,
  `Ancho` FLOAT,
  `Largo` FLOAT,
  `Costo` FLOAT,
  PRIMARY KEY (`IDCotizacionDet`),
  FOREIGN KEY (`IDCuenta`) REFERENCES `Cuenta`(`IDTipoCuenta`),
  FOREIGN KEY (`IDTipoTrabajo`) REFERENCES `TipoTrabajo`(`IDTipoTrabajo`),
  FOREIGN KEY (`IDEstilo`) REFERENCES `Estilo`(`IDEstilo`)
);

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

CREATE TABLE `Comentario` (
  `IDComentario` INT auto_increment,
  `IDCuenta` INT,
  `Comentario` VARCHAR(300),
  PRIMARY KEY (`IDComentario`),
  FOREIGN KEY (`IDCuenta`) REFERENCES `Cuenta`(`IDCuenta`)
);