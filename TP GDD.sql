--use GD1C2021
--go

/* Creacion de Schemas */
CREATE SCHEMA FJGD_sql;
GO 

/* Creacion de tablas */

CREATE TABLE FJGD_sql.ERRORES(
		  ErrorID        INT IDENTITY(1, 1),
          UserName       VARCHAR(100),
          ErrorNumber    INT,
          ErrorState     INT,
          ErrorSeverity  INT,
          ErrorLine      INT,
          ErrorProcedure VARCHAR(MAX),
          ErrorMessage   VARCHAR(MAX),
          ErrorDateTime  DATETIME
)

CREATE TABLE FJGD_sql.Cliente(
	clie_DNI varchar(15) NOT NULL,
	clie_Apellido varchar(30) NOT NULL,
	clie_Nombre varchar(30) NOT NULL,
	clie_Direccion varchar(50) NULL,
	clie_fechaNacimiento date NULL,
	clie_mail varchar(50) NULL,
	clie_telefono varchar(50) NULL,
	clie_sexo varchar(10)
)

CREATE TABLE FJGD_sql.Sucursal(
	sucu_idSucursal int IDENTITY(5551,1)  NOT NULL,
	sucu_Mail varchar(50) NULL,
	sucu_Direccion varchar(50) NOT NULL,
	sucu_Telefono varchar(18) NULL,
	sucu_Ciudad varchar(50) NULL
)

CREATE TABLE FJGD_sql.Fabricante(
	fabr_codigo varchar(30) NOT NULL
)

CREATE TABLE FJGD_sql.Categoria(
	cate_idCategoria varchar(15) NOT NULL
)

CREATE TABLE FJGD_sql.Accesorio(
	acce_idCodigo varchar(15) NOT NULL,
	acce_Descripcion varchar(50) NULL
)
--**********************************************************
CREATE TABLE FJGD_sql.Compra(
	comp_NumeroCompra varchar(15) NOT NULL,
	comp_idSucursal int NOT NULL,
	comp_FechaCompra smalldatetime NOT NULL,
	comp_GastoTotal decimal(14,2) NOT NULL
)

CREATE TABLE FJGD_sql.Factura(
	fact_Numero decimal(18, 0) NOT NULL,
	fact_clieDNI varchar(15) NULL,
	fact_clieApellido varchar(30)NULL,
	fact_clieNombre varchar(30) NULL,
	fact_idSucursal int NOT NULL,
	fact_fecha smalldatetime NOT NULL,
	fact_Total decimal(14,2) NOT NULL
)

CREATE TABLE FJGD_sql.RAM(
	ram_idRam varchar(15) NOT NULL,
	ram_Tipo varchar(20) NOT NULL,
	ram_Capacidad varchar(30) NOT NULL,
	ram_Velocidad varchar(30) NOT NULL,
	ram_idFabricante varchar(30) NOT NULL
)

CREATE TABLE FJGD_sql.Micro(
	micr_idMicro varchar(15) NOT NULL,
	micr_Cache varchar(20) NOT NULL,
	micr_CantHilos varchar(5) NOT NULL,
	micr_Velocidad varchar(30) NOT NULL,
	micr_idFabricante varchar(30) NOT NULL
)

CREATE TABLE FJGD_sql.Video(
	vide_Chipset varchar(30) NOT NULL,
	vide_Capacidad varchar(30) NOT NULL,
	vide_Velocidad varchar(30) NOT NULL,
	vide_Modelo varchar(15) NOT NULL,
	vide_idFabricante varchar(30) NOT NULL
)

CREATE TABLE FJGD_sql.Disco(
	disc_idDisco varchar(15) NOT NULL,
	disc_tipo varchar(30) NOT NULL,
	disc_capacidad varchar(30) NOT NULL,
	disc_velocidad varchar(30) NOT NULL,
	disc_idFabricante  varchar(30) NOT NULL
)

--**********************************************************
CREATE TABLE FJGD_sql.PC(
	pc_idCodigo varchar(15) NOT NULL,
	pc_alto varchar(15) NOT NULL,
	pc_ancho varchar(15) NOT NULL,
	pc_profundida varchar(15) NOT NULL,
	pc_idRam varchar(15) NOT NULL,
	pc_idMicro varchar(15) NOT NULL,
	pc_idVideo varchar(15) NOT NULL,
	pc_idDisco varchar(15) NOT NULL
)

CREATE TABLE FJGD_sql.Producto(
	prod_codProducto varchar(15) NOT NULL,
	prod_idCategoria varchar(15) NOT NULL,
	prod_Precio decimal(14,2) NOT NULL
)
--**********************************************************
CREATE TABLE FJGD_sql.Stock(
	stoc_idStock int identity (1,1) NOT NULL,
	stoc_idSucursal int NOT NULL,
	stoc_idCategoria varchar(15) NOT NULL,
	stoc_idProducto varchar(15) NOT NULL,
	stoc_Cantidad decimal(10,2)
)

