/* Creacion de la base de datos */

--USE TTTGD1C2021

--CREATE DATABASE GD1C2021ENTREGA;
USE GD1C2021ENTREGA;
GO

/* Creacion de tablas */
CREATE TABLE Cliente(
	clie_DNI varchar(15) NOT NULL,
	clie_Apellido varchar(30) NOT NULL,
	clie_Nombre varchar(30) NOT NULL,
	clie_Direccion varchar(50) NULL,
	clie_fechaNacimiento date NULL, --yyyy
	clie_mail varchar(50) NULL,
	clie_telefono varchar(50) NULL
)


CREATE TABLE Factura(
	fact_idFactura varchar(15) NOT NULL,
	fact_idCliente varchar(15) NOT NULL,
	fact_Numero varchar(8) NOT NULL,
	fact_fecha smalldatetime NOT NULL,
	fact_Total decimal(14,2) NOT NULL
)

CREATE TABLE ItemFactura(
	ifact_idFactura varchar(15) NOT NULL,
	ifact_idProducto varchar(15) NOT NULL,
	ifact_idCategoria int NOT NULL,
	ifact_idCliente varchar(15) NOT NULL,
	ifact_Cantidad decimal(10,2) NOT NULL,
	ifact_PrecioFactura decimal(14,2) NOT NULL
)

CREATE TABLE Compra(
	comp_idCompra int NOT NULL,
	comp_idSucursal int NOT NULL,
	comp_idProveedor int NULL,
	comp_FechaCompra smalldatetime NOT NULL,
	comp_NumeroCompra varchar(8) NOT NULL,
	comp_GastoTotal decimal(14,2) NOT NULL
)

CREATE TABLE ItemCompra(
	icomp_idCompra int NOT NULL,
	icomp_idProducto varchar(15) NOT NULL,
	icomp_idCategoria int NOT NULL,
	icomp_PrecioCompra decimal(14,2) NOT NULL,
	icomp_Cantidad decimal(10,2)
)

CREATE TABLE Sucursal(
	sucu_idSucursal int IDENTITY(1,1)  NOT NULL,
	sucu_Mail varchar(50) NULL,
	sucu_Direccion varchar(50) NOT NULL,
	sucu_Telefono decimal(18, 0) NULL,
	sucu_Ciudad varchar(50) NULL
)

CREATE TABLE Stock(
	stoc_idStock int NOT NULL,
	stoc_idSucursal int NOT NULL,
	stoc_idCategoria int NOT NULL,
	stoc_idProducto varchar(15) NOT NULL,
	stoc_Cantidad decimal(10,2)
)

CREATE TABLE Producto(
	prod_codProducto varchar(15) NOT NULL,
	prod_idCategoria int NOT NULL,
	--prod_Decripcion varchar(50) NULL,
	prod_Precio decimal(14,2) NOT NULL
)

CREATE TABLE Categoria(
	cate_idCategoria int NOT NULL,
	cate_Descripcion  varchar(15) NOT NULL
)

CREATE TABLE Accesorio(
	acce_idCodigo varchar(15) NOT NULL,
	acce_Descripcion varchar(50) NULL
)

CREATE TABLE PC(
	pc_idCodigo varchar(15) NOT NULL,
	pc_alto varchar(15) NOT NULL,
	pc_ancho varchar(15) NOT NULL,
	pc_profundida varchar(15) NOT NULL,
	pc_idRam varchar(15) NOT NULL,
	pc_idMicro varchar(15) NOT NULL,
	pc_idVideo varchar(15) NOT NULL,
	pc_idDisco varchar(15) NOT NULL
)

CREATE TABLE Fabricante(
	fabr_codigo varchar(30) NOT NULL
)

CREATE TABLE RAM(
	ram_idRam varchar(15) NOT NULL,
	ram_Tipo varchar(20) NOT NULL,
	ram_Capacidad varchar(30) NOT NULL,
	ram_Velocidad varchar(30) NOT NULL,
	ram_idFabricante varchar(30) NOT NULL
)

