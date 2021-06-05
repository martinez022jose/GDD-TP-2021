

--go
/* Creacion de Schemas */
CREATE SCHEMA FJGD;
GO 


/* Creacion de tablas */
CREATE TABLE FJGD.Cliente(
	clie_DNI varchar(15) NOT NULL,
	clie_Apellido varchar(30) NOT NULL,
	clie_Nombre varchar(30) NOT NULL,
	clie_Direccion varchar(50) NULL,
	clie_fechaNacimiento date NULL,
	clie_mail varchar(50) NULL,
	clie_telefono varchar(50) NULL
)

CREATE TABLE FJGD.Factura(
	fact_Numero decimal(18, 0) NOT NULL,
	fact_clieDNI varchar(15) NULL,
	fact_clieApellido varchar(30)NULL,
	fact_clieNombre varchar(30) NULL,
	fact_fecha smalldatetime NOT NULL,
	fact_Total decimal(14,2) NOT NULL
)

CREATE TABLE FJGD.ItemFactura(
	ifact_FacturaNumero decimal(18, 0) NOT NULL,
	ifact_idProducto varchar(15) NOT NULL,
	ifact_idCategoria int NOT NULL,
	ifact_Cantidad decimal(10,2) NOT NULL,
	ifact_PrecioProducto decimal(14,2) NOT NULL
)

CREATE TABLE FJGD.Compra(
	comp_NumeroCompra varchar(15) NOT NULL,
	comp_idSucursal int NOT NULL,
	comp_FechaCompra smalldatetime NOT NULL,
	comp_GastoTotal decimal(14,2) NOT NULL
)

CREATE TABLE FJGD.ItemCompra(
	icomp_NumeroCompra varchar(15) NOT NULL,
	icomp_idProducto varchar(15) NOT NULL,
	icomp_idCategoria int NOT NULL,
	icomp_PrecioCompra decimal(14,2) NOT NULL,
	icomp_Cantidad decimal(10,2)
)

CREATE TABLE FJGD.Sucursal(
	sucu_idSucursal int IDENTITY(1,1)  NOT NULL,
	sucu_Mail varchar(50) NULL,
	sucu_Direccion varchar(50) NOT NULL,
	sucu_Telefono decimal(18, 0) NULL,
	sucu_Ciudad varchar(50) NULL
)

CREATE TABLE FJGD.Stock(
	stoc_idStock int identity (1,1) NOT NULL,
	stoc_idSucursal int NOT NULL,
	stoc_idCategoria int NOT NULL,
	stoc_idProducto varchar(15) NOT NULL,
	stoc_Cantidad decimal(10,2)
)

CREATE TABLE FJGD.Producto(
	prod_codProducto varchar(15) NOT NULL,
	prod_idCategoria int NOT NULL,
	prod_Precio decimal(14,2) NOT NULL
)

CREATE TABLE FJGD.Categoria(
	cate_idCategoria int NOT NULL,
	cate_Descripcion  varchar(15) NOT NULL
)

CREATE TABLE FJGD.Accesorio(
	acce_idCodigo varchar(15) NOT NULL,
	acce_Descripcion varchar(50) NULL
)

CREATE TABLE FJGD.PC(
	pc_idCodigo varchar(15) NOT NULL,
	pc_alto varchar(15) NOT NULL,
	pc_ancho varchar(15) NOT NULL,
	pc_profundida varchar(15) NOT NULL,
	pc_idRam varchar(15) NOT NULL,
	pc_idMicro varchar(15) NOT NULL,
	pc_idVideo varchar(15) NOT NULL,
	pc_idDisco varchar(15) NOT NULL
)

CREATE TABLE FJGD.Fabricante(
	fabr_codigo varchar(30) NOT NULL
)

CREATE TABLE FJGD.RAM(
	ram_idRam varchar(15) NOT NULL,
	ram_Tipo varchar(20) NOT NULL,
	ram_Capacidad varchar(30) NOT NULL,
	ram_Velocidad varchar(30) NOT NULL,
	ram_idFabricante varchar(30) NOT NULL
)

CREATE TABLE FJGD.Micro(
	micr_idMicro varchar(15) NOT NULL,
	micr_Cache varchar(20) NOT NULL,
	micr_CantHilos varchar(5) NOT NULL,
	micr_Velocidad varchar(30) NOT NULL,
	micr_idFabricante varchar(30) NOT NULL
)