CREATE TABLE FJGD_sql.ItemFactura(
	ifact_FacturaNumero decimal(18, 0) NOT NULL,
	ifact_idProducto varchar(15) NOT NULL,
	ifact_idCategoria varchar(15) NOT NULL,
	ifact_Cantidad decimal(10,2) NOT NULL,
	ifact_PrecioProducto decimal(14,2) NOT NULL
)

CREATE TABLE FJGD_sql.ItemCompra(
	icomp_NumeroCompra varchar(15) NOT NULL,
	icomp_idProducto varchar(15) NOT NULL,
	icomp_idCategoria varchar(15) NOT NULL,
	icomp_PrecioCompra decimal(14,2) NOT NULL,
	icomp_Cantidad decimal(10,2)
)

GO

/* Primaries key */

ALTER TABLE FJGD_sql.Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY(clie_DNI,clie_Apellido,clie_Nombre)

ALTER TABLE FJGD_sql.Categoria ADD CONSTRAINT PK_Categria PRIMARY KEY (cate_idCategoria)

ALTER TABLE FJGD_sql.Producto ADD CONSTRAINT PK_Producto PRIMARY KEY (prod_codProducto, prod_idCategoria)

ALTER TABLE FJGD_sql.Factura ADD CONSTRAINT PK_Factura PRIMARY KEY(fact_Numero)

ALTER TABLE FJGD_sql.ItemFactura ADD CONSTRAINT PK_ItemFactura PRIMARY KEY(ifact_FacturaNumero, ifact_idProducto, ifact_idCategoria)

ALTER TABLE FJGD_sql.Compra ADD CONSTRAINT PK_Compra PRIMARY KEY(comp_NumeroCompra)

ALTER TABLE FJGD_sql.ItemCompra ADD CONSTRAINT PK_ItemCompra PRIMARY KEY(icomp_NumeroCompra, icomp_idProducto)

ALTER TABLE FJGD_sql.Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (sucu_idSucursal)

ALTER TABLE FJGD_sql.Stock ADD CONSTRAINT PK_Stock PRIMARY KEY (stoc_idStock)

ALTER TABLE FJGD_sql.Accesorio ADD CONSTRAINT PK_Accesorio PRIMARY KEY (acce_idCodigo)

ALTER TABLE FJGD_sql.PC ADD CONSTRAINT PK_PC PRIMARY KEY (pc_idCodigo)

ALTER TABLE FJGD_sql.RAM ADD CONSTRAINT PK_RAM PRIMARY KEY (ram_idRam)

ALTER TABLE FJGD_sql.Micro ADD CONSTRAINT PK_Micro PRIMARY KEY (micr_idMicro)

ALTER TABLE FJGD_sql.Video ADD CONSTRAINT PK_Video PRIMARY KEY (vide_Modelo)

ALTER TABLE FJGD_sql.Disco ADD CONSTRAINT PK_Disco PRIMARY KEY (disc_idDisco)

ALTER TABLE FJGD_sql.Fabricante ADD CONSTRAINT PK_Fabricante PRIMARY KEY (fabr_codigo)
GO

/* Foreings key */
ALTER TABLE FJGD_sql.Factura
ADD 
	CONSTRAINT FK_FacturaCliente FOREIGN KEY(fact_clieDNI, fact_clieApellido,fact_clieNombre) REFERENCES FJGD_sql.Cliente(clie_DNI,clie_Apellido,clie_Nombre),
	CONSTRAINT FK_FacturaSucursal FOREIGN KEY(fact_idSucursal) REFERENCES FJGD_sql.Sucursal(sucu_idSucursal)

ALTER TABLE FJGD_sql.ItemFactura
ADD 
	CONSTRAINT FK_ItemFacturaFactura FOREIGN KEY(ifact_FacturaNumero) REFERENCES FJGD_sql.Factura(fact_Numero),
	CONSTRAINT FK_ItemFacturaProducto FOREIGN KEY (ifact_idProducto, ifact_idCategoria) REFERENCES FJGD_sql.Producto(prod_codProducto, prod_idCategoria)

ALTER TABLE FJGD_sql.Compra
ADD
	CONSTRAINT FK_CompraSucursal FOREIGN KEY (comp_idSucursal) REFERENCES FJGD_sql.Sucursal(sucu_idSucursal)

ALTER TABLE FJGD_sql.ItemCompra
ADD 
	CONSTRAINT FK_ItemCompraCompra FOREIGN KEY (icomp_NumeroCompra) REFERENCES FJGD_sql.Compra(comp_NumeroCompra),
	CONSTRAINT FK_ItemCompraProducto FOREIGN KEY (icomp_idProducto, icomp_idCategoria) REFERENCES FJGD_sql.Producto(prod_codProducto, prod_idCategoria)


ALTER TABLE FJGD_sql.Stock
ADD 
	CONSTRAINT FK_StockSucursal FOREIGN KEY (stoc_idSucursal) REFERENCES FJGD_sql.Sucursal(sucu_idSucursal),
	CONSTRAINT FK_StockProducto FOREIGN KEY (stoc_idProducto, stoc_idCategoria) REFERENCES FJGD_sql.Producto(prod_codProducto, prod_idCategoria)