CREATE TABLE Micro(
	micr_idMicro varchar(15) NOT NULL,
	micr_Cache varchar(20) NOT NULL,
	micr_CantHilos varchar(5) NOT NULL,
	micr_Velocidad varchar(30) NOT NULL,
	micr_idFabricante varchar(30) NOT NULL
)

CREATE TABLE Video(
	vide_Chipset varchar(30) NOT NULL,
	vide_Capacidad varchar(30) NOT NULL,
	vide_Velocidad varchar(30) NOT NULL,
	vide_Modelo varchar(15) NOT NULL,
	vide_idFabricante varchar(30) NOT NULL
)

CREATE TABLE Disco(
	disc_idDisco varchar(15) NOT NULL,
	disc_tipo varchar(30) NOT NULL,
	disc_capacidad varchar(30) NOT NULL,
	disc_velocidad varchar(30) NOT NULL,
	disc_idFabricante  varchar(30) NOT NULL
)
GO

/* Primaries key */

ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY(clie_DNI)

ALTER TABLE Categoria ADD CONSTRAINT PK_Categria PRIMARY KEY (cate_idCategoria)

ALTER TABLE Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (prod_codProducto, prod_idCategoria)

ALTER TABLE Proveedor  ADD CONSTRAINT PK_Proveedor PRIMARY KEY (prov_idProveedor)

ALTER TABLE Factura ADD	CONSTRAINT PK_Factura PRIMARY KEY(fact_idFactura,fact_idCliente)

ALTER TABLE ItemFactura ADD CONSTRAINT PK_ItemFactura PRIMARY KEY(ifact_idFactura, ifact_idProducto)

ALTER TABLE Compra ADD CONSTRAINT PK_Compra PRIMARY KEY(comp_idCompra)

ALTER TABLE ItemCompra ADD CONSTRAINT PK_ItemCompra PRIMARY KEY(icomp_idCompra, icomp_idProducto)

ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (sucu_idSucursal)

ALTER TABLE Stock ADD CONSTRAINT PK_Stock PRIMARY KEY (stoc_idStock)

ALTER TABLE Accesorio ADD CONSTRAINT PK_Accesorio PRIMARY KEY (acce_idCodigo)

ALTER TABLE PC ADD CONSTRAINT PK_PC PRIMARY KEY (pc_idCodigo)

ALTER TABLE RAM ADD CONSTRAINT PK_RAM PRIMARY KEY (ram_idRam)

ALTER TABLE Micro ADD CONSTRAINT PK_Micro PRIMARY KEY (micr_idMicro)

ALTER TABLE Video ADD CONSTRAINT PK_Video PRIMARY KEY (vide_Modelo)

ALTER TABLE Disco ADD CONSTRAINT PK_Disco PRIMARY KEY (disc_idDisco)

ALTER TABLE Fabricante ADD CONSTRAINT PK_Fabricante PRIMARY KEY (fabr_codigo)
GO

/* Foreings key */
ALTER TABLE Factura
ADD 
	CONSTRAINT FK_FacturaCliente FOREIGN KEY(fact_idCliente) REFERENCES Cliente(clie_DNI)

ALTER TABLE ItemFactura
ADD 
	CONSTRAINT FK_ItemFacturaFactura FOREIGN KEY(ifact_idFactura, ifact_idCliente) REFERENCES Factura(fact_idFactura,fact_idCliente),
	CONSTRAINT FK_ItemFacturaProducto FOREIGN KEY (ifact_idProducto, ifact_idCategoria) REFERENCES Producto(prod_codProducto, prod_idCategoria)

ALTER TABLE Compra
ADD
	CONSTRAINT FK_CompraProveedor FOREIGN KEY (comp_idProveedor) REFERENCES Proveedor(prov_idProveedor),
	CONSTRAINT FK_CompraSucursal FOREIGN KEY (comp_idSucursal) REFERENCES Sucursal(sucu_idSucursal)