CREATE TABLE FJGD.Video(
	vide_Chipset varchar(30) NOT NULL,
	vide_Capacidad varchar(30) NOT NULL,
	vide_Velocidad varchar(30) NOT NULL,
	vide_Modelo varchar(15) NOT NULL,
	vide_idFabricante varchar(30) NOT NULL
)

CREATE TABLE FJGD.Disco(
	disc_idDisco varchar(15) NOT NULL,
	disc_tipo varchar(30) NOT NULL,
	disc_capacidad varchar(30) NOT NULL,
	disc_velocidad varchar(30) NOT NULL,
	disc_idFabricante  varchar(30) NOT NULL
)
GO

/* Primaries key */

ALTER TABLE FJGD.Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY(clie_DNI,clie_Nombre,clie_Apellido)

ALTER TABLE FJGD.Categoria ADD CONSTRAINT PK_Categria PRIMARY KEY (cate_idCategoria)

ALTER TABLE FJGD.Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (prod_codProducto, prod_idCategoria)

ALTER TABLE FJGD.Factura ADD CONSTRAINT PK_Factura PRIMARY KEY(fact_Numero)

ALTER TABLE FJGD.ItemFactura ADD CONSTRAINT PK_ItemFactura PRIMARY KEY(ifact_FacturaNumero, ifact_idProducto, ifact_idCategoria)

ALTER TABLE FJGD.Compra ADD CONSTRAINT PK_Compra PRIMARY KEY(comp_NumeroCompra)

ALTER TABLE FJGD.ItemCompra ADD CONSTRAINT PK_ItemCompra PRIMARY KEY(icomp_NumeroCompra, icomp_idProducto)

ALTER TABLE FJGD.Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (sucu_idSucursal)

ALTER TABLE FJGD.Stock ADD CONSTRAINT PK_Stock PRIMARY KEY (stoc_idStock)

ALTER TABLE FJGD.Accesorio ADD CONSTRAINT PK_Accesorio PRIMARY KEY (acce_idCodigo)

ALTER TABLE FJGD.PC ADD CONSTRAINT PK_PC PRIMARY KEY (pc_idCodigo)

ALTER TABLE FJGD.RAM ADD CONSTRAINT PK_RAM PRIMARY KEY (ram_idRam)

ALTER TABLE FJGD.Micro ADD CONSTRAINT PK_Micro PRIMARY KEY (micr_idMicro)

ALTER TABLE FJGD.Video ADD CONSTRAINT PK_Video PRIMARY KEY (vide_Modelo)

ALTER TABLE FJGD.Disco ADD CONSTRAINT PK_Disco PRIMARY KEY (disc_idDisco)

ALTER TABLE FJGD.Fabricante ADD CONSTRAINT PK_Fabricante PRIMARY KEY (fabr_codigo)
GO

/* Foreings key */
ALTER TABLE FJGD.Factura
ADD 
	CONSTRAINT FK_FacturaCliente FOREIGN KEY(fact_clieDNI,fact_clieNombre, fact_clieApellido) REFERENCES FJGD.Cliente(clie_DNI,clie_Nombre,clie_Apellido)
	--clie_Nombre, clie_Apellido

ALTER TABLE FJGD.ItemFactura
ADD 
	CONSTRAINT FK_ItemFacturaFactura FOREIGN KEY(ifact_FacturaNumero) REFERENCES FJGD.Factura(fact_Numero),
	CONSTRAINT FK_ItemFacturaProducto FOREIGN KEY (ifact_idProducto, ifact_idCategoria) REFERENCES FJGD.Producto(prod_codProducto, prod_idCategoria)

ALTER TABLE FJGD.Compra
ADD
	CONSTRAINT FK_CompraSucursal FOREIGN KEY (comp_idSucursal) REFERENCES FJGD.Sucursal(sucu_idSucursal)

ALTER TABLE FJGD.ItemCompra
ADD 
	CONSTRAINT FK_ItemCompraCompra FOREIGN KEY (icomp_NumeroCompra) REFERENCES FJGD.Compra(comp_NumeroCompra),
	CONSTRAINT FK_ItemCompraProducto FOREIGN KEY (icomp_idProducto, icomp_idCategoria) REFERENCES FJGD.Producto(prod_codProducto, prod_idCategoria)