ALTER TABLE FJGD_sql.Producto
ADD
	CONSTRAINT FK_ProductoCategoria FOREIGN KEY (prod_idCategoria) REFERENCES FJGD_sql.Categoria(cate_idCategoria)


ALTER TABLE FJGD_sql.PC
ADD
	CONSTRAINT FK_PCRAM FOREIGN KEY (pc_idRam ) REFERENCES FJGD_sql.RAM(ram_idRam),
	CONSTRAINT FK_PCMicro FOREIGN KEY (pc_idMicro ) REFERENCES FJGD_sql.Micro(micr_idMicro),
	CONSTRAINT FK_PCVideo FOREIGN KEY (pc_idVideo) REFERENCES FJGD_sql.Video(vide_Modelo),
	CONSTRAINT FK_PCDisco FOREIGN KEY (pc_idDisco) REFERENCES FJGD_sql.Disco(disc_idDisco)

ALTER TABLE FJGD_sql.RAM
ADD 
	CONSTRAINT FK_RAMFabricante FOREIGN KEY (ram_idFabricante) REFERENCES FJGD_sql.Fabricante(fabr_codigo)

ALTER TABLE FJGD_sql.Micro
ADD 
	CONSTRAINT FK_MicroFabricante FOREIGN KEY (micr_idFabricante) REFERENCES FJGD_sql.Fabricante(fabr_codigo)

ALTER TABLE FJGD_sql.Video
ADD 
	CONSTRAINT FK_VideoFabricante FOREIGN KEY (vide_idFabricante) REFERENCES FJGD_sql.Fabricante(fabr_codigo)

ALTER TABLE FJGD_sql.Disco
ADD 
	CONSTRAINT FK_DiscoFabricante FOREIGN KEY (disc_idFabricante) REFERENCES FJGD_sql.Fabricante(fabr_codigo)
GO

/* Inserts */

INSERT INTO FJGD_sql.Categoria (cate_idCategoria) VALUES ('PC'), ('ACCESORIO')
GO

/* Migracion */



-- Cliente
DECLARE @clie_DNI varchar(15) 
DECLARE @clie_Apellido varchar(30)
DECLARE @clie_Nombre varchar(30)
DECLARE @clie_Direccion varchar(15)
DECLARE @clie_FechaNacimiento date
DECLARE @clie_Mail varchar(15)
DECLARE @clie_Telefono varchar(50)
DECLARE @clie_Sexo varchar(10)

DECLARE db_cursor_cliente CURSOR FOR 
------------------------------------------
	SELECT  
		CLIENTE_DNI,CLIENTE_APELLIDO,CLIENTE_NOMBRE,
		CLIENTE_DIRECCION, CONVERT(date, CLIENTE_FECHA_NACIMIENTO) as CLIENTE_FECHA_NACIMIENTO, CLIENTE_MAIL, CLIENTE_TELEFONO
	FROM GD1C2021.gd_esquema.Maestra
	WHERE CLIENTE_DNI IS NOT NULL
	group by	
		CLIENTE_DNI,CLIENTE_APELLIDO,CLIENTE_NOMBRE,
		CLIENTE_DIRECCION, CLIENTE_FECHA_NACIMIENTO, CLIENTE_MAIL, CLIENTE_TELEFONO
------------------------------------------
OPEN db_cursor_cliente
FETCH NEXT FROM db_cursor_cliente INTO @clie_DNI,@clie_Apellido, @clie_Nombre,  @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN TRY
		
		IF (DAY(@clie_FechaNacimiento) > 15)
			SET @clie_Sexo = 'F'
		ELSE
			SET @clie_Sexo = 'M'
		INSERT INTO FJGD_sql.Cliente (clie_DNI, clie_Apellido, clie_Nombre, clie_Direccion, clie_fechaNacimiento, clie_mail, clie_telefono, clie_sexo)
		VALUES (@clie_DNI, @clie_Apellido, @clie_Nombre, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono, @clie_Sexo)
	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
	END CATCH

	FETCH NEXT FROM db_cursor_cliente INTO @clie_DNI,@clie_Apellido, @clie_Nombre,  @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono
END 

CLOSE db_cursor_cliente  
DEALLOCATE db_cursor_cliente
GO

-- Sucursal
DECLARE @sucu_Mail varchar(50) 
DECLARE @sucu_Direccion varchar(50)
DECLARE @sucu_Telefono varchar(18)
DECLARE @sucu_Ciudad varchar(50)

DECLARE db_cursor_sucursal CURSOR FOR 
------------------------------------------
SELECT  
	SUCURSAL_MAIL, SUCURSAL_DIR, SUCURSAL_TEL, CIUDAD
FROM GD1C2021.gd_esquema.Maestra
GROUP BY 
	SUCURSAL_MAIL, SUCURSAL_DIR, SUCURSAL_TEL, CIUDAD;