ALTER TABLE ItemCompra
ADD 
	CONSTRAINT FK_ItemCompraCompra FOREIGN KEY (icomp_idCompra) REFERENCES Compra(comp_idCompra),
	CONSTRAINT FK_ItemCompraProducto FOREIGN KEY (icomp_idProducto, icomp_idCategoria) REFERENCES Producto(prod_codProducto, prod_idCategoria)


ALTER TABLE Stock
ADD 
	CONSTRAINT FK_StockSucursal FOREIGN KEY (stoc_idSucursal) REFERENCES Sucursal(sucu_idSucursal),
	CONSTRAINT FK_StockProducto FOREIGN KEY (stoc_idProducto, stoc_idCategoria) REFERENCES Producto(prod_codProducto, prod_idCategoria)

ALTER TABLE Producto
ADD
	CONSTRAINT FK_ProductoCategoria FOREIGN KEY (prod_idCategoria) REFERENCES Categoria(cate_idCategoria)


ALTER TABLE PC
ADD
	CONSTRAINT FK_PCRAM FOREIGN KEY (pc_idRam ) REFERENCES RAM(ram_idRam),
	CONSTRAINT FK_PCMicro FOREIGN KEY (pc_idMicro ) REFERENCES Micro(micr_idMicro),
	CONSTRAINT FK_PCVideo FOREIGN KEY (pc_idVideo) REFERENCES Video(vide_Modelo),
	CONSTRAINT FK_PCDisco FOREIGN KEY (pc_idDisco) REFERENCES Disco(disc_idDisco)

ALTER TABLE RAM
ADD 
	CONSTRAINT FK_RAMFabricante FOREIGN KEY (ram_idFabricante) REFERENCES Fabricante(fabr_codigo)

ALTER TABLE Micro
ADD 
	CONSTRAINT FK_MicroFabricante FOREIGN KEY (micr_idFabricante) REFERENCES Fabricante(fabr_codigo)

ALTER TABLE Video
ADD 
	CONSTRAINT FK_VideoFabricante FOREIGN KEY (vide_idFabricante) REFERENCES Fabricante(fabr_codigo)

ALTER TABLE Disco
ADD 
	CONSTRAINT FK_DiscoFabricante FOREIGN KEY (disc_idFabricante) REFERENCES Fabricante(fabr_codigo)
GO

/* Migracion */

-- Cliente
DECLARE @clie_Apellido varchar(30)
DECLARE @clie_Nombre varchar(30)
DECLARE @clie_DNI varchar(15) 
DECLARE @clie_Direccion varchar(15)
DECLARE @clie_FechaNacimiento date --Cambio
DECLARE @clie_Mail varchar(15)
DECLARE @clie_Telefono varchar(50)

DECLARE db_cursor_cliente CURSOR FOR 
SELECT  
	CLIENTE_APELLIDO,
	CLIENTE_NOMBRE,
	CLIENTE_DNI,
	CLIENTE_DIRECCION,
	CLIENTE_FECHA_NACIMIENTO,
	CLIENTE_MAIL,
	CLIENTE_TELEFONO
FROM TTTG1C2021.gd_esquema.Maestra
WHERE CLIENTE_DNI IS NOT NULL;

OPEN db_cursor_cliente  
FETCH NEXT FROM db_cursor_cliente INTO @clie_Apellido, @clie_Nombre, @clie_DNI, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono

WHILE @@FETCH_STATUS = 0  
BEGIN 
	BEGIN TRY  
     		INSERT INTO GD1C2021ENTREGA.dbo.Cliente (clie_Apellido, clie_Nombre, clie_DNI, clie_Direccion, clie_fechaNacimiento, clie_mail, clie_telefono)
			VALUES (@clie_Apellido, @clie_Nombre, @clie_DNI, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono)
	END TRY  
	BEGIN CATCH  
		  print 'Error al insertar registro.' 
	END CATCH 

	FETCH NEXT FROM db_cursor_cliente INTO @clie_Apellido, @clie_Nombre, @clie_DNI, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono
END 

CLOSE db_cursor_cliente  
DEALLOCATE db_cursor_cliente
GO

/*BEGIN TRY  
     if @@error = 2627
		insert Into Accesorio values(124,123)
END TRY  
BEGIN CATCH  
      print 'se intenoito jaksdjaks asdklj asdkj k'
END CATCH  
*/

-- Sucursal
DECLARE @sucu_Ciudad varchar(50)
DECLARE @sucu_Direccion varchar(50)
DECLARE @sucu_Mail varchar(50) 
DECLARE @sucu_Telefono decimal(18, 0)

DECLARE db_cursor_sucursal CURSOR FOR 
	SELECT  
		CIUDAD,
		SUCURSAL_DIR,
		SUCURSAL_MAIL,
		SUCURSAL_TEL
	FROM TTTG1C2021.gd_esquema.Maestra
	GROUP BY CIUDAD, SUCURSAL_DIR, SUCURSAL_MAIL, SUCURSAL_TEL;

OPEN db_cursor_sucursal  
FETCH NEXT FROM db_cursor_sucursal INTO @sucu_Ciudad, @sucu_Direccion, @sucu_Mail, @sucu_Telefono

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY  
     	INSERT INTO [GD1C2021ENTREGA].dbo.Sucursal(sucu_Mail, sucu_Direccion, sucu_Telefono, sucu_Ciudad)
		VALUES (@sucu_Mail, @sucu_Direccion, @sucu_Telefono, @sucu_Ciudad)
	END TRY  

	BEGIN CATCH  
		print 'Error al insertar registro.' 
	END CATCH 
	
	FETCH NEXT FROM db_cursor_sucursal INTO @sucu_Ciudad, @sucu_Direccion, @sucu_Mail, @sucu_Telefono
END 

CLOSE db_cursor_sucursal  
DEALLOCATE db_cursor_sucursal
GO

-- Fabricantes
DECLARE @fabr_codigo varchar(30)

DECLARE db_cursor_fabricante CURSOR FOR 
SELECT 
	DISCO_RIGIDO_FABRICANTE AS fabricante
    FROM TTTG1C2021.[gd_esquema].[Maestra]
	WHERE DISCO_RIGIDO_FABRICANTE IS NOT NULL
	GROUP BY DISCO_RIGIDO_FABRICANTE
UNION
SELECT
	MEMORIA_RAM_FABRICANTE AS fabricante
    FROM TTTG1C2021.[gd_esquema].[Maestra]
	WHERE [MEMORIA_RAM_FABRICANTE] IS NOT NULL
	GROUP BY [MEMORIA_RAM_FABRICANTE]
	UNION
SELECT
	MICROPROCESADOR_FABRICANTE AS fabricante
    FROM TTTG1C2021.[gd_esquema].[Maestra]
	WHERE [MICROPROCESADOR_FABRICANTE] IS NOT NULL
	GROUP BY [MICROPROCESADOR_FABRICANTE]
	  	UNION
SELECT
	PLACA_VIDEO_FABRICANTE AS fabricante
    FROM TTTG1C2021.[gd_esquema].[Maestra]
	    WHERE [PLACA_VIDEO_FABRICANTE] IS NOT NULL
	GROUP BY [PLACA_VIDEO_FABRICANTE]

OPEN db_cursor_fabricante  
FETCH NEXT FROM db_cursor_fabricante INTO @fabr_codigo