ALTER TABLE FJGD.Stock
ADD 
	CONSTRAINT FK_StockSucursal FOREIGN KEY (stoc_idSucursal) REFERENCES FJGD.Sucursal(sucu_idSucursal),
	CONSTRAINT FK_StockProducto FOREIGN KEY (stoc_idProducto, stoc_idCategoria) REFERENCES FJGD.Producto(prod_codProducto, prod_idCategoria)

ALTER TABLE FJGD.Producto
ADD
	CONSTRAINT FK_ProductoCategoria FOREIGN KEY (prod_idCategoria) REFERENCES FJGD.Categoria(cate_idCategoria)


ALTER TABLE FJGD.PC
ADD
	CONSTRAINT FK_PCRAM FOREIGN KEY (pc_idRam ) REFERENCES FJGD.RAM(ram_idRam),
	CONSTRAINT FK_PCMicro FOREIGN KEY (pc_idMicro ) REFERENCES FJGD.Micro(micr_idMicro),
	CONSTRAINT FK_PCVideo FOREIGN KEY (pc_idVideo) REFERENCES FJGD.Video(vide_Modelo),
	CONSTRAINT FK_PCDisco FOREIGN KEY (pc_idDisco) REFERENCES FJGD.Disco(disc_idDisco)

ALTER TABLE FJGD.RAM
ADD 
	CONSTRAINT FK_RAMFabricante FOREIGN KEY (ram_idFabricante) REFERENCES FJGD.Fabricante(fabr_codigo)

ALTER TABLE FJGD.Micro
ADD 
	CONSTRAINT FK_MicroFabricante FOREIGN KEY (micr_idFabricante) REFERENCES FJGD.Fabricante(fabr_codigo)

ALTER TABLE FJGD.Video
ADD 
	CONSTRAINT FK_VideoFabricante FOREIGN KEY (vide_idFabricante) REFERENCES FJGD.Fabricante(fabr_codigo)

ALTER TABLE FJGD.Disco
ADD 
	CONSTRAINT FK_DiscoFabricante FOREIGN KEY (disc_idFabricante) REFERENCES FJGD.Fabricante(fabr_codigo)
GO

/* Inserts */

INSERT INTO FJGD.Categoria (cate_idCategoria, cate_Descripcion) VALUES (1,'PC'), (2,'ACCESORIO')
GO

/* Migracion */

-- Cliente

DECLARE @clie_Apellido varchar(30)
DECLARE @clie_Nombre varchar(30)
DECLARE @clie_DNI varchar(15) 
DECLARE @clie_Direccion varchar(15)
DECLARE @clie_FechaNacimiento smalldatetime
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
FROM gd_esquema.Maestra
WHERE CLIENTE_DNI IS NOT NULL
ORDER BY CLIENTE_DNI,CLIENTE_NOMBRE, CLIENTE_APELLIDO


OPEN db_cursor_cliente  
FETCH NEXT FROM db_cursor_cliente INTO @clie_Apellido, @clie_Nombre, @clie_DNI, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono

WHILE @@FETCH_STATUS = 0  
BEGIN  
	INSERT INTO FJGD.Cliente (clie_Apellido, clie_Nombre, clie_DNI, clie_Direccion, clie_fechaNacimiento, clie_mail, clie_telefono)
	VALUES (@clie_Apellido, @clie_Nombre, @clie_DNI, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono)

		FETCH NEXT FROM db_cursor_cliente INTO @clie_Apellido, @clie_Nombre, @clie_DNI, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono
END 

CLOSE db_cursor_cliente  
DEALLOCATE db_cursor_cliente
GO

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
FROM gd_esquema.Maestra
GROUP BY CIUDAD, SUCURSAL_DIR, SUCURSAL_MAIL, SUCURSAL_TEL;

OPEN db_cursor_sucursal  
FETCH NEXT FROM db_cursor_sucursal INTO @sucu_Ciudad, @sucu_Direccion, @sucu_Mail, @sucu_Telefono

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN
				BEGIN TRY
							INSERT INTO FJGD.Sucursal(sucu_Mail, sucu_Direccion, sucu_Telefono, sucu_Ciudad)
							VALUES (@sucu_Mail, @sucu_Direccion, @sucu_Telefono, @sucu_Ciudad)
					
				END TRY
				BEGIN CATCH 
					PRINT ERROR_MESSAGE()
				END CATCH
			FETCH NEXT FROM db_cursor_sucursal INTO @sucu_Ciudad, @sucu_Direccion, @sucu_Mail, @sucu_Telefono

	END 