------------------------------------------
OPEN db_cursor_sucursal  
FETCH NEXT FROM db_cursor_sucursal INTO @sucu_Mail,@sucu_Direccion,@sucu_Telefono,@sucu_Ciudad

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN TRY
		INSERT INTO FJGD_sql.Sucursal(sucu_Mail, sucu_Direccion, sucu_Telefono, sucu_Ciudad)
		VALUES (@sucu_Mail, @sucu_Direccion, @sucu_Telefono, @sucu_Ciudad)
	END TRY
	BEGIN CATCH 
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
	END CATCH

	FETCH NEXT FROM db_cursor_sucursal INTO @sucu_Mail,@sucu_Direccion,@sucu_Telefono,@sucu_Ciudad
END 

CLOSE db_cursor_sucursal  
DEALLOCATE db_cursor_sucursal
go


-- Fabricantes
DECLARE @fabr_codigo varchar(30)

DECLARE db_cursor_fabricante CURSOR FOR 
------------------------------------------
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
------------------------------------------
OPEN db_cursor_fabricante  
FETCH NEXT FROM db_cursor_fabricante INTO @fabr_codigo

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
		INSERT INTO FJGD_sql.Fabricante(fabr_codigo)
		VALUES (@fabr_codigo)
	END TRY
	BEGIN CATCH 
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
	END CATCH

	FETCH NEXT FROM db_cursor_fabricante INTO @fabr_codigo
END 
CLOSE db_cursor_fabricante
DEALLOCATE db_cursor_fabricante

GO

-- RAM

DECLARE @ram_idRam varchar(15)
DECLARE @ram_Tipo varchar(20)
DECLARE @ram_Capacidad varchar(30)
DECLARE @ram_Velocidad varchar(30)
DECLARE @ram_Fabricante varchar(30)

DECLARE db_cursor_ram CURSOR FOR
------------------------------------------
SELECT 
	MEMORIA_RAM_CODIGO,
	MEMORIA_RAM_TIPO, MEMORIA_RAM_CAPACIDAD, MEMORIA_RAM_VELOCIDAD, MEMORIA_RAM_FABRICANTE
FROM GD1C2021.[gd_esquema].[Maestra]
WHERE MEMORIA_RAM_CODIGO IS NOT NULL
GROUP BY 
	MEMORIA_RAM_CODIGO,
	MEMORIA_RAM_TIPO, MEMORIA_RAM_CAPACIDAD, MEMORIA_RAM_VELOCIDAD, MEMORIA_RAM_FABRICANTE
------------------------------------------
OPEN db_cursor_ram  
FETCH NEXT FROM db_cursor_ram INTO @ram_idRam, @ram_Tipo, @ram_Capacidad, @ram_Velocidad, @ram_Fabricante

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
		INSERT INTO FJGD_sql.RAM(ram_idRam, ram_Tipo, ram_Capacidad, ram_Velocidad ,ram_idFabricante)
		VALUES (@ram_idRam, @ram_Tipo, @ram_Capacidad, @ram_Velocidad, @ram_Fabricante)
	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
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
------------------------------------------
SELECT 
	MICROPROCESADOR_CODIGO,
	MICROPROCESADOR_CACHE, MICROPROCESADOR_CANT_HILOS, MICROPROCESADOR_VELOCIDAD, MICROPROCESADOR_FABRICANTE
FROM GD1C2021.[gd_esquema].[Maestra]
WHERE MICROPROCESADOR_CODIGO IS NOT NULL
GROUP BY 
	MICROPROCESADOR_CODIGO,
	MICROPROCESADOR_CACHE, MICROPROCESADOR_CANT_HILOS, MICROPROCESADOR_VELOCIDAD, MICROPROCESADOR_FABRICANTE
------------------------------------------
OPEN db_cursor_micro  
FETCH NEXT FROM db_cursor_micro INTO @micr_idRam, @micr_Cache, @micr_CantHilos, @micr_Velocidad, @micr_idFabricante

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
		INSERT INTO FJGD_sql.Micro(micr_idMicro, micr_Cache, micr_CantHilos, micr_Velocidad, micr_idFabricante)
		VALUES (@micr_idRam, @micr_Cache, @micr_CantHilos, @micr_Velocidad, @micr_idFabricante)
	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
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
------------------------------------------
SELECT 
	PLACA_VIDEO_MODELO,
	PLACA_VIDEO_CHIPSET,PLACA_VIDEO_VELOCIDAD,PLACA_VIDEO_CAPACIDAD,PLACA_VIDEO_FABRICANTE
FROM GD1C2021.[gd_esquema].[Maestra]
WHERE PLACA_VIDEO_MODELO IS NOT NULL
GROUP BY 
	PLACA_VIDEO_MODELO,
	PLACA_VIDEO_CHIPSET,PLACA_VIDEO_VELOCIDAD,PLACA_VIDEO_CAPACIDAD,PLACA_VIDEO_FABRICANTE
