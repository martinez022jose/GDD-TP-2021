/* Creacion de la base de datos */

USE GD2015C1
DROP DATABASE GD1C2021ENTREGA;
CREATE DATABASE GD1C2021ENTREGA;
USE GD1C2021ENTREGA;
GO

/* Creacion de tablas */
CREATE TABLE Cliente(
	clie_DNI char(15) NOT NULL,
	clie_Apellido char(30) NOT NULL,
	clie_Nombre char(30) NOT NULL,
	clie_Direccion char(50) NULL,
	clie_fechaNacimiento smalldatetime NULL,
	clie_mail char(50) NULL,
	clie_telefono char(50) NULL
)

/*
	CREATE TABLE Proveedor(
		prov_idProveedor int NOT NULL,
		prov_idCompra int NOT NULL,
		prov_Descripcion char(50) NOT NULL
	)
*/

CREATE TABLE Factura(
	fact_idFactura char(15) NOT NULL,
	fact_idCliente char(15) NOT NULL,
	fact_Numero char(8) NOT NULL,
	fact_fecha smalldatetime NOT NULL,
	fact_Total decimal(14,2) NOT NULL
)

CREATE TABLE ItemFactura(
	ifact_idFactura char(15) NOT NULL,
	ifact_idProducto char(15) NOT NULL,
	ifact_idCategoria int NOT NULL,
	ifact_idCliente char(15) NOT NULL,
	ifact_Cantidad decimal(10,2) NOT NULL,
	ifact_PrecioFactura decimal(14,2) NOT NULL
)

CREATE TABLE Compra(
	comp_NumeroCompra char(15) NOT NULL,
	comp_idSucursal int NOT NULL,
	comp_FechaCompra smalldatetime NOT NULL,
	comp_GastoTotal decimal(14,2) NOT NULL
)

CREATE TABLE ItemCompra(
	icomp_idCompra char(15) NOT NULL,
	icomp_idProducto char(15) NOT NULL,
	icomp_idCategoria int NOT NULL,
	icomp_PrecioCompra decimal(14,2) NOT NULL,
	icomp_Cantidad decimal(10,2)
)

CREATE TABLE Sucursal(
	sucu_idSucursal int IDENTITY(1,1)  NOT NULL,
	sucu_Mail char(50) NULL,
	sucu_Direccion char(50) NOT NULL,
	sucu_Telefono decimal(18, 0) NULL,
	sucu_Ciudad char(50) NULL
)

CREATE TABLE Stock(
	stoc_idStock int NOT NULL,
	stoc_idSucursal int NOT NULL,
	stoc_idCategoria int NOT NULL,
	stoc_idProducto char(15) NOT NULL,
	stoc_Cantidad decimal(10,2)
)

CREATE TABLE Producto(
	prod_codProducto char(15) NOT NULL,
	prod_idCategoria int NOT NULL,
	prod_Decripcion char(50) NULL,
	prod_Precio decimal(14,2) NOT NULL
)

CREATE TABLE Categoria(
	cate_idCategoria int NOT NULL,
	cate_Descripcion  char(15) NOT NULL
)

CREATE TABLE Accesorio(
	acce_idCodigo char(15) NOT NULL,
	acce_Descripcion char(50) NULL
)

CREATE TABLE PC(
	pc_idCodigo char(15) NOT NULL,
	pc_alto char(15) NOT NULL,
	pc_ancho char(15) NOT NULL,
	pc_profundida char(15) NOT NULL,
	pc_idRam char(15) NOT NULL,
	pc_idMicro char(15) NOT NULL,
	pc_idVideo char(15) NOT NULL,
	pc_idDisco char(15) NOT NULL
)

CREATE TABLE Fabricante(
	fabr_codigo char(30) NOT NULL
)

CREATE TABLE RAM(
	ram_idRam char(15) NOT NULL,
	ram_Tipo char(20) NOT NULL,
	ram_Capacidad char(30) NOT NULL,
	ram_Velocidad char(30) NOT NULL,
	ram_idFabricante char(30) NOT NULL
)

CREATE TABLE Micro(
	micr_idMicro char(15) NOT NULL,
	micr_Cache char(20) NOT NULL,
	micr_CantHilos char(5) NOT NULL,
	micr_Velocidad char(30) NOT NULL,
	micr_idFabricante char(30) NOT NULL
)

