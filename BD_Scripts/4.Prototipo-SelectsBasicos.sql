USE prototipo;

/*********************** PROTOTIPO SELECTS BASICOS ***********************/
-- 1. Tabla Pais
SELECT IDPais, Pais 
FROM Pais;

-- 2. Tabla Provincia
SELECT IDProvincia, Provincia
FROM Provincia;

-- 3. Tabla Canton
SELECT IDCanton, Canton
FROM Canton;

-- 4. Tabla Distrito
SELECT IDDistrito, Distrito
FROM Distrito;

-- 5. Tabla TipoCuenta
SELECT IDTipoCuenta, TipoCuenta 
FROM TipoCuenta;

-- 6. Tabla Cuenta
SELECT Cuenta.IDCuenta, Cuenta.PrimerNombre, Cuenta.SegundoNombre, Cuenta.PrimerApellido, Cuenta.SegundoApellido, 
       Cuenta.CorreoElectronico, TipoCuenta.TipoCuenta, Distrito.Distrito, Canton.Canton, Provincia.Provincia, Pais.Pais
FROM Cuenta
JOIN TipoCuenta ON Cuenta.IDTipoCuenta = TipoCuenta.IDTipoCuenta
JOIN Distrito ON Cuenta.IDDistrito = Distrito.IDDistrito
JOIN Canton ON Distrito.IDCanton = Canton.IDCanton
JOIN Provincia ON Canton.IDProvincia = Provincia.IDProvincia
JOIN Pais ON Provincia.IDPais = Pais.IDPais;

-- 7. Tabla Estilo
SELECT IDEstilo, Nombre FROM Estilo;

-- 8. Tabla CotizacionEspecial
SELECT CotizacionEspecial.IDCotizacionEsp, CotizacionEspecial.Nombre, CotizacionEspecial.Descripcion, 
       CotizacionEspecial.FechaRecibido, CotizacionEspecial.Traslado, CotizacionEspecial.Costo, 
       Cuenta.PrimerNombre, Cuenta.PrimerApellido
FROM CotizacionEspecial
JOIN Cuenta ON CotizacionEspecial.IDCuenta = Cuenta.IDCuenta;

-- 9. Tabla UnidadMedida
SELECT IDUnidadMedida, Nombre FROM UnidadMedida;

-- 10. Tabla TipoMaterial
SELECT TipoMaterial.IDTipoMaterial, TipoMaterial.Nombre, UnidadMedida.Nombre AS UnidadMedida
FROM TipoMaterial
JOIN UnidadMedida ON TipoMaterial.IDUnidadMedida = UnidadMedida.IDUnidadMedida;

-- 11. Tabla MaterialTrabajo
SELECT MaterialTrabajo.IDMaterialTrabajo, MaterialTrabajo.Nombre, MaterialTrabajo.Costo, TipoMaterial.Nombre AS TipoMaterial
FROM MaterialTrabajo
JOIN TipoMaterial ON MaterialTrabajo.IDTipoMaterial = TipoMaterial.IDTipoMaterial;

-- 12. Tabla TipoTrabajo
SELECT IDTipoTrabajo, Nombre FROM TipoTrabajo;

-- 13. Tabla CotizacionDeterminada
SELECT CotizacionDeterminada.IDCotizacionDet, CotizacionDeterminada.FechaRecibido, CotizacionDeterminada.FechaEntregada, 
       CotizacionDeterminada.Traslado, CotizacionDeterminada.Ancho, CotizacionDeterminada.Largo, CotizacionDeterminada.Costo, 
       Cuenta.PrimerNombre, Cuenta.PrimerApellido, TipoTrabajo.Nombre AS TipoTrabajo, Estilo.Nombre AS Estilo
FROM CotizacionDeterminada
JOIN Cuenta ON CotizacionDeterminada.IDCuenta = Cuenta.IDCuenta
JOIN TipoTrabajo ON CotizacionDeterminada.IDTipoTrabajo = TipoTrabajo.IDTipoTrabajo
JOIN Estilo ON CotizacionDeterminada.IDEstilo = Estilo.IDEstilo;

-- 14. Tabla MaterialesPorTrabajoDeterminado
SELECT MaterialesPorTrabajoDeterminado.IDMaterial, MaterialTrabajo.Nombre AS MaterialNombre, 
       MaterialesPorTrabajoDeterminado.Cantidad, CotizacionDeterminada.IDCotizacionDet, 
       CotizacionDeterminada.Costo AS CostoTrabajo
FROM MaterialesPorTrabajoDeterminado
JOIN MaterialTrabajo ON MaterialesPorTrabajoDeterminado.IDMaterial = MaterialTrabajo.IDMaterialTrabajo
JOIN CotizacionDeterminada ON MaterialesPorTrabajoDeterminado.IDCortizacionDet = CotizacionDeterminada.IDCotizacionDet;

-- 15. Tabla MaterialesPorTrabajoEspecial
SELECT MaterialesPorTrabajoEspecial.IDMaterial, MaterialTrabajo.Nombre AS MaterialNombre, 
       CotizacionEspecial.Nombre AS CotizacionNombre
FROM MaterialesPorTrabajoEspecial
JOIN MaterialTrabajo ON MaterialesPorTrabajoEspecial.IDMaterial = MaterialTrabajo.IDMaterialTrabajo
JOIN CotizacionEspecial ON MaterialesPorTrabajoEspecial.IDCortizacionEsp = CotizacionEspecial.IDCotizacionEsp;

-- 16. Tabla Comentario
SELECT Comentario.IDComentario, Comentario.Comentario, Cuenta.PrimerNombre, Cuenta.PrimerApellido
FROM Comentario
JOIN Cuenta ON Comentario.IDCuenta = Cuenta.IDCuenta;