WHILE @@FETCH_STATUS = 0  
BEGIN  

	BEGIN TRY  
			INSERT INTO [GD1C2021ENTREGA].dbo.Fabricante(fabr_codigo)
			VALUES (@fabr_codigo)
	END TRY 
	BEGIN CATCH  
		  print 'Error al insertar registro.' 
	END CATCH 

	FETCH NEXT FROM db_cursor_fabricante INTO @fabr_codigo
END 

CLOSE db_cursor_fabricante  
DEALLOCATE db_cursor_fabricante
GO

-- Discos Rigidos

DECLARE @disc_Codigo varchar(15)
DECLARE @disc_Tipo varchar(30)
DECLARE @disc_Capacidad varchar(30)
DECLARE @disc_Velocidad varchar(30)
DECLARE @disc_Fabricante varchar(30)

DECLARE db_cursor_disco CURSOR FOR 
SELECT 
	DISCO_RIGIDO_CODIGO,
	DISCO_RIGIDO_TIPO,
	DISCO_RIGIDO_CAPACIDAD,
	DISCO_RIGIDO_VELOCIDAD,
	DISCO_RIGIDO_FABRICANTE
	FROM TTTG1C2021.[gd_esquema].[Maestra]
	WHERE [DISCO_RIGIDO_CODIGO] IS NOT NULL
	GROUP BY 
	DISCO_RIGIDO_CODIGO,
	DISCO_RIGIDO_TIPO,
	DISCO_RIGIDO_CAPACIDAD,
	DISCO_RIGIDO_VELOCIDAD,
	DISCO_RIGIDO_FABRICANTE

OPEN db_cursor_disco  
FETCH NEXT FROM db_cursor_disco INTO @disc_Codigo, @disc_Tipo, @disc_Capacidad, @disc_Velocidad, @disc_Fabricante

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY  
		INSERT INTO [GD1C2021ENTREGA].dbo.Disco(disc_idDisco, disc_tipo, disc_capacidad, disc_velocidad, disc_idFabricante)
		VALUES (@disc_Codigo, @disc_Tipo, @disc_Capacidad, @disc_Velocidad, @disc_Fabricante)
	END TRY 
	BEGIN CATCH  
		print 'Error al insertar registro.' 
	END CATCH 

	FETCH NEXT FROM db_cursor_disco INTO @disc_Codigo, @disc_Tipo, @disc_Capacidad, @disc_Velocidad, @disc_Fabricante
END 
CLOSE db_cursor_disco  
DEALLOCATE db_cursor_disco

GO

-- RAM

DECLARE @ram_idRam varchar(15)
DECLARE @ram_Tipo varchar(20)
DECLARE @ram_Capacidad varchar(30)
DECLARE @ram_Velocidad varchar(30)
DECLARE @ram_Fabricante varchar(30)

DECLARE db_cursor_ram CURSOR FOR 
SELECT 
	MEMORIA_RAM_CODIGO,
	MEMORIA_RAM_TIPO,
	MEMORIA_RAM_CAPACIDAD,
	MEMORIA_RAM_VELOCIDAD,
	MEMORIA_RAM_FABRICANTE
	FROM TTTG1C2021.[gd_esquema].[Maestra]
	WHERE MEMORIA_RAM_CODIGO IS NOT NULL
	GROUP BY 
	MEMORIA_RAM_CODIGO,
	MEMORIA_RAM_TIPO,
	MEMORIA_RAM_CAPACIDAD,
	MEMORIA_RAM_VELOCIDAD,
	MEMORIA_RAM_FABRICANTE

OPEN db_cursor_ram  
FETCH NEXT FROM db_cursor_ram INTO @ram_idRam, @ram_Tipo, @ram_Capacidad, @ram_Velocidad, @ram_Fabricante

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN TRY  
		INSERT INTO [GD1C2021ENTREGA].dbo.RAM(ram_idRam, ram_Tipo, ram_Capacidad, ram_Velocidad ,ram_idFabricante)
		VALUES (@ram_idRam, @ram_Tipo, @ram_Capacidad, @ram_Velocidad, @ram_Fabricante)
	END TRY 
	BEGIN CATCH  
		print 'Error al insertar registro.' 
	END CATCH

	FETCH NEXT FROM db_cursor_ram INTO  @ram_idRam, @ram_Tipo, @ram_Capacidad, @ram_Velocidad, @ram_Fabricante