CREATE TABLE Video(
	vide_Chipset char(30) NOT NULL,
	vide_Capacidad char(30) NOT NULL,
	vide_Velocidad char(30) NOT NULL,
	vide_Modelo char(15) NOT NULL,
	vide_idFabricante char(30) NOT NULL
)

CREATE TABLE Disco(
	disc_idDisco char(15) NOT NULL,
	disc_tipo char(30) NOT NULL,
	disc_capacidad char(30) NOT NULL,
	disc_velocidad char(30) NOT NULL,
	disc_idFabricante  char(30) NOT NULL
)
GO

/* Primaries key */

ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY(clie_DNI)

ALTER TABLE Categoria ADD CONSTRAINT PK_Categria PRIMARY KEY (cate_idCategoria)

ALTER TABLE Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (prod_codProducto, prod_idCategoria)

-- ALTER TABLE Proveedor  ADD CONSTRAINT PK_Proveedor PRIMARY KEY (prov_idProveedor)

ALTER TABLE Factura ADD	CONSTRAINT PK_Factura PRIMARY KEY(fact_idFactura,fact_idCliente)

ALTER TABLE ItemFactura ADD CONSTRAINT PK_ItemFactura PRIMARY KEY(ifact_idFactura, ifact_idProducto)

ALTER TABLE Compra ADD CONSTRAINT PK_Compra PRIMARY KEY(comp_NumeroCompra)

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
	-- CONSTRAINT FK_CompraProveedor FOREIGN KEY (comp_idProveedor) REFERENCES Proveedor(prov_idProveedor),
	CONSTRAINT FK_CompraSucursal FOREIGN KEY (comp_idSucursal) REFERENCES Sucursal(sucu_idSucursal)

ALTER TABLE ItemCompra
ADD 
	CONSTRAINT FK_ItemCompraCompra FOREIGN KEY (icomp_idCompra) REFERENCES Compra(comp_NumeroCompra),
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

/* Inserts */

INSERT INTO [GD1C2021ENTREGA].dbo.Categoria (cate_idCategoria, cate_Descripcion) VALUES (1,'PC'), (2,'ACCESORIO')
GO

/* Migracion */


-- Cliente
-- TODO: Revisa porque ejecuta con warning

DECLARE @clie_Apellido CHAR(30)
DECLARE @clie_Nombre CHAR(30)
DECLARE @clie_DNI CHAR(15) 
DECLARE @clie_Direccion CHAR(15)
DECLARE @clie_FechaNacimiento smalldatetime
DECLARE @clie_Mail CHAR(15)
DECLARE @clie_Telefono char(50)

DECLARE db_cursor_cliente CURSOR FOR 
SELECT  
	CLIENTE_APELLIDO,
	CLIENTE_NOMBRE,
	CLIENTE_DNI,
	CLIENTE_DIRECCION,
	CLIENTE_FECHA_NACIMIENTO,
	CLIENTE_MAIL,
	CLIENTE_TELEFONO
FROM [GD1C2021].gd_esquema.Maestra
WHERE CLIENTE_APELLIDO IS NOT NULL;

OPEN db_cursor_cliente  
FETCH NEXT FROM db_cursor_cliente INTO @clie_Apellido, @clie_Nombre, @clie_DNI, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono

WHILE @@FETCH_STATUS = 0  
BEGIN  
	INSERT INTO [GD1C2021ENTREGA].dbo.Cliente (clie_Apellido, clie_Nombre, clie_DNI, clie_Direccion, clie_fechaNacimiento, clie_mail, clie_telefono)
	VALUES (@clie_Apellido, @clie_Nombre, @clie_DNI, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono)

		FETCH NEXT FROM db_cursor_cliente INTO @clie_Apellido, @clie_Nombre, @clie_DNI, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono
END 

CLOSE db_cursor_cliente  
DEALLOCATE db_cursor_cliente
GO

-- Sucursal
DECLARE @sucu_Ciudad CHAR(50)
DECLARE @sucu_Direccion CHAR(50)
DECLARE @sucu_Mail CHAR(50) 
DECLARE @sucu_Telefono decimal(18, 0)

