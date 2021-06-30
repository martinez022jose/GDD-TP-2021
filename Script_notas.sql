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
	--25160712 dni repetido
SELECT  
	CLIENTE_DNI,CLIENTE_APELLIDO,CLIENTE_NOMBRE
	CLIENTE_DIRECCION,
	CLIENTE_FECHA_NACIMIENTO,
	CLIENTE_MAIL,
	CLIENTE_TELEFONO
FROM GD1C2021.gd_esquema.Maestra
WHERE CLIENTE_DNI IS NOT NULL
group by CLIENTE_DNI,CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DIRECCION,
	CLIENTE_FECHA_NACIMIENTO,
	CLIENTE_MAIL,
	CLIENTE_TELEFONO
ORDER BY CLIENTE_DNI,CLIENTE_APELLIDO,CLIENTE_NOMBRE


	SELECT CLIENTE_DNI,CLIENTE_APELLIDO,CLIENTE_NOMBRE,count(*)
	from gd_esquema.Maestra
	WHERE CLIENTE_DNI is not null
	group by CLIENTE_DNI,CLIENTE_APELLIDO,CLIENTE_NOMBRE
	order by count(*)

 --Compra 48456 cantidad correcta
Se hace con Tabla temporal. Probar con TRIGERS

 SELECT * 
  FROM [GD1C2021].[gd_esquema].[Maestra]
  WHERE COMPRA_NUMERO IS NOT NULL
  ORDER BY COMPRA_NUMERO,ACCESORIO_CODIGO
 --Disco 4
	
	 SELECT 
	DISCO_RIGIDO_CODIGO,
	DISCO_RIGIDO_TIPO,
	DISCO_RIGIDO_CAPACIDAD,
	DISCO_RIGIDO_VELOCIDAD,
	DISCO_RIGIDO_FABRICANTE,
	count(DISCO_RIGIDO_CODIGO)
	FROM GD1C2021.[gd_esquema].[Maestra]
	WHERE [DISCO_RIGIDO_CODIGO] IS NOT NULL
	GROUP BY 
	DISCO_RIGIDO_CODIGO,
	DISCO_RIGIDO_TIPO,
	DISCO_RIGIDO_CAPACIDAD,
	DISCO_RIGIDO_VELOCIDAD,
	DISCO_RIGIDO_FABRICANTE

		
 --Micro 3 ok

 SELECT 
	MICROPROCESADOR_CODIGO,
	MICROPROCESADOR_CACHE,
	MICROPROCESADOR_CANT_HILOS,
	MICROPROCESADOR_VELOCIDAD,
	MICROPROCESADOR_FABRICANTE
	FROM GD1C2021.[gd_esquema].[Maestra]
	WHERE MICROPROCESADOR_CODIGO IS NOT NULL
	GROUP BY 
	MICROPROCESADOR_CODIGO,
	MICROPROCESADOR_CACHE,
	MICROPROCESADOR_CANT_HILOS,
	MICROPROCESADOR_VELOCIDAD,
	MICROPROCESADOR_FABRICANTE

 --PC 4 ok

	SELECT 
	PC_CODIGO,
	PC_ALTO,
	PC_ANCHO,
	PC_PROFUNDIDAD,
	MEMORIA_RAM_CODIGO,
	PLACA_VIDEO_MODELO,
	DISCO_RIGIDO_CODIGO,
	MICROPROCESADOR_CODIGO,
	COMPRA_PRECIO
	FROM GD1C2021.[gd_esquema].[Maestra]
	WHERE COMPRA_PRECIO IS NOT NULL AND PC_CODIGO IS NOT NULL 
	GROUP BY 
	PC_CODIGO,
	PC_ALTO,
	PC_ANCHO,
	PC_PROFUNDIDAD,
	MEMORIA_RAM_CODIGO,
	PLACA_VIDEO_MODELO,
	DISCO_RIGIDO_CODIGO,
	MICROPROCESADOR_CODIGO,
	COMPRA_PRECIO


 --RAM 3
 --Sucursal 7 ok
 --video  2 

 --Categoria NO ninguno
	 se setea manualmente

 --Fabricante 8 ok
	SELECT 
	[DISCO_RIGIDO_FABRICANTE] AS fabricante
    FROM GD1C2021.[gd_esquema].[Maestra]
	WHERE DISCO_RIGIDO_FABRICANTE IS NOT NULL
	GROUP BY DISCO_RIGIDO_FABRICANTE