END 

CLOSE db_cursor_sucursal  
DEALLOCATE db_cursor_sucursal


-- Fabricantes
--DELETE FROM dbo.Fabricante

DECLARE @fabr_codigo varchar(30)
DECLARE @errores_Sucursal nvarchar(255) = ''

DECLARE db_cursor_fabricante CURSOR FOR 
SELECT 
	[DISCO_RIGIDO_FABRICANTE] AS fabricante
    FROM gd_esquema.Maestra
	WHERE DISCO_RIGIDO_FABRICANTE IS NOT NULL
	GROUP BY DISCO_RIGIDO_FABRICANTE
UNION
SELECT
	[MEMORIA_RAM_FABRICANTE] AS fabricante
    FROM gd_esquema.Maestra
	WHERE [MEMORIA_RAM_FABRICANTE] IS NOT NULL
	GROUP BY [MEMORIA_RAM_FABRICANTE]
	UNION
SELECT
	[MICROPROCESADOR_FABRICANTE] AS fabricante
    FROM gd_esquema.Maestra
	WHERE [MICROPROCESADOR_FABRICANTE] IS NOT NULL
	GROUP BY [MICROPROCESADOR_FABRICANTE]
	  	UNION
SELECT
	[PLACA_VIDEO_FABRICANTE] AS fabricante
    FROM gd_esquema.Maestra
	    WHERE [PLACA_VIDEO_FABRICANTE] IS NOT NULL
	GROUP BY [PLACA_VIDEO_FABRICANTE]

OPEN db_cursor_fabricante  
FETCH NEXT FROM db_cursor_fabricante INTO @fabr_codigo

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
					INSERT INTO FJGD.Fabricante(fabr_codigo)
					VALUES (@fabr_codigo)

				
	END TRY
	BEGIN CATCH 
			PRINT ERROR_MESSAGE()
	END CATCH
	FETCH NEXT FROM db_cursor_fabricante INTO @fabr_codigo
END 
PRint @errores_Sucursal  
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
	FROM gd_esquema.Maestra
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
				INSERT INTO FJGD.Disco(disc_idDisco, disc_tipo, disc_capacidad, disc_velocidad, disc_idFabricante)
				VALUES (@disc_Codigo, @disc_Tipo, @disc_Capacidad, @disc_Velocidad, @disc_Fabricante)
			
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
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
	FROM gd_esquema.Maestra
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
			INSERT INTO FJGD.RAM(ram_idRam, ram_Tipo, ram_Capacidad, ram_Velocidad ,ram_idFabricante)
			VALUES (@ram_idRam, @ram_Tipo, @ram_Capacidad, @ram_Velocidad, @ram_Fabricante)

	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
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
	FROM gd_esquema.Maestra
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
				INSERT INTO FJGD.Micro(micr_idMicro, micr_Cache, micr_CantHilos, micr_Velocidad, micr_idFabricante)
				VALUES (@micr_idRam, @micr_Cache, @micr_CantHilos, @micr_Velocidad, @micr_idFabricante)

	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
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
	FROM gd_esquema.Maestra
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
				INSERT INTO FJGD.Video(vide_Modelo, vide_Chipset, vide_Velocidad, vide_Capacidad, vide_idFabricante)
				VALUES ( @vide_Modelo, @vide_Chipset, @vide_Velocidad, @vide_Capacidad, @vide_idFabricante)

		
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
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
DECLARE @prod_precio decimal(14,2)
DECLARE @cate_idPc int

SELECT @cate_idPc = cate_idCategoria FROM FJGD.Categoria WHERE cate_Descripcion = 'PC'

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
	FROM gd_esquema.Maestra
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
	BEGIN TRY
			INSERT INTO FJGD.PC(pc_idCodigo, pc_alto, pc_ancho, pc_profundida, pc_idRam, pc_idVideo, pc_idDisco, pc_idMicro)
			VALUES ( @pc_codigo, @pc_alto, @pc_ancho, @pc_profundidad, @pc_idRam, @pc_idVideo, @pc_idDisco, @pc_idMicro)
			INSERT INTO FJGD.Producto(prod_codProducto, prod_idCategoria, prod_Precio) VALUES ( @pc_codigo,  @cate_idPc, @prod_precio + (@prod_precio * 0.20)); 

	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
	