DECLARE db_cursor_sucursal CURSOR FOR 
SELECT  
	CIUDAD,
	SUCURSAL_DIR,
	SUCURSAL_MAIL,
	SUCURSAL_TEL
FROM [GD1C2021].gd_esquema.Maestra
GROUP BY CIUDAD, SUCURSAL_DIR, SUCURSAL_MAIL, SUCURSAL_TEL;

OPEN db_cursor_sucursal  
FETCH NEXT FROM db_cursor_sucursal INTO @sucu_Ciudad, @sucu_Direccion, @sucu_Mail, @sucu_Telefono

WHILE @@FETCH_STATUS = 0  
BEGIN  
	INSERT INTO [GD1C2021ENTREGA].dbo.Sucursal(sucu_Mail, sucu_Direccion, sucu_Telefono, sucu_Ciudad)
	VALUES (@sucu_Mail, @sucu_Direccion, @sucu_Telefono, @sucu_Ciudad)

FETCH NEXT FROM db_cursor_sucursal INTO @sucu_Ciudad, @sucu_Direccion, @sucu_Mail, @sucu_Telefono
END 

CLOSE db_cursor_sucursal  
DEALLOCATE db_cursor_sucursal
GO

-- Fabricantes
DECLARE @fabr_codigo CHAR(30)

DECLARE db_cursor_fabricante CURSOR FOR 
SELECT 
	[DISCO_RIGIDO_FABRICANTE] AS fabricante
    FROM [GD1C2021].[gd_esquema].[Maestra]
	WHERE DISCO_RIGIDO_FABRICANTE IS NOT NULL
	GROUP BY DISCO_RIGIDO_FABRICANTE
UNION
SELECT
	[MEMORIA_RAM_FABRICANTE] AS fabricante
    FROM [GD1C2021].[gd_esquema].[Maestra]
	WHERE [MEMORIA_RAM_FABRICANTE] IS NOT NULL
	GROUP BY [MEMORIA_RAM_FABRICANTE]
	UNION
SELECT
	[MICROPROCESADOR_FABRICANTE] AS fabricante
    FROM [GD1C2021].[gd_esquema].[Maestra]
	WHERE [MICROPROCESADOR_FABRICANTE] IS NOT NULL
	GROUP BY [MICROPROCESADOR_FABRICANTE]
	  	UNION
SELECT
	[PLACA_VIDEO_FABRICANTE] AS fabricante
    FROM [GD1C2021].[gd_esquema].[Maestra]
	    WHERE [PLACA_VIDEO_FABRICANTE] IS NOT NULL
	GROUP BY [PLACA_VIDEO_FABRICANTE]

OPEN db_cursor_fabricante  
FETCH NEXT FROM db_cursor_fabricante INTO @fabr_codigo

WHILE @@FETCH_STATUS = 0  
BEGIN  
	INSERT INTO [GD1C2021ENTREGA].dbo.Fabricante(fabr_codigo)
	VALUES (@fabr_codigo)

FETCH NEXT FROM db_cursor_fabricante INTO @fabr_codigo
END 

CLOSE db_cursor_fabricante  
DEALLOCATE db_cursor_fabricante
GO

-- Discos Rigidos

DECLARE @disc_Codigo CHAR(15)
DECLARE @disc_Tipo CHAR(30)
DECLARE @disc_Capacidad CHAR(30)
DECLARE @disc_Velocidad CHAR(30)
DECLARE @disc_Fabricante CHAR(30)

DECLARE db_cursor_disco CURSOR FOR 
SELECT 
	DISCO_RIGIDO_CODIGO,
	DISCO_RIGIDO_TIPO,
	DISCO_RIGIDO_CAPACIDAD,
	DISCO_RIGIDO_VELOCIDAD,
	DISCO_RIGIDO_FABRICANTE
	FROM [GD1C2021].[gd_esquema].[Maestra]
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
	INSERT INTO [GD1C2021ENTREGA].dbo.Disco(disc_idDisco, disc_tipo, disc_capacidad, disc_velocidad, disc_idFabricante)
	VALUES (@disc_Codigo, @disc_Tipo, @disc_Capacidad, @disc_Velocidad, @disc_Fabricante)