------------------------------------------
OPEN db_cursor_video  
FETCH NEXT FROM db_cursor_video INTO @vide_Modelo, @vide_Chipset, @vide_Velocidad, @vide_Capacidad, @vide_idFabricante

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN TRY
		INSERT INTO FJGD_sql.Video(vide_Modelo, vide_Chipset, vide_Velocidad, vide_Capacidad, vide_idFabricante)
		VALUES ( @vide_Modelo, @vide_Chipset, @vide_Velocidad, @vide_Capacidad, @vide_idFabricante)		
	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
	END CATCH
	FETCH NEXT FROM db_cursor_video INTO @vide_Modelo, @vide_Chipset, @vide_Velocidad, @vide_Capacidad, @vide_idFabricante
END 

CLOSE db_cursor_video  
DEALLOCATE db_cursor_video
GO

-- Discos Rigidos

DECLARE @disc_Codigo varchar(15)
DECLARE @disc_Tipo varchar(30)
DECLARE @disc_Capacidad varchar(30)
DECLARE @disc_Velocidad varchar(30)
DECLARE @disc_Fabricante varchar(30)

DECLARE db_cursor_disco CURSOR FOR 
------------------------------------------
SELECT 
	DISCO_RIGIDO_CODIGO,
	DISCO_RIGIDO_TIPO,DISCO_RIGIDO_CAPACIDAD, DISCO_RIGIDO_VELOCIDAD, DISCO_RIGIDO_FABRICANTE
FROM GD1C2021.[gd_esquema].[Maestra]
WHERE [DISCO_RIGIDO_CODIGO] IS NOT NULL
GROUP BY 
	DISCO_RIGIDO_CODIGO,
	DISCO_RIGIDO_TIPO, DISCO_RIGIDO_CAPACIDAD, DISCO_RIGIDO_VELOCIDAD, DISCO_RIGIDO_FABRICANTE
------------------------------------------
OPEN db_cursor_disco  
FETCH NEXT FROM db_cursor_disco INTO @disc_Codigo, @disc_Tipo, @disc_Capacidad, @disc_Velocidad, @disc_Fabricante

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
		INSERT INTO FJGD_sql.Disco(disc_idDisco, disc_tipo, disc_capacidad, disc_velocidad, disc_idFabricante)
		VALUES (@disc_Codigo, @disc_Tipo, @disc_Capacidad, @disc_Velocidad, @disc_Fabricante)
	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
	END CATCH

	FETCH NEXT FROM db_cursor_disco INTO @disc_Codigo, @disc_Tipo, @disc_Capacidad, @disc_Velocidad, @disc_Fabricante
END 

CLOSE db_cursor_disco  
DEALLOCATE db_cursor_disco
GO

----------------------------------------------------------------------------------------------------------------------
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
DECLARE @cate_idPc varchar(15)

SELECT @cate_idPc = cate_idCategoria FROM FJGD_sql.Categoria WHERE cate_idCategoria = 'PC'

DECLARE db_cursor_pc CURSOR FOR 
------------------------------------------
SELECT 
	PC_CODIGO,
	PC_ALTO,PC_ANCHO,PC_PROFUNDIDAD,
	MEMORIA_RAM_CODIGO,	PLACA_VIDEO_MODELO,	DISCO_RIGIDO_CODIGO,MICROPROCESADOR_CODIGO,
	COMPRA_PRECIO
FROM GD1C2021.[gd_esquema].[Maestra]
WHERE COMPRA_PRECIO IS NOT NULL AND PC_CODIGO IS NOT NULL 
GROUP BY 
	PC_CODIGO,
	PC_ALTO,PC_ANCHO,PC_PROFUNDIDAD,
	MEMORIA_RAM_CODIGO,	PLACA_VIDEO_MODELO,	DISCO_RIGIDO_CODIGO,	MICROPROCESADOR_CODIGO,
	COMPRA_PRECIO
------------------------------------------
OPEN db_cursor_pc  
FETCH NEXT FROM db_cursor_pc INTO @pc_codigo, @pc_alto, @pc_ancho, @pc_profundidad, @pc_idRam, @pc_idVideo, @pc_idDisco, @pc_idMicro, @prod_precio

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
			INSERT INTO FJGD_sql.PC(pc_idCodigo, pc_alto, pc_ancho, pc_profundida, pc_idRam, pc_idVideo, pc_idDisco, pc_idMicro)
			VALUES ( @pc_codigo, @pc_alto, @pc_ancho, @pc_profundidad, @pc_idRam, @pc_idVideo, @pc_idDisco, @pc_idMicro)
			INSERT INTO FJGD_sql.Producto(prod_codProducto, prod_idCategoria, prod_Precio) 
			VALUES ( @pc_codigo,  @cate_idPc, @prod_precio * 1.20); 

	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
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
DECLARE @cate_idAc varchar(15)

SELECT @cate_idAc = cate_idCategoria FROM FJGD_sql.Categoria WHERE cate_idCategoria = 'ACCESORIO'

DECLARE db_cursor_accesorio CURSOR FOR 
------------------------------------------
SELECT 
	ACCESORIO_CODIGO,	AC_DESCRIPCION,	COMPRA_PRECIO