END 

CLOSE db_cursor_ram  
DEALLOCATE db_cursor_ram
GO

-- Microprocesador

DECLARE @micr_idRam varchar(15)
DECLARE @micr_Cache varchar(20)
DECLARE @micr_CantHilos varchar(5)
DECLARE @micr_Velocidad varchar(30)
DECLARE @micr_idFabricante varchar(30)

DECLARE db_cursor_micro CURSOR FOR 
SELECT 
	MICROPROCESADOR_CODIGO,
	MICROPROCESADOR_CACHE,
	MICROPROCESADOR_CANT_HILOS,
	MICROPROCESADOR_VELOCIDAD,
	MICROPROCESADOR_FABRICANTE
	FROM TTTG1C2021.[gd_esquema].[Maestra]
	WHERE MICROPROCESADOR_CODIGO IS NOT NULL
	GROUP BY 
	MICROPROCESADOR_CODIGO,
	MICROPROCESADOR_CACHE,
	MICROPROCESADOR_CANT_HILOS,
	MICROPROCESADOR_VELOCIDAD,
	MICROPROCESADOR_FABRICANTE

OPEN db_cursor_micro  
FETCH NEXT FROM db_cursor_micro INTO @micr_idRam, @micr_Cache, @micr_CantHilos, @micr_Velocidad, @micr_idFabricante

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN TRY  
		INSERT INTO [GD1C2021ENTREGA].dbo.Micro(micr_idMicro, micr_Cache, micr_CantHilos, micr_Velocidad, micr_idFabricante)
		VALUES (@micr_idRam, @micr_Cache, @micr_CantHilos, @micr_Velocidad, @micr_idFabricante)
	END TRY 
	BEGIN CATCH  
		print 'Error al insertar registro.' 
	END CATCH

	FETCH NEXT FROM db_cursor_micro INTO @micr_idRam, @micr_Cache, @micr_CantHilos, @micr_Velocidad, @micr_idFabricante
END 

CLOSE db_cursor_micro  
DEALLOCATE db_cursor_micro
GO

-- Placa video

DECLARE @vide_Modelo varchar(15)
DECLARE @vide_Chipset varchar(20)
DECLARE @vide_Velocidad varchar(5)
DECLARE @vide_Capacidad varchar(30)
DECLARE @vide_idFabricante varchar(30)

DECLARE db_cursor_video CURSOR FOR 
SELECT 
	PLACA_VIDEO_MODELO,
	PLACA_VIDEO_CHIPSET,
	PLACA_VIDEO_VELOCIDAD,
	PLACA_VIDEO_CAPACIDAD,
	PLACA_VIDEO_FABRICANTE
	FROM TTTG1C2021.[gd_esquema].[Maestra]
	WHERE PLACA_VIDEO_MODELO IS NOT NULL
	GROUP BY 
	PLACA_VIDEO_MODELO,
	PLACA_VIDEO_CHIPSET,
	PLACA_VIDEO_VELOCIDAD,
	PLACA_VIDEO_CAPACIDAD,
	PLACA_VIDEO_FABRICANTE

OPEN db_cursor_video  
FETCH NEXT FROM db_cursor_video INTO @vide_Modelo, @vide_Chipset, @vide_Velocidad, @vide_Capacidad, @vide_idFabricante