FETCH NEXT FROM db_cursor_disco INTO @disc_Codigo, @disc_Tipo, @disc_Capacidad, @disc_Velocidad, @disc_Fabricante
END 

CLOSE db_cursor_disco  
DEALLOCATE db_cursor_disco
GO

-- RAM

DECLARE @ram_idRam CHAR(15)
DECLARE @ram_Tipo CHAR(20)
DECLARE @ram_Capacidad CHAR(30)
DECLARE @ram_Velocidad CHAR(30)
DECLARE @ram_Fabricante CHAR(30)

DECLARE db_cursor_ram CURSOR FOR 
SELECT 
	MEMORIA_RAM_CODIGO,
	MEMORIA_RAM_TIPO,
	MEMORIA_RAM_CAPACIDAD,
	MEMORIA_RAM_VELOCIDAD,
	MEMORIA_RAM_FABRICANTE
	FROM [GD1C2021].[gd_esquema].[Maestra]
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
	INSERT INTO [GD1C2021ENTREGA].dbo.RAM(ram_idRam, ram_Tipo, ram_Capacidad, ram_Velocidad ,ram_idFabricante)
	VALUES (@ram_idRam, @ram_Tipo, @ram_Capacidad, @ram_Velocidad, @ram_Fabricante)

FETCH NEXT FROM db_cursor_ram INTO  @ram_idRam, @ram_Tipo, @ram_Capacidad, @ram_Velocidad, @ram_Fabricante
END 

CLOSE db_cursor_ram  
DEALLOCATE db_cursor_ram
GO

-- Microprocesador

DECLARE @micr_idRam CHAR(15)
DECLARE @micr_Cache CHAR(20)
DECLARE @micr_CantHilos CHAR(5)
DECLARE @micr_Velocidad CHAR(30)
DECLARE @micr_idFabricante CHAR(30)

DECLARE db_cursor_micro CURSOR FOR 
SELECT 
	MICROPROCESADOR_CODIGO,
	MICROPROCESADOR_CACHE,
	MICROPROCESADOR_CANT_HILOS,
	MICROPROCESADOR_VELOCIDAD,
	MICROPROCESADOR_FABRICANTE
	FROM [GD1C2021].[gd_esquema].[Maestra]
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
	INSERT INTO [GD1C2021ENTREGA].dbo.Micro(micr_idMicro, micr_Cache, micr_CantHilos, micr_Velocidad, micr_idFabricante)
	VALUES (@micr_idRam, @micr_Cache, @micr_CantHilos, @micr_Velocidad, @micr_idFabricante)

FETCH NEXT FROM db_cursor_micro INTO @micr_idRam, @micr_Cache, @micr_CantHilos, @micr_Velocidad, @micr_idFabricante
END 

CLOSE db_cursor_micro  
DEALLOCATE db_cursor_micro
GO

-- Placa video

DECLARE @vide_Modelo CHAR(15)
DECLARE @vide_Chipset CHAR(20)
DECLARE @vide_Velocidad CHAR(5)
DECLARE @vide_Capacidad CHAR(30)
DECLARE @vide_idFabricante CHAR(30)

DECLARE db_cursor_video CURSOR FOR 
SELECT 
	PLACA_VIDEO_MODELO,
	PLACA_VIDEO_CHIPSET,
	PLACA_VIDEO_VELOCIDAD,
	PLACA_VIDEO_CAPACIDAD,
	PLACA_VIDEO_FABRICANTE
	FROM [GD1C2021].[gd_esquema].[Maestra]
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
	INSERT INTO [GD1C2021ENTREGA].dbo.Video(vide_Modelo, vide_Chipset, vide_Velocidad, vide_Capacidad, vide_idFabricante)
	VALUES ( @vide_Modelo, @vide_Chipset, @vide_Velocidad, @vide_Capacidad, @vide_idFabricante)

FETCH NEXT FROM db_cursor_video INTO @vide_Modelo, @vide_Chipset, @vide_Velocidad, @vide_Capacidad, @vide_idFabricante
END 

CLOSE db_cursor_video  
DEALLOCATE db_cursor_video
GO