FETCH NEXT FROM db_cursor_pc INTO @pc_codigo, @pc_alto, @pc_ancho, @pc_profundidad, @pc_idRam, @pc_idVideo, @pc_idDisco, @pc_idMicro, @prod_precio

END 

CLOSE db_cursor_pc  
DEALLOCATE db_cursor_pc
GO

-- Accesorios
DECLARE @acce_codigo varchar(15)
DECLARE @acce_descripcion varchar(50)
DECLARE @prod_precio decimal(14,2)
DECLARE @cate_idAc int

SELECT @cate_idAc = cate_idCategoria FROM FJGD.Categoria WHERE cate_Descripcion = 'ACCESORIO'

DECLARE db_cursor_accesorio CURSOR FOR 
SELECT 
	ACCESORIO_CODIGO,
	AC_DESCRIPCION,
	COMPRA_PRECIO
  FROM gd_esquema.Maestra
  WHERE COMPRA_PRECIO IS NOT NULL AND ACCESORIO_CODIGO IS NOT NULL
  GROUP BY ACCESORIO_CODIGO, AC_DESCRIPCION, COMPRA_PRECIO


OPEN db_cursor_accesorio  
FETCH NEXT FROM db_cursor_accesorio INTO @acce_codigo, @acce_descripcion, @prod_precio

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
		INSERT INTO FJGD.Accesorio(acce_idCodigo, acce_Descripcion) VALUES ( @acce_codigo, @acce_descripcion)
		INSERT INTO FJGD.Producto(prod_codProducto, prod_idCategoria, prod_Precio) VALUES ( @acce_codigo,  @cate_idAc, @prod_precio);
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH

FETCH NEXT FROM db_cursor_accesorio INTO @acce_codigo, @acce_descripcion, @prod_precio
END 

CLOSE db_cursor_accesorio  
DEALLOCATE db_cursor_accesorio
GO

-- Compra

DECLARE @comp_NumeroCompra varchar(15)
DECLARE @comp_SucursalMail varchar(50)
DECLARE @comp_FechaCompra smalldatetime
DECLARE @comp_GastoTotal decimal(14,2)
DECLARE @comp_idSucursal int

DECLARE @Tabla_COMPRA TABLE( COMPRA_NUMERO decimal(18,0),SUCURSAL_MAIL varchar(50),COMPRA_FECHA smalldatetime,COMPRA_Monto_Subtotal decimal(18,2))
INSERT INTO @Tabla_COMPRA
			SELECT 
				COMPRA_NUMERO,
				SUCURSAL_MAIL,
				COMPRA_FECHA,
				COMPRA_PRECIO * SUM(COMPRA_CANTIDAD) AS COMPRA_Monto_Subtotal
			  FROM gd_esquema.Maestra
			  where COMPRA_NUMERO IS NOT NULL
			  GROUP BY 
				SUCURSAL_MAIL,
				COMPRA_FECHA,
				COMPRA_NUMERO,COMPRA_PRECIO;

DECLARE db_cursor_compra CURSOR FOR 

	SELECT 
		COMPRA_NUMERO,SUCURSAL_MAIL,COMPRA_FECHA,SUM(COMPRA_Monto_Subtotal)
		FROM @Tabla_COMPRA
		GROUP BY COMPRA_NUMERO, SUCURSAL_MAIL,COMPRA_FECHA

OPEN db_cursor_compra  
FETCH NEXT FROM db_cursor_compra INTO @comp_NumeroCompra, @comp_SucursalMail, @comp_FechaCompra, @comp_GastoTotal

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
				SELECT @comp_idSucursal = sucu_idSucursal FROM FJGD.Sucursal WHERE sucu_Mail= @comp_SucursalMail
				INSERT INTO FJGD.Compra(comp_NumeroCompra, comp_idSucursal, comp_FechaCompra, comp_GastoTotal) VALUES ( @comp_NumeroCompra, @comp_idSucursal, @comp_FechaCompra, @comp_GastoTotal)

	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
	FETCH NEXT FROM db_cursor_compra INTO @comp_NumeroCompra, @comp_SucursalMail, @comp_FechaCompra, @comp_GastoTotal
	
END 

CLOSE db_cursor_compra  
DEALLOCATE db_cursor_compra
GO

-- Item compra