FROM gd_esquema.Maestra
WHERE COMPRA_PRECIO IS NOT NULL AND ACCESORIO_CODIGO IS NOT NULL
GROUP BY ACCESORIO_CODIGO, AC_DESCRIPCION, COMPRA_PRECIO
 ------------------------------------------
OPEN db_cursor_accesorio  
FETCH NEXT FROM db_cursor_accesorio INTO @acce_codigo, @acce_descripcion, @prod_precio

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
		INSERT INTO FJGD_sql.Accesorio(acce_idCodigo, acce_Descripcion) VALUES ( @acce_codigo, @acce_descripcion)
		INSERT INTO FJGD_sql.Producto(prod_codProducto, prod_idCategoria, prod_Precio) VALUES ( @acce_codigo,  @cate_idAc, @prod_precio);
	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
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

DECLARE db_cursor_compra CURSOR FOR 
-----------------------------------------
SELECT 
COMPRA_NUMERO,
SUCURSAL_MAIL,
COMPRA_FECHA,
SUM(COMPRA_PRECIO)
FROM gd_esquema.Maestra
WHERE COMPRA_NUMERO IS NOT NULL
GROUP BY COMPRA_NUMERO,SUCURSAL_MAIL,COMPRA_FECHA
------------------------------------------
OPEN db_cursor_compra  
FETCH NEXT FROM db_cursor_compra INTO @comp_NumeroCompra, @comp_SucursalMail, @comp_FechaCompra, @comp_GastoTotal

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
		SELECT @comp_idSucursal = sucu_idSucursal FROM FJGD_sql.Sucursal WHERE sucu_Mail= @comp_SucursalMail
		INSERT INTO FJGD_sql.Compra(comp_NumeroCompra, comp_idSucursal, comp_FechaCompra, comp_GastoTotal) 
				VALUES ( @comp_NumeroCompra, @comp_idSucursal, @comp_FechaCompra, @comp_GastoTotal)
	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
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
DECLARE @icomp_idCategoria varchar(15)
DECLARE @icomp_PrecioCompra decimal(14,2)
DECLARE @icomp_Cantidad decimal(10,0)

DECLARE db_cursor_item_compra CURSOR FOR 
------------------------------------------
SELECT
      COMPRA_NUMERO,
	  COMPRA_PRECIO,  
	  SUM(COMPRA_CANTIDAD),	  
	  PC_CODIGO,	  
	  ACCESORIO_CODIGO
FROM gd_esquema.Maestra
WHERE COMPRA_NUMERO IS NOT NULL
GROUP BY COMPRA_NUMERO,COMPRA_PRECIO,PC_CODIGO,ACCESORIO_CODIGO
------------------------------------------
OPEN db_cursor_item_compra  
FETCH NEXT FROM db_cursor_item_compra INTO @icomp_NumeroCompra, @icomp_PrecioCompra, @icomp_Cantidad, @icomp_codPC, @icomp_codAC

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
		IF @icomp_codPC IS NOT NULL
		BEGIN
			SELECT @icomp_idProducto = @icomp_codPC;
			SELECT @icomp_idCategoria = cate_idCategoria FROM FJGD_sql.Categoria WHERE cate_idCategoria = 'PC';
		END
		ELSE
		BEGIN 
			SELECT @icomp_idProducto = @icomp_codAC;
			SELECT @icomp_idCategoria = cate_idCategoria FROM FJGD_sql.Categoria WHERE cate_idCategoria = 'ACCESORIO';
		END

		INSERT INTO FJGD_sql.ItemCompra(icomp_NumeroCompra, icomp_idProducto, icomp_idCategoria, icomp_PrecioCompra, icomp_Cantidad) 
		VALUES (@icomp_NumeroCompra, @icomp_idProducto, @icomp_idCategoria, @icomp_PrecioCompra, @icomp_Cantidad)
	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
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
DECLARE @fact_idSucursal int
DECLARE @fact_sucuEmail varchar(50)
DECLARE @fact_fecha smalldatetime
--
DECLARE @ifact_idProducto varchar(15)
DECLARE @ifact_idCategoria varchar(15)
DECLARE @ifact_Cantidad decimal(10,2)
DECLARE @ifact_PrecioProducto decimal(14,2)
--
DECLARE @ifact_PC varchar(15)
DECLARE @ifact_PC_total int

DECLARE @fact_created varchar(15)
DECLARE @fact_created_total varchar(15)


DECLARE db_cursor_item_factura_pc CURSOR FOR 
------------------------------------------
SELECT
		FACTURA_NUMERO,
		SUCURSAL_MAIL,
		CLIENTE_DNI,
		CLIENTE_NOMBRE,
		CLIENTE_APELLIDO,
		FACTURA_FECHA,
		PC_CODIGO,
		COUNT(PC_CODIGO) AS total_pc_vendido
