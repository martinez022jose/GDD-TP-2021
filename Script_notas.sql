/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [GD1C2021].[FJGD_sql].Video

  SELECT * --Distinct SUCURSAL_DIR
  FROM [GD1C2021].[gd_esquema].[Maestra]
  --Where SUCURSAL_DIR NOT LIKE 'Avenida%'
--Datos a Corregir
	AC_DESCRIPCION --Accesorio
	PLACA_VIDEO_MODELO --Modelo
	PLACA_VIDEO_CHIPSET --Chipset
	SUCURSAL_MAIL --Sucursal




 --Accesorios 4 PERFECTO
 SELECT ACCESORIO_CODIGO, AC_DESCRIPCION 
  FROM [GD1C2021].[gd_esquema].[Maestra]
  gROUP BY ACCESORIO_CODIGO, AC_DESCRIPCION
 --Cliente 38303 PERFECTO
	--25160712
	
 --Compra 48456

 SELECT * 
  FROM [GD1C2021].[gd_esquema].[Maestra]
  WHERE COMPRA_NUMERO IS NOT NULL
  ORDER BY COMPRA_NUMERO,ACCESORIO_CODIGO
 --Disco 4
 --Micro 3 
 --PC 4
 --RAM 3
 --Sucursal 7 ok
 --video  2 

 --Categoria NO ninguno
 --Fabricante Ninguno
 --Factura Ninguna
 --itemCompra Ninguno
 --itemFactura Ninguno
 --Producto Ninguno
 --stock Ninguno