WHILE @@FETCH_STATUS = 0  
BEGIN

	BEGIN TRY  
		INSERT INTO [GD1C2021ENTREGA].dbo.Video(vide_Modelo, vide_Chipset, vide_Velocidad, vide_Capacidad, vide_idFabricante)
		VALUES ( @vide_Modelo, @vide_Chipset, @vide_Velocidad, @vide_Capacidad, @vide_idFabricante)
	END TRY 
	BEGIN CATCH  
		print 'Error al insertar registro.' 
	END CATCH

	FETCH NEXT FROM db_cursor_video INTO @vide_Modelo, @vide_Chipset, @vide_Velocidad, @vide_Capacidad, @vide_idFabricante
END 

CLOSE db_cursor_video  
DEALLOCATE db_cursor_video
GO


-- PC

DECLARE @pc_codigo varchar(15)
DECLARE @pc_alto varchar(15)
DECLARE @pc_ancho varchar(15)
DECLARE @pc_profundidad varchar(15)
DECLARE @pc_idRam varchar(15)
DECLARE @pc_idVideo varchar(15)
DECLARE @pc_idDisco varchar(15)
DECLARE @pc_idMicro varchar(15)

DECLARE db_cursor_pc CURSOR FOR 
SELECT 
	PC_CODIGO,
	PC_ALTO,
	PC_ANCHO,
	PC_PROFUNDIDAD,
	MEMORIA_RAM_CODIGO,
	PLACA_VIDEO_MODELO,
	DISCO_RIGIDO_CODIGO,
	MICROPROCESADOR_CODIGO
	FROM TTTG1C2021.[gd_esquema].[Maestra]
	WHERE PC_CODIGO IS NOT NULL
	GROUP BY 
	PC_CODIGO,
	PC_ALTO,
	PC_ANCHO,
	PC_PROFUNDIDAD,
	MEMORIA_RAM_CODIGO,
	PLACA_VIDEO_MODELO,
	DISCO_RIGIDO_CODIGO,
	MICROPROCESADOR_CODIGO

OPEN db_cursor_pc  
FETCH NEXT FROM db_cursor_pc INTO @pc_codigo, @pc_alto, @pc_ancho, @pc_profundidad, @pc_idRam, @pc_idVideo, @pc_idDisco, @pc_idMicro

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN TRY  
		INSERT INTO [GD1C2021ENTREGA].dbo.PC(pc_idCodigo, pc_alto, pc_ancho, pc_profundida, pc_idRam, pc_idVideo, pc_idDisco, pc_idMicro)
		VALUES ( @pc_codigo, @pc_alto, @pc_ancho, @pc_profundidad, @pc_idRam, @pc_idVideo, @pc_idDisco, @pc_idMicro)
	END TRY 
	BEGIN CATCH  
		print 'Error al insertar registro.' 
	END CATCH
		
	FETCH NEXT FROM db_cursor_pc INTO @pc_codigo, @pc_alto, @pc_ancho, @pc_profundidad, @pc_idRam, @pc_idVideo, @pc_idDisco, @pc_idMicro
END 

CLOSE db_cursor_pc  
DEALLOCATE db_cursor_pc


-- ACCESORIO
DECLARE @acce_codigo varchar(15)
DECLARE @acce_descripcion varchar(50)


DECLARE db_cursor_accesorio CURSOR FOR 
SELECT 
	ACCESORIO_CODIGO,
	AC_DESCRIPCION
	FROM TTTG1C2021.[gd_esquema].[Maestra]
	WHERE ACCESORIO_CODIGO IS NOT NULL
	GROUP BY 
	ACCESORIO_CODIGO,
	AC_DESCRIPCION

OPEN db_cursor_accesorio  
FETCH NEXT FROM db_cursor_accesorio INTO @acce_codigo, @acce_descripcion

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY  
     		INSERT INTO [GD1C2021ENTREGA].dbo.Accesorio(acce_idCodigo,acce_Descripcion)
			VALUES ( @acce_codigo, @acce_descripcion)
	END TRY  
	BEGIN CATCH  
		  print 'Error al insertar registro.' 
	END CATCH 
		
	FETCH NEXT FROM db_cursor_accesorio INTO @acce_codigo, @acce_descripcion