-- PC
DECLARE @pc_codigo CHAR(15)
DECLARE @pc_alto CHAR(15)
DECLARE @pc_ancho CHAR(15)
DECLARE @pc_profundidad CHAR(15)
DECLARE @pc_idRam CHAR(15)
DECLARE @pc_idVideo CHAR(15)
DECLARE @pc_idDisco CHAR(15)
DECLARE @pc_idMicro CHAR(15)
DECLARE @prod_precio decimal(14,2)
DECLARE @cate_idPc int

SELECT @cate_idPc = cate_idCategoria FROM [GD1C2021ENTREGA].dbo.Categoria WHERE cate_Descripcion = 'PC'

DECLARE db_cursor_pc CURSOR FOR 
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
	FROM [GD1C2021].[gd_esquema].[Maestra]
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

OPEN db_cursor_pc  
FETCH NEXT FROM db_cursor_pc INTO @pc_codigo, @pc_alto, @pc_ancho, @pc_profundidad, @pc_idRam, @pc_idVideo, @pc_idDisco, @pc_idMicro, @prod_precio

WHILE @@FETCH_STATUS = 0  
BEGIN  
	INSERT INTO [GD1C2021ENTREGA].dbo.PC(pc_idCodigo, pc_alto, pc_ancho, pc_profundida, pc_idRam, pc_idVideo, pc_idDisco, pc_idMicro)
	VALUES ( @pc_codigo, @pc_alto, @pc_ancho, @pc_profundidad, @pc_idRam, @pc_idVideo, @pc_idDisco, @pc_idMicro)

	-- TODO: Checkear que el precio seteado sea el correcto
	INSERT INTO [GD1C2021ENTREGA].dbo.Producto(prod_codProducto, prod_idCategoria, prod_Decripcion, prod_Precio) VALUES ( @pc_codigo,  @cate_idPc, 'PC ' + @pc_codigo, @prod_precio); 


FETCH NEXT FROM db_cursor_pc INTO @pc_codigo, @pc_alto, @pc_ancho, @pc_profundidad, @pc_idRam, @pc_idVideo, @pc_idDisco, @pc_idMicro, @prod_precio
END 

CLOSE db_cursor_pc  
DEALLOCATE db_cursor_pc
GO

-- Accesorios
DECLARE @acce_codigo CHAR(15)
DECLARE @acce_descripcion CHAR(50)
DECLARE @prod_precio decimal(14,2)
DECLARE @cate_idAc int

SELECT @cate_idAc = cate_idCategoria FROM [GD1C2021ENTREGA].dbo.Categoria WHERE cate_Descripcion = 'ACCESORIO'

DECLARE db_cursor_accesorio CURSOR FOR 
SELECT 
	ACCESORIO_CODIGO,
	AC_DESCRIPCION,
	COMPRA_PRECIO
  FROM [GD1C2021].[gd_esquema].[Maestra]
  WHERE COMPRA_PRECIO IS NOT NULL AND ACCESORIO_CODIGO IS NOT NULL
  GROUP BY ACCESORIO_CODIGO, AC_DESCRIPCION, COMPRA_PRECIO


OPEN db_cursor_accesorio  
FETCH NEXT FROM db_cursor_accesorio INTO @acce_codigo, @acce_descripcion, @prod_precio

WHILE @@FETCH_STATUS = 0  
BEGIN  
	INSERT INTO [GD1C2021ENTREGA].dbo.Accesorio(acce_idCodigo, acce_Descripcion) VALUES ( @acce_codigo, @acce_descripcion)
	-- TODO: Checkear que el precio seteado sea el correcto
	INSERT INTO [GD1C2021ENTREGA].dbo.Producto(prod_codProducto, prod_idCategoria, prod_Decripcion, prod_Precio) VALUES ( @acce_codigo,  @cate_idAc, @acce_descripcion, @prod_precio); 

FETCH NEXT FROM db_cursor_accesorio INTO @acce_codigo, @acce_descripcion, @prod_precio
END 

CLOSE db_cursor_accesorio  
DEALLOCATE db_cursor_accesorio
GO

-- Compra