DECLARE @icomp_NumeroCompra varchar(15)
DECLARE @icomp_idProducto varchar(15)
DECLARE @icomp_codPC varchar(15)
DECLARE @icomp_codAC varchar(15)
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
  FROM gd_esquema.Maestra
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
	BEGIN TRY
				IF @icomp_codPC IS NOT NULL
				BEGIN
					SELECT @icomp_idProducto = @icomp_codPC;
					SELECT @icomp_idCategoria = cate_idCategoria FROM FJGD.Categoria WHERE cate_Descripcion = 'PC';
				END
				ELSE
				BEGIN 
					SELECT @icomp_idProducto = @icomp_codAC;
					SELECT @icomp_idCategoria = cate_idCategoria FROM FJGD.Categoria WHERE cate_Descripcion = 'ACCESORIO';
				END

				INSERT INTO FJGD.ItemCompra(icomp_NumeroCompra, icomp_idProducto, icomp_idCategoria, icomp_PrecioCompra, icomp_Cantidad) VALUES (@icomp_NumeroCompra, @icomp_idProducto, @icomp_idCategoria, @icomp_PrecioCompra, @icomp_Cantidad)

	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
	
FETCH NEXT FROM db_cursor_item_compra INTO @icomp_NumeroCompra, @icomp_PrecioCompra, @icomp_Cantidad, @icomp_codPC, @icomp_codAC
END 

CLOSE db_cursor_item_compra  
DEALLOCATE db_cursor_item_compra
GO

-- Factura / Item Factura / PC
 
DECLARE @fact_NumeroFactura decimal(18,0)
DECLARE @fact_clieDNI varchar(15)
DECLARE @fact_clieNombre varchar(30)
DECLARE @fact_clieApellido varchar(30)
DECLARE @fact_fecha smalldatetime
--
DECLARE @ifact_idProducto varchar(15)
DECLARE @ifact_idCategoria int
DECLARE @ifact_Cantidad decimal(10,2)
DECLARE @ifact_PrecioProducto decimal(14,2)
--
DECLARE @ifact_PC varchar(15)
DECLARE @ifact_PC_total int

DECLARE @fact_created varchar(15)
DECLARE @fact_created_total varchar(15)


DECLARE db_cursor_item_factura_pc CURSOR FOR 
SELECT
		FACTURA_NUMERO,
		CLIENTE_DNI,
		CLIENTE_NOMBRE,
		CLIENTE_APELLIDO,
		FACTURA_FECHA,
		PC_CODIGO,
		COUNT(PC_CODIGO) AS total_pc_vendido
	FROM gd_esquema.Maestra
	WHERE FACTURA_NUMERO IS NOT NULL AND PC_CODIGO IS NOT NULL
	GROUP BY 
		FACTURA_NUMERO,
		CLIENTE_DNI,
		CLIENTE_NOMBRE,
		CLIENTE_APELLIDO,
		FACTURA_FECHA,
		PC_CODIGO
	ORDER BY FACTURA_NUMERO

OPEN db_cursor_item_factura_pc  
FETCH NEXT FROM db_cursor_item_factura_pc INTO @fact_NumeroFactura,@fact_clieDNI, @fact_clieNombre,@fact_clieApellido,  @fact_fecha, @ifact_PC, @ifact_PC_total
	
WHILE @@FETCH_STATUS = 0  
BEGIN  
		BEGIN
			SELECT @ifact_idProducto = @ifact_PC;
			SELECT @ifact_idCategoria = cate_idCategoria FROM FJGD.Categoria WHERE cate_Descripcion = 'PC'
			SELECT @ifact_Cantidad = @ifact_PC_total
			SELECT @ifact_PrecioProducto = prod_Precio FROM FJGD.Producto WHERE prod_codProducto = @ifact_PC AND prod_idCategoria = @ifact_idCategoria
		END

		BEGIN
		IF NOT EXISTS (SELECT fact_Numero FROM FJGD.Factura WHERE fact_Numero = @fact_NumeroFactura)
			BEGIN
			INSERT INTO FJGD.Factura(fact_Numero, fact_clieDNI, fact_clieApellido, fact_clieNombre, fact_fecha, fact_Total) VALUES (@fact_NumeroFactura, @fact_clieDNI, @fact_clieApellido, @fact_clieNombre, @fact_fecha, (@ifact_Cantidad * @ifact_PrecioProducto))
			END
		ELSE
			BEGIN
			SELECT @fact_created_total = fact_Total FROM FJGD.Factura WHERE fact_Numero = @fact_NumeroFactura
			UPDATE FJGD.Factura SET fact_Total = (@fact_created_total + (@ifact_PrecioProducto * @ifact_Cantidad)) WHERE fact_Numero = @fact_NumeroFactura;
			END
		END
	
		INSERT INTO FJGD.ItemFactura(ifact_FacturaNumero, ifact_idProducto, ifact_idCategoria, ifact_Cantidad, ifact_PrecioProducto) VALUES (@fact_NumeroFactura, @ifact_idProducto, @ifact_idCategoria, @ifact_Cantidad, @ifact_PrecioProducto)
	