END 

CLOSE db_cursor_accesorio  
DEALLOCATE db_cursor_accesorio

--CATEGORIA

INSERT INTO [GD1C2021ENTREGA].dbo.Categoria
			VALUES (1,'Accesorio')
INSERT INTO [GD1C2021ENTREGA].dbo.Categoria
			VALUES (2,'PC')
			--ARREGLAR IDENTITY

--COMPRA

DECLARE @com_idCompra int --compraNumero
DECLARE @com_idSucursal int --dato transaccional
DECLARE @com_FechaCompra smalldatetime
DECLARE @com_NumeroCompra varchar(8)
DECLARE @com_GastoTotal decimal(14,2)

DECLARE db_cursor_compra CURSOR FOR 
SELECT 
	CIUDAD,SUCURSAL_DIR,SUCURSAL_MAIL,SUCURSAL_TEL,COMPRA_FECHA,COMPRA_NUMERO,COMPRA_PRECIO,ACCESORIO_CODIGO,AC_DESCRIPCION,SUM(COMPRA_CANTIDAD) --COMPRA_NUMERO, ACCESORIO_CODIGO,SUM( COMPRA_CANTIDAD) AS CAntidad --COMPRA_NUMERO,COMPRA_CANTIDAD,COMPRA_FECHA,COMPRA_PRECIO
	FROM TTTG1C2021.[gd_esquema].[Maestra]
	--where COMPRA_NUMERO = '131209'
	--where COMPRA_NUMERO = '155437'
	GROUP BY CIUDAD,SUCURSAL_DIR,SUCURSAL_MAIL,SUCURSAL_TEL,COMPRA_FECHA,COMPRA_NUMERO,COMPRA_PRECIO,ACCESORIO_CODIGO,AC_DESCRIPCION--COMPRA_NUMERO, ACCESORIO_CODIGO --CIUDAD,SUCURSAL_DIR, SUCURSAL_MAIL, SUCURSAL_TEL,COMPRA_NUMERO,COMPRA_CANTIDAD,COMPRA_FECHA,COMPRA_PRECIO
	order by  COMPRA_NUMERO,compra_precio, SUM ( COMPRA_CANTIDAD) --ACCESORIO_CODIGO, COMPRA_CANTIDAD
	155437
	CIUDAD, SUCURSAL_DIR, SUCURSAL_MAIL, SUCURSAL_TEL
	JOIN 
	SELECT ROW_Number as adsfs , STUFF(SELECT
	CIUDAD,	SUCURSAL_DIR,	SUCURSAL_MAIL,	SUCURSAL_TEL
	FROM TTTG1C2021.gd_esquema.Maestra
	GROUP BY CIUDAD, SUCURSAL_DIR, SUCURSAL_MAIL, SUCURSAL_TEL)

	ON CIUDAD+SUCURSAL_DIR+SUCURSAL_MAIL+SUCURSAL_TEL = 


	WHERE COMPRA_FECHA IS NOT NULL
	GROUP BY SUCURSAL_DIR,SUCURSAL_MAIL,SUCURSAL_TEL,COMPRA_CANTIDAD,COMPRA_FECHA,COMPRA_NUMERO,COMPRA_PRECIO



OPEN db_cursor_compra  
FETCH NEXT FROM db_cursor_compra INTO --@acce_codigo, @acce_descripcion

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY  
     		--INSERT INTO [GD1C2021ENTREGA].dbo.Accesorio(acce_idCodigo,acce_Descripcion)
			--VALUES ( @acce_codigo, @acce_descripcion)
	END TRY  
	BEGIN CATCH  
		  print 'Error al insertar registro.' 
	END CATCH 
		
	FETCH NEXT FROM db_cursor_compra INTO --@acce_codigo, @acce_descripcion
END 

CLOSE db_cursor_compra
DEALLOCATE db_cursor_compra