UNION
SELECT
	[MEMORIA_RAM_FABRICANTE] AS fabricante
    FROM GD1C2021.[gd_esquema].[Maestra]
	WHERE [MEMORIA_RAM_FABRICANTE] IS NOT NULL
	GROUP BY [MEMORIA_RAM_FABRICANTE]
UNION
SELECT
	[MICROPROCESADOR_FABRICANTE] AS fabricante
    FROM GD1C2021.[gd_esquema].[Maestra]
	WHERE [MICROPROCESADOR_FABRICANTE] IS NOT NULL
	GROUP BY [MICROPROCESADOR_FABRICANTE]
	UNION
SELECT
	[PLACA_VIDEO_FABRICANTE] AS fabricante
    FROM GD1C2021.[gd_esquema].[Maestra]
	    WHERE [PLACA_VIDEO_FABRICANTE] IS NOT NULL
	GROUP BY [PLACA_VIDEO_FABRICANTE]

 --Factura 38700-38699
 LEER DESDE LA GENERACION DE LA TABLA ITEM COMPRA 
 /*
 select ACCESORIO_CODIGO,PC_CODIGO, COUNT(*) --* 
 FROM GD1C2021.[gd_esquema].[Maestra]
 where FACTURA_NUMERO = '68092675'
 group by ACCESORIO_CODIGO,PC_CODIGO

  select COMPRA_PRECIO, ACCESORIO_CODIGO,PC_CODIGO,COUNT(*) --* 
 FROM GD1C2021.[gd_esquema].[Maestra]
 where COMPRA_NUMERO = '171580'
 group by COMPRA_PRECIO,ACCESORIO_CODIGO,PC_CODIGO

 123134
 */
 SELECT
		FACTURA_NUMERO,
		CLIENTE_DNI,
		CLIENTE_NOMBRE,
		CLIENTE_APELLIDO,
		FACTURA_FECHA,
		PC_CODIGO,
		ACCESORIO_CODIGO,
		COUNT(PC_CODIGO) AS total_pc_vendido,
		COUNT(ACCESORIO_CODIGO) AS total_ac_vendido,
		COUNT(*)
	FROM GD1C2021.[gd_esquema].[Maestra]
	WHERE FACTURA_NUMERO IS NOT NULL
	GROUP BY 
		FACTURA_NUMERO,
		CLIENTE_DNI,
		CLIENTE_NOMBRE,
		CLIENTE_APELLIDO,
		FACTURA_FECHA,
		PC_CODIGO,
		ACCESORIO_CODIGO
	ORDER BY  FACTURA_NUMERO,ACCESORIO_CODIGO

 --itemCompra 49932

 SELECT
      [COMPRA_NUMERO],
	  [COMPRA_PRECIO],
	  SUM([COMPRA_CANTIDAD]) AS Cantidad,
	  [PC_CODIGO],
	  [ACCESORIO_CODIGO]
  FROM GD1C2021.[gd_esquema].[Maestra]
  WHERE COMPRA_NUMERO IS NOT NULL
  GROUP BY
	  [COMPRA_NUMERO],
	  [COMPRA_PRECIO],
  	  [PC_CODIGO],
	  [ACCESORIO_CODIGO]
 --itemFactura 39887

  SELECT
		FACTURA_NUMERO,
		CLIENTE_DNI,
		CLIENTE_NOMBRE,
		CLIENTE_APELLIDO,
		FACTURA_FECHA,
		PC_CODIGO,
		ACCESORIO_CODIGO,
		COUNT(PC_CODIGO) AS total_pc_vendido,
		COUNT(ACCESORIO_CODIGO) AS total_ac_vendido,
		COUNT(*)
	FROM GD1C2021.[gd_esquema].[Maestra]
	WHERE FACTURA_NUMERO IS NOT NULL
	GROUP BY 
		FACTURA_NUMERO,
		CLIENTE_DNI,
		CLIENTE_NOMBRE,
		CLIENTE_APELLIDO,
		FACTURA_FECHA,
		PC_CODIGO,
		ACCESORIO_CODIGO
	ORDER BY  FACTURA_NUMERO,ACCESORIO_CODIGO

 --Producto 8 //4 ACC + 4 PCs
 INSERTADO MIENTRAS SE INSERTA PCs Y ACCs

 --stock 56 rows
 triggers

 /****** Script for SelectTopNRows command from SSMS  ******/
SELECT ErrorMessage, count(*)
  FROM [GD1C2021].[FJGD_sql].[ERRORES]
  group by ErrorMessage

  SELECT *
  FROM [GD1C2021].[FJGD_sql].[Stock]