DECLARE @comp_NumeroCompra char(15)
DECLARE @comp_SucursalMail char(50)
DECLARE @comp_FechaCompra smalldatetime
DECLARE @comp_GastoTotal decimal(14,2)
DECLARE @comp_idSucursal int

DECLARE db_cursor_compra CURSOR FOR 
SELECT 
	COMPRA_NUMERO,
	SUCURSAL_MAIL,
	COMPRA_FECHA,
	SUM(COMPRA_PRECIO) AS COMPRA_PRECIO
  FROM [GD1C2021].[gd_esquema].[Maestra]
  WHERE COMPRA_NUMERO IS NOT NULL
  GROUP BY 
	SUCURSAL_MAIL,
	COMPRA_FECHA,
	COMPRA_NUMERO


OPEN db_cursor_compra  
FETCH NEXT FROM db_cursor_compra INTO @comp_NumeroCompra, @comp_SucursalMail, @comp_FechaCompra, @comp_GastoTotal

WHILE @@FETCH_STATUS = 0  
BEGIN  
	
	SELECT @comp_idSucursal = sucu_idSucursal FROM [GD1C2021ENTREGA].dbo.Sucursal WHERE sucu_Mail= @comp_SucursalMail

	INSERT INTO [GD1C2021ENTREGA].dbo.Compra(comp_NumeroCompra, comp_idSucursal, comp_FechaCompra, comp_GastoTotal) VALUES ( @comp_NumeroCompra, @comp_idSucursal, @comp_FechaCompra, @comp_GastoTotal)

FETCH NEXT FROM db_cursor_compra INTO @comp_NumeroCompra, @comp_SucursalMail, @comp_FechaCompra, @comp_GastoTotal
END 

CLOSE db_cursor_compra  
DEALLOCATE db_cursor_compra
GO

-- Item compra

DECLARE @icomp_NumeroCompra char(15)
DECLARE @icomp_idProducto char(15)
DECLARE @icomp_codPC char(15)
DECLARE @icomp_codAC char(15)
DECLARE @icomp_idCategoria int
DECLARE @icomp_PrecioCompra decimal(14,2)
DECLARE @icomp_Cantidad decimal(10,0)

DECLARE db_cursor_item_compra CURSOR FOR 
SELECT
      [COMPRA_NUMERO],
	  [COMPRA_PRECIO],
	  SUM([COMPRA_CANTIDAD]) AS Cantidad,
	  [PC_CODIGO],
	  [ACCESORIO_CODIGO]
  FROM [GD1C2021].[gd_esquema].[Maestra]
  WHERE COMPRA_NUMERO IS NOT NULL
  GROUP BY
	  [COMPRA_NUMERO],
	  [COMPRA_PRECIO],
  	  [PC_CODIGO],
	  [ACCESORIO_CODIGO]

OPEN db_cursor_item_compra  
FETCH NEXT FROM db_cursor_item_compra INTO @icomp_NumeroCompra, @icomp_PrecioCompra, @icomp_Cantidad, @icomp_codPC, @icomp_codAC

WHILE @@FETCH_STATUS = 0  
BEGIN  
	
	IF @icomp_codPC IS NOT NULL
		BEGIN
			SELECT @icomp_idProducto = @icomp_codPC;
			SELECT @icomp_idCategoria = cate_idCategoria FROM Categoria WHERE cate_Descripcion = 'PC';
		END
	ELSE
		BEGIN 
			SELECT @icomp_idProducto = @icomp_codAC;
			SELECT @icomp_idCategoria = cate_idCategoria FROM Categoria WHERE cate_Descripcion = 'ACCESORIO';
		END

	INSERT INTO [GD1C2021ENTREGA].dbo.ItemCompra(icomp_idCompra, icomp_idProducto, icomp_idCategoria, icomp_PrecioCompra, icomp_Cantidad) VALUES (@icomp_NumeroCompra, @icomp_idProducto, @icomp_idCategoria, @icomp_PrecioCompra, @icomp_Cantidad)

FETCH NEXT FROM db_cursor_item_compra INTO @icomp_NumeroCompra, @icomp_PrecioCompra, @icomp_Cantidad, @icomp_codPC, @icomp_codAC
END 

CLOSE db_cursor_item_compra  
DEALLOCATE db_cursor_item_compra
GO