FETCH NEXT FROM db_cursor_item_factura_pc INTO @fact_NumeroFactura,@fact_clieDNI, @fact_clieNombre,@fact_clieApellido,  @fact_fecha, @ifact_PC, @ifact_PC_total
END 

CLOSE db_cursor_item_factura_pc  
DEALLOCATE db_cursor_item_factura_pc
GO

-- Factura / Item Factura / AC
 
DECLARE @fact_NumeroFactura decimal(18,0)
DECLARE @fact_clieDNI varchar(15)
DECLARE @fact_clieNombre varchar(30)
DECLARE @fact_clieApellido varchar(30)
DECLARE @fact_fecha smalldatetime
--
DECLARE @ifact_idProducto varchar(15)
DECLARE @ifact_idCategoria int
DECLARE @ifact_Cantidad decimal(10,2)
DECLARE @ifact_PrecioProducto decimal(14,2)
--
DECLARE @ifact_AC varchar(15)
DECLARE @ifact_AC_total int

DECLARE @fact_created varchar(15)
DECLARE @fact_created_total varchar(15)


DECLARE db_cursor_item_factura_ac CURSOR FOR 
SELECT
		FACTURA_NUMERO,
		CLIENTE_DNI,
		CLIENTE_NOMBRE,
		CLIENTE_APELLIDO,
		FACTURA_FECHA,
		ACCESORIO_CODIGO,
		COUNT(ACCESORIO_CODIGO) AS total_ac_vendido
	FROM gd_esquema.Maestra
	WHERE FACTURA_NUMERO IS NOT NULL AND ACCESORIO_CODIGO IS NOT NULL
	GROUP BY 
		FACTURA_NUMERO,
		CLIENTE_DNI,
		CLIENTE_NOMBRE,
		CLIENTE_APELLIDO,
		FACTURA_FECHA,
		ACCESORIO_CODIGO
	ORDER BY ACCESORIO_CODIGO DESC , FACTURA_NUMERO

OPEN db_cursor_item_factura_ac  
FETCH NEXT FROM db_cursor_item_factura_ac INTO @fact_NumeroFactura,@fact_clieDNI, @fact_clieNombre,@fact_clieApellido,  @fact_fecha, @ifact_AC, @ifact_AC_total
	
WHILE @@FETCH_STATUS = 0  
BEGIN  
		
	BEGIN 
		SELECT @ifact_idProducto = @ifact_AC;
		SELECT @ifact_idCategoria = cate_idCategoria FROM FJGD.Categoria WHERE cate_Descripcion = 'ACCESORIO'
		SELECT @ifact_Cantidad = @ifact_AC_total
		SELECT @ifact_PrecioProducto = prod_Precio FROM FJGD.Producto WHERE prod_codProducto = @ifact_AC AND prod_idCategoria = @ifact_idCategoria
	END

	BEGIN
	IF NOT EXISTS (SELECT fact_Numero FROM FJGD.Factura WHERE fact_Numero = @fact_NumeroFactura)
		BEGIN
		INSERT INTO FJGD.Factura(fact_Numero, fact_clieDNI, fact_clieApellido, fact_clieNombre, fact_fecha, fact_Total) VALUES (@fact_NumeroFactura, @fact_clieDNI, @fact_clieApellido, @fact_clieNombre, @fact_fecha, (@ifact_Cantidad * @ifact_PrecioProducto))
		END
	ELSE
		BEGIN
		SELECT @fact_created_total = fact_Total FROM FJGD.Factura WHERE fact_Numero = @fact_NumeroFactura
		UPDATE FJGD.Factura SET fact_Total = (@fact_created_total + (@ifact_PrecioProducto * @ifact_Cantidad)) WHERE fact_Numero = @fact_NumeroFactura;
		END
	END
	
	INSERT INTO FJGD.ItemFactura(ifact_FacturaNumero, ifact_idProducto, ifact_idCategoria, ifact_Cantidad, ifact_PrecioProducto) VALUES (@fact_NumeroFactura, @ifact_idProducto, @ifact_idCategoria, @ifact_Cantidad, @ifact_PrecioProducto)

	