----------------------------------------
  SELECT *
  FROM [GD1C2021].[FJGD_sql].Cliente
  SELECT *
  FROM [GD1C2021].[FJGD_sql].Sucursal
  SELECT *
  FROM [GD1C2021].[FJGD_sql].Fabricante
  SELECT *
  FROM [GD1C2021].[FJGD_sql].Categoria
  SELECT *
  FROM [GD1C2021].[FJGD_sql].Accesorio
----------------------------------------
  SELECT *
  FROM [GD1C2021].[FJGD_sql].Compra
  
  SELECT *
  FROM [GD1C2021].[FJGD_sql].Factura
----------------------------------------
  SELECT *
  FROM [GD1C2021].[FJGD_sql].PC
  SELECT *
  FROM [GD1C2021].[FJGD_sql].Producto
----------------------------------------
  SELECT icomp_idProducto, icomp_PrecioCompra
  FROM [GD1C2021].[FJGD_sql].ItemCompra
  group by icomp_idProducto, icomp_PrecioCompra

  SELECT ifact_idProducto, ifact_PrecioProducto
  FROM [GD1C2021].[FJGD_sql].ItemFactura
  group by ifact_idProducto, ifact_PrecioProducto
  

  SELECT object_name(id) as objecto ,rowcnt
FROM sys.sysindexes
WHERE indid=1 and object_name(id) in ('Accesorio','Categoria','Cliente','Compra','Disco','Fabricante','Factura','ItemCompra','ItemFactura',
'Micro','PC','Producto','RAM','Stock','Sucursal','Video')
ORDER BY rowcnt


--drop schema FJGD_sql

--delete from [FJGD_sql].[ERRORES]
--drop table  [GD1C2021].FJGD_sql.ERRORES
/*
drop table  [GD1C2021].FJGD_sql.Stock
drop table  [GD1C2021].FJGD_sql.ItemCompra
drop table  [GD1C2021].FJGD_sql.ItemFactura

drop table  [GD1C2021].FJGD_sql.PC
drop table  [GD1C2021].FJGD_sql.Producto

drop table  [GD1C2021].FJGD_sql.Compra
drop table  [GD1C2021].FJGD_sql.Factura
drop table  [GD1C2021].FJGD_sql.RAM
drop table  [GD1C2021].FJGD_sql.Micro
drop table  [GD1C2021].FJGD_sql.Video
drop table  [GD1C2021].FJGD_sql.Disco

drop table  [GD1C2021].FJGD_sql.Cliente
drop table  [GD1C2021].FJGD_sql.Sucursal
drop table  [GD1C2021].FJGD_sql.Fabricante
drop table  [GD1C2021].FJGD_sql.Categoria
drop table  [GD1C2021].FJGD_sql.Accesorio

drop table FJGD_sql.BI_DIM_AC
drop table FJGD_sql.BI_DIM_Micro
drop table FJGD_sql.BI_DIM_Disco
drop table FJGD_sql.BI_DIM_Ram
drop table FJGD_sql.BI_DIM_Cliente
drop table FJGD_sql.BI_DIM_Fabricante
drop table FJGD_sql.BI_DIM_PC
drop table FJGD_sql.BI_DIM_Sucursal
drop table FJGD_sql.BI_DIM_Tiempo
drop table FJGD_sql.BI_DIM_RAM
drop table FJGD_sql.BI_DIM_Video

drop table FJGD_sql.BI_FACT_AC_COMPRA
drop table FJGD_sql.BI_FACT_AC_VENTA
drop table FJGD_sql.BI_FACT_PC_COMPRA
drop table FJGD_sql.BI_FACT_PC_VENTA

delete from FJGD_sql.BI_FACT_AC_COMPRA
delete from FJGD_sql.BI_FACT_AC_VENTA
delete from FJGD_sql.BI_FACT_PC_COMPRA

delete from FJGD_sql.BI_FACT_PC_VENTA

 FJGD_sql.BI_DIM_Tiempo

SELECT 
      [ErrorMessage]
     
  FROM [GD1C2021].[FJGD_sql].[ERRORES]
  group by [ErrorMessage]

*/

SELECT object_name(id) as objecto ,rowcnt
FROM sys.sysindexes
WHERE indid=1 and object_name(id) in ('BI_DIM_AC','BI_DIM_Micro','BI_DIM_Video','BI_DIM_Disco','BI_DIM_Fabricante','BI_DIM_Micro','Factura','ItemCompra','ItemFactura',
'Micro','PC','Producto','RAM','Stock','Sucursal','Video')
ORDER BY rowcnt