FROM gd_esquema.Maestra
WHERE FACTURA_NUMERO IS NOT NULL AND PC_CODIGO IS NOT NULL
GROUP BY FACTURA_NUMERO,SUCURSAL_MAIL,CLIENTE_DNI,CLIENTE_NOMBRE,CLIENTE_APELLIDO,FACTURA_FECHA,PC_CODIGO
ORDER BY FACTURA_NUMERO
------------------------------------------
OPEN db_cursor_item_factura_pc  
FETCH NEXT FROM db_cursor_item_factura_pc INTO @fact_NumeroFactura, @fact_sucuEmail, @fact_clieDNI, @fact_clieNombre,@fact_clieApellido,  @fact_fecha, @ifact_PC, @ifact_PC_total
	
WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY
		BEGIN
			SELECT @ifact_idProducto = @ifact_PC;
			SELECT @ifact_idCategoria = cate_idCategoria FROM FJGD_sql.Categoria WHERE cate_idCategoria = 'PC'
			SELECT @ifact_Cantidad = @ifact_PC_total
			SELECT @ifact_PrecioProducto = prod_Precio FROM FJGD_sql.Producto WHERE prod_codProducto = @ifact_PC AND prod_idCategoria = @ifact_idCategoria
			SELECT @fact_idSucursal = sucu_idSucursal FROM FJGD_sql.Sucursal WHERE sucu_Mail = @fact_sucuEmail
		END

		BEGIN
		IF NOT EXISTS (SELECT fact_Numero FROM FJGD_sql.Factura WHERE fact_Numero = @fact_NumeroFactura)
			BEGIN
			INSERT INTO FJGD_sql.Factura(fact_Numero,fact_idSucursal, fact_clieDNI, fact_clieApellido, fact_clieNombre, fact_fecha, fact_Total) 
			VALUES (@fact_NumeroFactura,@fact_idSucursal, @fact_clieDNI, @fact_clieApellido, @fact_clieNombre, @fact_fecha, (@ifact_Cantidad * @ifact_PrecioProducto))
			END
		ELSE
			BEGIN
			SELECT @fact_created_total = fact_Total FROM FJGD.Factura WHERE fact_Numero = @fact_NumeroFactura
			UPDATE FJGD.Factura SET fact_Total = (@fact_created_total + (@ifact_PrecioProducto * @ifact_Cantidad)) WHERE fact_Numero = @fact_NumeroFactura;
			END
		END
	
		INSERT INTO FJGD_sql.ItemFactura(ifact_FacturaNumero, ifact_idProducto, ifact_idCategoria, ifact_Cantidad, ifact_PrecioProducto) VALUES (@fact_NumeroFactura, @ifact_idProducto, @ifact_idCategoria, @ifact_Cantidad, @ifact_PrecioProducto)
	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
	END CATCH

	FETCH NEXT FROM db_cursor_item_factura_pc INTO @fact_NumeroFactura, @fact_sucuEmail, @fact_clieDNI, @fact_clieNombre,@fact_clieApellido,  @fact_fecha, @ifact_PC, @ifact_PC_total
END 

CLOSE db_cursor_item_factura_pc  
DEALLOCATE db_cursor_item_factura_pc
GO

-- Factura / Item Factura / AC
 
DECLARE @fact_NumeroFactura decimal(18,0)
DECLARE @fact_clieDNI varchar(15)
DECLARE @fact_clieNombre varchar(30)
DECLARE @fact_clieApellido varchar(30)
DECLARE @fact_sucursalMail varchar(50)
DECLARE @fact_idSucursal int
DECLARE @fact_fecha smalldatetime
--
DECLARE @ifact_idProducto varchar(15)
DECLARE @ifact_idCategoria varchar(15)
DECLARE @ifact_Cantidad decimal(10,2)
DECLARE @ifact_PrecioProducto decimal(14,2)
--
DECLARE @ifact_AC varchar(15)
DECLARE @ifact_AC_total int

DECLARE @fact_created varchar(15)
DECLARE @fact_created_total varchar(15)


DECLARE db_cursor_item_factura_ac CURSOR FOR 
------------------------------------------
SELECT
	FACTURA_NUMERO,
	SUCURSAL_MAIL,
	CLIENTE_DNI,
	CLIENTE_NOMBRE,
	CLIENTE_APELLIDO,
	FACTURA_FECHA,
	ACCESORIO_CODIGO,
	COUNT(ACCESORIO_CODIGO) AS total_ac_vendido
FROM gd_esquema.Maestra
WHERE FACTURA_NUMERO IS NOT NULL AND ACCESORIO_CODIGO IS NOT NULL
GROUP BY FACTURA_NUMERO,SUCURSAL_MAIL,CLIENTE_DNI,CLIENTE_NOMBRE,	CLIENTE_APELLIDO,FACTURA_FECHA,	ACCESORIO_CODIGO
ORDER BY ACCESORIO_CODIGO DESC , FACTURA_NUMERO
------------------------------------------
OPEN db_cursor_item_factura_ac  
FETCH NEXT FROM db_cursor_item_factura_ac INTO @fact_NumeroFactura, @fact_sucursalMail, @fact_clieDNI, @fact_clieNombre, @fact_clieApellido, @fact_fecha, @ifact_AC, @ifact_AC_total
	
WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY	
		BEGIN 
			SELECT @ifact_idProducto = @ifact_AC;
			SELECT @ifact_idCategoria = cate_idCategoria FROM FJGD_sql.Categoria WHERE cate_idCategoria = 'ACCESORIO'
			SELECT @ifact_Cantidad = @ifact_AC_total
			SELECT @ifact_PrecioProducto = prod_Precio FROM FJGD_sql.Producto WHERE prod_codProducto = @ifact_AC AND prod_idCategoria = @ifact_idCategoria
			SELECT @fact_idSucursal = sucu_idSucursal FROM FJGD_sql.Sucursal WHERE sucu_Mail = @fact_sucursalMail
		END

		BEGIN
		IF NOT EXISTS (SELECT fact_Numero FROM FJGD_sql.Factura WHERE fact_Numero = @fact_NumeroFactura)
			BEGIN
			SELECT @fact_idSucursal = sucu_idSucursal FROM FJGD_sql.Sucursal WHERE sucu_Mail = @fact_sucursalMail
			INSERT INTO FJGD_sql.Factura(fact_Numero,fact_idSucursal ,fact_clieDNI, fact_clieApellido, fact_clieNombre, fact_fecha, fact_Total) 
			VALUES (@fact_NumeroFactura,@fact_idSucursal ,@fact_clieDNI, @fact_clieApellido, @fact_clieNombre, @fact_fecha, (@ifact_Cantidad * @ifact_PrecioProducto))
			END
		ELSE
			BEGIN
			SELECT @fact_created_total = fact_Total FROM FJGD_sql.Factura WHERE fact_Numero = @fact_NumeroFactura

			UPDATE FJGD_sql.Factura SET fact_Total = (@fact_created_total + (@ifact_PrecioProducto * @ifact_Cantidad)) WHERE fact_Numero = @fact_NumeroFactura;
			END
		END
	
		INSERT INTO FJGD_sql.ItemFactura(ifact_FacturaNumero, ifact_idProducto, ifact_idCategoria, ifact_Cantidad, ifact_PrecioProducto) 
		VALUES (@fact_NumeroFactura, @ifact_idProducto, @ifact_idCategoria, @ifact_Cantidad, @ifact_PrecioProducto)
	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
	END CATCH
	
	FETCH NEXT FROM db_cursor_item_factura_ac INTO @fact_NumeroFactura, @fact_sucursalMail, @fact_clieDNI, @fact_clieNombre, @fact_clieApellido, @fact_fecha, @ifact_AC, @ifact_AC_total
END 

CLOSE db_cursor_item_factura_ac  
DEALLOCATE db_cursor_item_factura_ac
GO


/* stock */

DECLARE @stoc_idSucursal int

DECLARE @stoc_SucursalDir varchar(50)
DECLARE @stoc_idCategoria varchar(15)
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
------------------------------------------
SELECT   
	C.[SUCURSAL_DIR],	prod_idCategoria,
	CASE 
		WHEN C.ACCESORIO_CODIGO = '0' THEN C.PC_CODIGO
		ELSE C.ACCESORIO_CODIGO
	END AS ID_PRODUCTO,
	C.CANTIDAD_COMPRADA - V.CANTIDAD_VENDIDA AS STOCK_TOTAL
FROM     @tablaCompras C
LEFT JOIN @tablaVentas V
	ON C.SUCURSAL_DIR + C.ACCESORIO_CODIGO + C.PC_CODIGO = V.SUCURSAL_DIR + V.ACCESORIO_CODIGO + V.PC_CODIGO
JOIN FJGD_sql.Producto
ON C.ACCESORIO_CODIGO = prod_codProducto OR C.PC_CODIGO = prod_codProducto
------------------------------------------
OPEN db_cursor_stock  
FETCH NEXT FROM db_cursor_stock INTO @stoc_SucursalDir, @stoc_idCategoria, @stoc_idProducto, @stoc_Cantidad

WHILE @@FETCH_STATUS = 0  
BEGIN  
	BEGIN TRY

				SELECT @stoc_idSucursal = sucu_idSucursal 
				FROM FJGD_sql.Sucursal 
				WHERE sucu_Direccion = @stoc_SucursalDir 

				INSERT INTO FJGD_sql.Stock(stoc_idSucursal, stoc_idCategoria,stoc_idProducto,stoc_Cantidad) 
				VALUES ( @stoc_idSucursal, @stoc_idCategoria, @stoc_idProducto, @stoc_Cantidad)

	END TRY
	BEGIN CATCH
		INSERT INTO FJGD_sql.ERRORES
		VALUES(		SUSER_SNAME(),
					ERROR_NUMBER(),
					ERROR_STATE(),
					ERROR_SEVERITY(),
					ERROR_LINE(),
					ERROR_PROCEDURE(),
					ERROR_MESSAGE(),
					GETDATE());
	END CATCH
	
	FETCH NEXT FROM db_cursor_stock INTO @stoc_SucursalDir, @stoc_idCategoria, @stoc_idProducto, @stoc_Cantidad

END 

CLOSE db_cursor_stock
DEALLOCATE db_cursor_stock
GO