FETCH NEXT FROM db_cursor_item_factura_ac INTO @fact_NumeroFactura,@fact_clieDNI, @fact_clieNombre,@fact_clieApellido,  @fact_fecha, @ifact_AC, @ifact_AC_total
END 

CLOSE db_cursor_item_factura_ac  
DEALLOCATE db_cursor_item_factura_ac
GO

/* stock */

DECLARE @stoc_idSucursal int

DECLARE @stoc_SucursalDir varchar(50)
DECLARE @stoc_idCategoria int
DECLARE @stoc_idProducto varchar(15)
DECLARE @stoc_Cantidad decimal(10,2)
--Auxiliares
DECLARE @tablaVentas TABLE( SUCURSAL_DIR varchar(50),ACCESORIO_CODIGO varchar(15),PC_CODIGO varchar(15),CANTIDAD_VENDIDA int)
DECLARE @tablaCompras TABLE( SUCURSAL_DIR varchar(50),ACCESORIO_CODIGO varchar(15),PC_CODIGO varchar(15),CANTIDAD_COMPRADA int)
INSERT INTO @tablaVentas

SELECT [SUCURSAL_DIR],ISNULL(CONVERT(varchar(15),ACCESORIO_CODIGO),'0'),ISNULL(CONVERT(varchar(15),PC_CODIGO),'0'), COUNT(*)
  FROM gd_esquema.Maestra
  WHERE FACTURA_NUMERO IS NOT NULL
  GROUP BY [SUCURSAL_DIR],ACCESORIO_CODIGO, PC_CODIGO;

INSERT INTO @tablaCompras
SELECT [SUCURSAL_DIR],ISNULL(CONVERT(varchar(15),ACCESORIO_CODIGO),'0'),ISNULL(CONVERT(varchar(15),PC_CODIGO),'0'),COUNT(*)
  FROM gd_esquema.Maestra
  WHERE COMPRA_NUMERO IS NOT NULL
  GROUP BY [SUCURSAL_DIR],ACCESORIO_CODIGO,PC_CODIGO;

DECLARE db_cursor_stock CURSOR FOR 

SELECT   C.[SUCURSAL_DIR],
		prod_idCategoria,
		CASE 
			WHEN C.ACCESORIO_CODIGO = '0' THEN C.PC_CODIGO
			ELSE C.ACCESORIO_CODIGO
		END AS ID_PRODUCTO,
		C.CANTIDAD_COMPRADA- V.CANTIDAD_VENDIDA AS STOCK_TOTAL
FROM     @tablaCompras C
LEFT JOIN @tablaVentas V
ON C.SUCURSAL_DIR +C.ACCESORIO_CODIGO+C.PC_CODIGO = V.SUCURSAL_DIR +V.ACCESORIO_CODIGO+V.PC_CODIGO
join FJGD.Producto
ON C.ACCESORIO_CODIGO=prod_codProducto OR C.PC_CODIGO = prod_codProducto

OPEN db_cursor_stock  
FETCH NEXT FROM db_cursor_stock INTO @stoc_SucursalDir, @stoc_idCategoria, @stoc_idProducto, @stoc_Cantidad

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY

				SELECT @stoc_idSucursal = sucu_idSucursal FROM FJGD.Sucursal WHERE sucu_Direccion = @stoc_SucursalDir 
				INSERT INTO FJGD.Stock(stoc_idSucursal, stoc_idCategoria,stoc_idProducto,stoc_Cantidad) 
				VALUES ( @stoc_idSucursal, @stoc_idCategoria, @stoc_idProducto, @stoc_Cantidad)

	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
	
FETCH NEXT FROM db_cursor_stock INTO @stoc_SucursalDir, @stoc_idCategoria, @stoc_idProducto, @stoc_Cantidad

END 

CLOSE db_cursor_stock
DEALLOCATE db_cursor_stock
GO

