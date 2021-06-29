USE GD1C2021
go
/* Creacion de tablas DI */
CREATE TABLE FJGD_sql.BI_DIM_Tiempo(
	bi_tiem_id int identity (1,1) NOT NULL,
	bi_tiem_mes decimal(2,0) NOT NULL,
	bi_tiem_anio decimal(4,0) NOT NULL
)

CREATE TABLE FJGD_sql.BI_DIM_Sucursal(
	bi_sucu_id int IDENTITY(1,1)  NOT NULL,
	bi_sucu_mail varchar(50) NULL,
	bi_sucu_direccion varchar(50) NOT NULL,
	bi_sucu_telefono decimal(18, 0) NULL,
	bi_sucu_ciudad varchar(50) NULL
)

CREATE TABLE FJGD_sql.BI_DIM_PC(
	bi_pc_id int IDENTITY(1,1) NOT NULL,
	bi_pc_codigo varchar(15) NOT NULL
/*	bi_pc_ram int NOT NULL,
	bi_pc_micro int NOT NULL,
	bi_pc_video int NOT NULL,
	bi_pc_disco int NOT NULL
*/
)

CREATE TABLE FJGD_sql.BI_DIM_AC(
	bi_ac_id int IDENTITY(1,1) NOT NULL,
	bi_ac_codigo varchar(15) NOT NULL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
)


CREATE TABLE FJGD_sql.BI_DIM_Cliente(
    bi_clie_DNI varchar(15) NOT NULL,
    bi_clie_Apellido varchar(30) NOT NULL,
    bi_clie_Nombre varchar(30) NOT NULL,
    bi_clie_Direccion varchar(50) NULL,
    bi_clie_fechaNacimiento date NULL,
    bi_clie_mail varchar(50) NULL,
    bi_clie_telefono varchar(50) NULL,
    bi_clie_edad int NOT NULL,
    bi_clie_sexo varchar(10) NULL
)

CREATE TABLE FJGD_sql.BI_DIM_Fabricante(
    bi_fabri_codigo varchar(30) NOT NULL
 )



/* Creacion de tablas FACT PC_COMPRA */
CREATE TABLE FJGD_sql.BI_FACT_PC_COMPRA(
	fact_comp_pc_tiempo_fk int NOT NULL,
	fact_comp_pc_sucu_fk int NOT NULL,
	fact_comp_pc_pc_fk int NOT NULL,
	fact_comp_pc_fabricante_fk varchar(30) NOT NULL,
	fact_comp_pc_precio decimal(14,2) NOT NULL,
	fact_comp_pc_cantidad_comprada decimal(10,2) NOT NULL
)

/* Creacion de tablas FACT PC_VENTA */
CREATE TABLE FJGD_sql.BI_FACT_PC_VENTA(
	fact_vent_pc_tiempo_fk int NOT NULL,
	fact_vent_pc_sucu_fk int NOT NULL,
	fact_vent_pc_pc_fk int NOT NULL,
	fact_vent_pc_clie_dni_fk varchar(15) NOT NULL,
	fact_vent_pc_clie_apellido_fk varchar(15) NOT NULL,
    fact_vent_pc_clie_nombre_fk varchar(15) NOT NULL,
    fact_vent_pc_precio_venta decimal(14,2) NOT NULL,
	fact_vent_pc_cantidad_vendida decimal(10,2) NOT NULL
)

/* Creacion de tablas FACT AC_COMPRA */
CREATE TABLE FJGD_sql.BI_FACT_AC_COMPRA(
	fact_comp_ac_tiempo_fk int NOT NULL,
	fact_comp_ac_sucu_fk int NOT NULL,
	fact_comp_ac_ac_fk int NOT NULL,
	fact_comp_ac_fabricante_fk varchar(30) NOT NULL,
	fact_comp_ac_precio decimal(14,2) NOT NULL,
	fact_comp_ac_cantidad_comprada decimal(10,2) NOT NULL
)

/* Creacion de tablas FACT AC_VENTA */
CREATE TABLE FJGD_sql.BI_FACT_AC_VENTA(
	fact_vent_ac_tiempo_fk int NOT NULL,
	fact_vent_ac_sucu_fk int NOT NULL,
	fact_vent_ac_ac_fk int NOT NULL,
	fact_vent_ac_clie_dni_fk varchar(15) NOT NULL,
	fact_vent_ac_clie_apellido_fk varchar(15) NOT NULL,
	fact_vent_ac_clie_nombre_fk varchar(15) NOT NULL,	
	fact_vent_ac_precio_venta decimal(14,2) NOT NULL,
	fact_vent_ac_cantidad_vendida decimal(10,2) NOT NULL
)



/* Primaries key */

ALTER TABLE FJGD_sql.BI_DIM_Tiempo ADD CONSTRAINT PK_DIM_Tiempo PRIMARY KEY(bi_tiem_id)
ALTER TABLE FJGD_sql.BI_DIM_Sucursal ADD CONSTRAINT PK_DIM_Sucursal PRIMARY KEY(bi_sucu_id)
ALTER TABLE FJGD_sql.BI_DIM_PC ADD CONSTRAINT PK_DIM_PC PRIMARY KEY(bi_pc_id)
ALTER TABLE FJGD_sql.BI_DIM_AC ADD CONSTRAINT PK_DIM_AC PRIMARY KEY(bi_ac_id)
ALTER TABLE FJGD_sql.BI_DIM_Cliente ADD CONSTRAINT PK_DIM_Cliente PRIMARY KEY(bi_clie_DNI,bi_clie_Nombre,bi_clie_Apellido)
ALTER TABLE FJGD_sql.BI_DIM_Fabricante ADD CONSTRAINT PK_DIM_Fabricante PRIMARY KEY(bi_fabri_codigo)
GO

/* Foreings key */
ALTER TABLE FJGD_sql.BI_FACT_PC_COMPRA
ADD
	CONSTRAINT FK_BI_FACT_PC_COMPRA_TIEMPO FOREIGN KEY (fact_comp_pc_tiempo_fk ) REFERENCES FJGD_sql.BI_DIM_Tiempo(bi_tiem_id),
	CONSTRAINT FK_BI_FACT_PC_COMPRA_SUCURSAL FOREIGN KEY (fact_comp_pc_sucu_fk ) REFERENCES FJGD_sql.BI_DIM_Sucursal(bi_sucu_id),
	CONSTRAINT FK_BI_FACT_PC_COMPRA_PC FOREIGN KEY (fact_comp_pc_pc_fk) REFERENCES FJGD_sql.BI_DIM_PC(bi_pc_id),
	CONSTRAINT FK_BI_FACT_PC_COMPRA_FABRI FOREIGN KEY (fact_comp_pc_fabricante_fk) REFERENCES FJGD_sql.BI_DIM_Fabricante(bi_fabri_codigo)

GO

ALTER TABLE FJGD_sql.BI_FACT_PC_VENTA
ADD
	CONSTRAINT FK_BI_FACT_PC_VENTA_TIEMPO FOREIGN KEY (fact_vent_pc_tiempo_fk ) REFERENCES FJGD_sql.BI_DIM_Tiempo(bi_tiem_id),
	CONSTRAINT FK_BI_FACT_PC_VENTA_SUCURSAL FOREIGN KEY (fact_vent_pc_sucu_fk ) REFERENCES FJGD_sql.BI_DIM_Sucursal(bi_sucu_id),
	CONSTRAINT FK_BI_FACT_PC_VENTA_PC FOREIGN KEY (fact_vent_pc_pc_fk) REFERENCES FJGD_sql.BI_DIM_PC(bi_pc_id),
	CONSTRAINT FK_BI_FACT_PC_VENTA_CLIENTE FOREIGN KEY (fact_vent_pc_clie_dni_fk,fact_vent_pc_clie_apellido_fk,fact_vent_pc_clie_nombre_fk) REFERENCES FJGD_sql.BI_DIM_Cliente(bi_clie_DNI,bi_clie_Apellido,bi_clie_Nombre)
GO

ALTER TABLE FJGD_sql.BI_FACT_AC_COMPRA
ADD
	CONSTRAINT FK_BI_FACT_AC_COMPRA_TIEMPO FOREIGN KEY (fact_comp_ac_tiempo_fk ) REFERENCES FJGD_sql.BI_DIM_Tiempo(bi_tiem_id),
	CONSTRAINT FK_BI_FACT_AC_COMPRA_SUCURSAL FOREIGN KEY (fact_comp_ac_sucu_fk ) REFERENCES FJGD_sql.BI_DIM_Sucursal(bi_sucu_id),
	CONSTRAINT FK_BI_FACT_AC_COMPRA_AC FOREIGN KEY (fact_comp_ac_ac_fk) REFERENCES FJGD_sql.BI_DIM_PC(bi_pc_id),
	CONSTRAINT FK_BI_FACT_AC_COMPRA_FABRI FOREIGN KEY (fact_comp_ac_fabricante_fk) REFERENCES FJGD_sql.BI_DIM_Fabricante(bi_fabri_codigo)

GO

ALTER TABLE FJGD_sql.BI_FACT_AC_VENTA
ADD
	CONSTRAINT FK_BI_FACT_AC_VENTA_TIEMPO FOREIGN KEY (fact_vent_ac_tiempo_fk ) REFERENCES FJGD_sql.BI_DIM_Tiempo(bi_tiem_id),
	CONSTRAINT FK_BI_FACT_AC_VENTA_SUCURSAL FOREIGN KEY (fact_vent_ac_sucu_fk ) REFERENCES FJGD_sql.BI_DIM_Sucursal(bi_sucu_id),
	CONSTRAINT FK_BI_FACT_AC_VENTA_AC FOREIGN KEY (fact_vent_ac_ac_fk) REFERENCES FJGD_sql.BI_DIM_PC(bi_pc_id),
	CONSTRAINT FK_BI_FACT_AC_VENTA_CLIENTE FOREIGN KEY (fact_vent_ac_clie_dni_fk,fact_vent_ac_clie_apellido_fk,fact_vent_ac_clie_nombre_fk) REFERENCES FJGD_sql.BI_DIM_Cliente(bi_clie_DNI,bi_clie_Apellido,bi_clie_Nombre)
GO



/* Migracion */

-- Tiempo
DECLARE @tiem_anio varchar(50)
DECLARE @tiem_mes varchar(50)
DECLARE db_bi_cursor_tiempo CURSOR FOR 

SELECT
YEAR(fact_fecha),
MONTH(fact_fecha)
FROM FJGD_sql.Factura
GROUP BY YEAR(fact_fecha), MONTH(fact_fecha)
UNION
SELECT
YEAR(comp_FechaCompra),
MONTH(comp_FechaCompra)
FROM FJGD_sql.Compra
GROUP BY YEAR(comp_FechaCompra), MONTH(comp_FechaCompra)
ORDER BY 1, 2;

OPEN db_bi_cursor_tiempo  
FETCH NEXT FROM db_bi_cursor_tiempo INTO @tiem_anio, @tiem_mes

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN
		BEGIN TRY
					INSERT INTO FJGD_sql.BI_DIM_Tiempo(bi_tiem_anio, bi_tiem_mes)
					VALUES (@tiem_anio, @tiem_mes)
					
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
	FETCH NEXT FROM db_bi_cursor_tiempo INTO @tiem_anio, @tiem_mes
	END 
END 

CLOSE db_bi_cursor_tiempo  
DEALLOCATE db_bi_cursor_tiempo
GO

-- Sucursal
DECLARE @sucu_Ciudad varchar(50)
DECLARE @sucu_Direccion varchar(50)
DECLARE @sucu_Mail varchar(50) 
DECLARE @sucu_Telefono decimal(18, 0)
DECLARE db_bi_cursor_sucursal CURSOR FOR 
SELECT  
	sucu_Ciudad,
	sucu_Direccion,
	sucu_Mail,
	sucu_Telefono
FROM FJGD_sql.Sucursal
GROUP BY sucu_Ciudad, sucu_Direccion, sucu_Mail, sucu_Telefono;

OPEN db_bi_cursor_sucursal  
FETCH NEXT FROM db_bi_cursor_sucursal INTO @sucu_Ciudad, @sucu_Direccion, @sucu_Mail, @sucu_Telefono

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN
				BEGIN TRY
							INSERT INTO FJGD_sql.BI_DIM_Sucursal(bi_sucu_mail, bi_sucu_direccion, bi_sucu_telefono, bi_sucu_ciudad)
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
			FETCH NEXT FROM db_bi_cursor_sucursal INTO @sucu_Ciudad, @sucu_Direccion, @sucu_Mail, @sucu_Telefono

	END 
END 

CLOSE db_bi_cursor_sucursal  
DEALLOCATE db_bi_cursor_sucursal
GO

-- PC
DECLARE @pc_Codigo varchar(50)

DECLARE db_bi_cursor_PC CURSOR FOR 
SELECT  
	pc_idCodigo
FROM FJGD_sql.PC
GROUP BY pc_idCodigo;

OPEN db_bi_cursor_PC
FETCH NEXT FROM db_bi_cursor_PC INTO @pc_Codigo

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN
		BEGIN TRY
			INSERT INTO FJGD_sql.BI_DIM_PC(bi_pc_codigo)
			VALUES (@pc_Codigo)
					
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
		FETCH NEXT FROM db_bi_cursor_PC INTO @pc_Codigo
	END 
END 

CLOSE db_bi_cursor_PC  
DEALLOCATE db_bi_cursor_PC
GO	

-- AC
DECLARE @ac_Codigo varchar(50)

DECLARE db_bi_cursor_AC CURSOR FOR 
SELECT  
	acce_idCodigo
FROM FJGD_sql.Accesorio
GROUP BY acce_idCodigo;

OPEN db_bi_cursor_AC
FETCH NEXT FROM db_bi_cursor_AC INTO @ac_Codigo

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN
		BEGIN TRY
			INSERT INTO FJGD_sql.BI_DIM_AC(bi_ac_codigo)
			VALUES (@ac_Codigo)
					
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
		FETCH NEXT FROM db_bi_cursor_AC INTO @ac_Codigo
	END 
END 

CLOSE db_bi_cursor_AC  
DEALLOCATE db_bi_cursor_AC
GO	

--Cliente
/*Cliente*/

DECLARE @clie_DNI varchar(15)
DECLARE @clie_Apellido varchar(30)
DECLARE @clie_Nombre varchar(30)
DECLARE @clie_Direccion varchar(15)
DECLARE @clie_FechaNacimiento smalldatetime
DECLARE @clie_Mail varchar(15)
DECLARE @clie_Telefono varchar(50)
DECLARE @clie_Edad int
DECLARE @clie_Sexo varchar(10)

DECLARE db_bi_cursor_cliente CURSOR FOR
SELECT  
    clie_DNI,
    clie_Apellido,
    clie_Nombre,
    clie_Direccion,
    clie_fechaNacimiento,
    clie_mail,
    clie_telefono,
    YEAR(GETDATE()) - YEAR(clie_fechaNacimiento)
FROM FJGD_sql.Cliente
WHERE clie_DNI IS NOT NULL
ORDER BY clie_DNI, clie_apellido, clie_nombre


OPEN db_bi_cursor_cliente
FETCH NEXT FROM db_bi_cursor_cliente INTO @clie_DNI,@clie_Apellido, @clie_Nombre, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono, @clie_Edad

WHILE @@FETCH_STATUS = 0  
BEGIN  
    INSERT INTO FJGD_sql.BI_DIM_Cliente( bi_clie_DNI,bi_clie_Apellido,bi_clie_Nombre,
    bi_clie_Direccion, bi_clie_fechaNacimiento, bi_clie_mail, bi_clie_telefono, bi_clie_edad, bi_clie_sexo)
    VALUES (@clie_DNI,@clie_Apellido, @clie_Nombre, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono, @clie_Edad, NULL)

   	 FETCH NEXT FROM db_bi_cursor_cliente INTO @clie_DNI,@clie_Apellido, @clie_Nombre, @clie_Direccion, @clie_FechaNacimiento, @clie_Mail, @clie_Telefono, @clie_Edad
END

CLOSE db_bi_cursor_cliente  
DEALLOCATE db_bi_cursor_cliente
GO



-- FACT_PC_COMPRA
DECLARE @fact_pc_anio decimal(4,0)
DECLARE @fact_pc_mes decimal(2,0)
DECLARE @fact_pc_producto varchar(15) 
DECLARE @fact_pc_sucu_mail varchar(50) 
DECLARE @fact_pc_precio decimal(18, 0)
DECLARE @fact_pc_cantidad decimal(18, 0)

DECLARE db_bi_cursor_fact_pc_compra CURSOR FOR 
SELECT  
	YEAR(comp_FechaCompra) as anio,
	MONTH(comp_FechaCompra) as mes,
	icomp_idProducto,
	sucu_Mail,
	comp_GastoTotal,
	icomp_Cantidad
FROM FJGD_sql.Compra
JOIN FJGD_sql.ItemCompra ON icomp_NumeroCompra = comp_NumeroCompra
JOIN FJGD_sql.Sucursal ON sucu_idSucursal = comp_idSucursal
WHERE icomp_idCategoria = 'PC'
;

OPEN db_bi_cursor_fact_pc_compra  
FETCH NEXT FROM db_bi_cursor_fact_pc_compra INTO @fact_pc_anio, @fact_pc_mes, @fact_pc_producto, @fact_pc_sucu_mail, @fact_pc_precio, @fact_pc_cantidad

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN
				BEGIN TRY
					INSERT INTO FJGD_sql.BI_FACT_PC_COMPRA(fact_comp_pc_tiempo_fk, fact_comp_pc_sucu_fk, fact_comp_pc_pc_fk, fact_comp_pc_precio, fact_comp_pc_cantidad_comprada)
							VALUES (
							(SELECT TOP 1 bi_tiem_id FROM FJGD_sql.BI_DIM_Tiempo WHERE bi_tiem_anio = @fact_pc_anio AND bi_tiem_mes = @fact_pc_mes),
							(SELECT TOP 1 bi_sucu_id FROM FJGD_sql.BI_DIM_Sucursal WHERE  bi_sucu_mail = @fact_pc_sucu_mail),
							(SELECT TOP 1 bi_pc_id FROM FJGD_sql.BI_DIM_PC WHERE  bi_pc_codigo = @fact_pc_producto),
							@fact_pc_precio,
							@fact_pc_cantidad
							)
					
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
			FETCH NEXT FROM db_bi_cursor_fact_pc_compra INTO @fact_pc_anio, @fact_pc_mes, @fact_pc_producto, @fact_pc_sucu_mail, @fact_pc_precio, @fact_pc_cantidad

	END 
END 

CLOSE db_bi_cursor_fact_pc_compra  
DEALLOCATE db_bi_cursor_fact_pc_compra
GO


-- FACT_PC_VENTA
DECLARE @fact_pc_vent_anio decimal(4,0)
DECLARE @fact_pc_vent_mes decimal(2,0)
DECLARE @fact_pc_vent_producto varchar(15) 
DECLARE @fact_pc_sucu_mail varchar(50)
DECLARE @fact_vent_pc_clie_dni varchar(15)
DECLARE @fact_vent_pc_clie_Apellido varchar(30)
DECLARE @fact_vent_pc_clie_Nombre varchar(30)
DECLARE @fact_pc_vent_precio decimal(18, 0)
DECLARE @fact_pc_vent_cantidad decimal(18, 0)

DECLARE db_bi_cursor_fact_pc_venta CURSOR FOR 
SELECT  
	YEAR(fact_fecha) as anio,
	MONTH(fact_fecha) as mes,
	ifact_idProducto,
	sucu_Mail,
	fact_clieDNI,
	fact_clieApellido,
	fact_clieNombre,
	fact_Total,
	ifact_Cantidad	
FROM FJGD_sql.Factura
JOIN FJGD_sql.ItemFactura ON ifact_FacturaNumero = fact_Numero
JOIN FJGD_sql.Sucursal ON sucu_idSucursal = fact_idSucursal
WHERE ifact_idCategoria = 'PC'
;

OPEN db_bi_cursor_fact_pc_venta  
FETCH NEXT FROM db_bi_cursor_fact_pc_venta INTO @fact_pc_vent_anio, @fact_pc_vent_mes, @fact_pc_vent_producto,@fact_pc_sucu_mail,@fact_vent_pc_clie_dni,@fact_vent_pc_clie_Apellido,@fact_vent_pc_clie_Nombre, @fact_pc_vent_precio, @fact_pc_vent_cantidad

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN
				BEGIN TRY
					INSERT INTO FJGD_sql.BI_FACT_PC_VENTA(fact_vent_pc_tiempo_fk,fact_vent_pc_sucu_fk,fact_vent_pc_clie_dni_fk,fact_vent_pc_clie_Apellido_fk,fact_vent_pc_clie_Nombre_fk, fact_vent_pc_pc_fk, fact_vent_pc_precio_venta, fact_vent_pc_cantidad_vendida)
							VALUES (
							(SELECT TOP 1 bi_tiem_id FROM FJGD_sql.BI_DIM_Tiempo WHERE bi_tiem_anio = @fact_pc_vent_anio AND bi_tiem_mes = @fact_pc_vent_mes),
							(SELECT TOP 1 bi_sucu_id FROM FJGD_sql.BI_DIM_Sucursal WHERE  bi_sucu_mail = @fact_pc_sucu_mail),
							@fact_vent_pc_clie_dni,
							@fact_vent_pc_clie_Apellido,
							@fact_vent_pc_clie_Nombre,
							(SELECT TOP 1 bi_pc_id FROM FJGD_sql.BI_DIM_PC WHERE  bi_pc_codigo = @fact_pc_vent_producto),
							@fact_pc_vent_precio,
							@fact_pc_vent_cantidad
							)
					
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
		FETCH NEXT FROM db_bi_cursor_fact_pc_venta INTO @fact_pc_vent_anio, @fact_pc_vent_mes, @fact_pc_vent_producto,@fact_pc_sucu_mail,@fact_vent_pc_clie_dni,@fact_vent_pc_clie_Apellido,@fact_vent_pc_clie_Nombre, @fact_pc_vent_precio, @fact_pc_vent_cantidad


	END 
END 

CLOSE db_bi_cursor_fact_pc_venta  
DEALLOCATE db_bi_cursor_fact_pc_venta
GO

-- FACT_AC_COMPRA
DECLARE @fact_ac_anio decimal(4,0)
DECLARE @fact_ac_mes decimal(2,0)
DECLARE @fact_ac_producto varchar(15) 
DECLARE @fact_ac_sucu_mail varchar(50) 
DECLARE @fact_ac_precio decimal(18, 0)
DECLARE @fact_ac_cantidad decimal(18, 0)

DECLARE db_bi_cursor_fact_ac_compra CURSOR FOR 
SELECT  
	YEAR(comp_FechaCompra) as anio,
	MONTH(comp_FechaCompra) as mes,
	icomp_idProducto,
	sucu_Mail,
	comp_GastoTotal,
	icomp_Cantidad
FROM FJGD_sql.Compra
JOIN FJGD_sql.ItemCompra ON icomp_NumeroCompra = comp_NumeroCompra
JOIN FJGD_sql.Sucursal ON sucu_idSucursal = comp_idSucursal
WHERE icomp_idCategoria = 'ACCESORIO'
;

OPEN db_bi_cursor_fact_ac_compra  
FETCH NEXT FROM db_bi_cursor_fact_ac_compra INTO @fact_ac_anio, @fact_ac_mes, @fact_ac_producto, @fact_ac_sucu_mail, @fact_ac_precio, @fact_ac_cantidad

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN
				BEGIN TRY
					INSERT INTO FJGD_sql.BI_FACT_AC_COMPRA(fact_comp_ac_tiempo_fk, fact_comp_ac_sucu_fk, fact_comp_ac_ac_fk, fact_comp_ac_precio, fact_comp_ac_cantidad_comprada)
							VALUES (
							(SELECT TOP 1 bi_tiem_id FROM FJGD_sql.BI_DIM_Tiempo WHERE bi_tiem_anio = @fact_ac_anio AND bi_tiem_mes = @fact_ac_mes),
							(SELECT TOP 1 bi_sucu_id FROM FJGD_sql.BI_DIM_Sucursal WHERE  bi_sucu_mail = @fact_ac_sucu_mail),
							(SELECT TOP 1 bi_ac_id FROM FJGD_sql.BI_DIM_AC WHERE  bi_ac_codigo = @fact_ac_producto),
							@fact_ac_precio,
							@fact_ac_cantidad
							)
					
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
			FETCH NEXT FROM db_bi_cursor_fact_ac_compra INTO @fact_ac_anio, @fact_ac_mes, @fact_ac_producto, @fact_ac_sucu_mail, @fact_ac_precio, @fact_ac_cantidad

	END 
END 

CLOSE db_bi_cursor_fact_ac_compra  
DEALLOCATE db_bi_cursor_fact_ac_compra
GO


-- FACT_AC_VENTA
DECLARE @fact_ac_vent_anio decimal(4,0)
DECLARE @fact_ac_vent_mes decimal(2,0)
DECLARE @fact_ac_vent_producto varchar(15) 
DECLARE @fact_ac_sucu_mail varchar(50)
DECLARE @fact_vent_ac_clie_dni varchar(15)
DECLARE @fact_vent_ac_clie_Nombre varchar(30)
DECLARE @fact_vent_ac_clie_Apellido varchar(30)
DECLARE @fact_ac_vent_precio decimal(18, 0)
DECLARE @fact_ac_vent_cantidad decimal(18, 0)

DECLARE db_bi_cursor_fact_ac_venta CURSOR FOR 
SELECT  
	YEAR(fact_fecha) as anio,
	MONTH(fact_fecha) as mes,
	ifact_idProducto,
	sucu_Mail,
	fact_clieDNI,
	fact_clieNombre,
	fact_clieApellido,
	fact_Total,
	ifact_Cantidad
FROM FJGD_sql.Factura
JOIN FJGD_sql.ItemFactura ON ifact_FacturaNumero = fact_Numero
JOIN FJGD_sql.Sucursal ON sucu_idSucursal = fact_idSucursal
WHERE ifact_idCategoria = 'ACCESORIO'
;

OPEN db_bi_cursor_fact_ac_venta  
FETCH NEXT FROM db_bi_cursor_fact_ac_venta INTO @fact_ac_vent_anio, @fact_ac_vent_mes, @fact_ac_vent_producto, @fact_ac_sucu_mail,@fact_vent_ac_clie_dni,@fact_vent_ac_clie_Nombre,@fact_vent_ac_clie_Apellido, @fact_ac_vent_precio, @fact_ac_vent_cantidad

WHILE @@FETCH_STATUS = 0  
BEGIN
	BEGIN
				BEGIN TRY
					INSERT INTO FJGD_sql.BI_FACT_AC_VENTA(fact_vent_ac_tiempo_fk,fact_vent_ac_sucu_fk, fact_vent_ac_ac_fk, fact_vent_ac_clie_dni_fk,fact_vent_ac_clie_nombre_fk,fact_vent_ac_clie_apellido_fk,fact_vent_ac_precio_venta, fact_vent_ac_cantidad_vendida)
							VALUES (
							(SELECT TOP 1 bi_tiem_id FROM FJGD_sql.BI_DIM_Tiempo WHERE bi_tiem_anio = @fact_ac_vent_anio AND bi_tiem_mes = @fact_ac_vent_mes),
							(SELECT TOP 1 bi_sucu_id FROM FJGD_sql.BI_DIM_Sucursal WHERE  bi_sucu_mail = @fact_ac_sucu_mail),
							(SELECT TOP 1 bi_ac_id FROM FJGD_sql.BI_DIM_AC WHERE  bi_ac_codigo = @fact_ac_vent_producto),
							@fact_vent_ac_clie_dni,
							@fact_vent_ac_clie_Nombre,
							@fact_vent_ac_clie_Apellido,
							@fact_ac_vent_precio,
							@fact_ac_vent_cantidad
							)
					
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
			FETCH NEXT FROM db_bi_cursor_fact_ac_venta INTO @fact_ac_vent_anio, @fact_ac_vent_mes, @fact_ac_vent_producto, @fact_ac_sucu_mail,@fact_vent_ac_clie_dni,@fact_vent_ac_clie_Nombre,@fact_vent_ac_clie_Apellido, @fact_ac_vent_precio, @fact_ac_vent_cantidad

	END 
END 

CLOSE db_bi_cursor_fact_ac_venta  
DEALLOCATE db_bi_cursor_fact_ac_venta
GO


/*VISTA PC 1 */

--FALTA

/*VISTA PC 2 */
/*
CREATE VIEW [pc_precio_promedio] AS

SELECT 
	PC1.bi_pc_codigo [CODIGO_PC],
	(
	SELECT 
		AVG(PCC.fact_comp_pc_precio * PCC.fact_comp_pc_cantidad_comprada)
		FROM FJGD_sql.BI_FACT_PC_COMPRA PCC
		JOIN FJGD_sql.BI_DIM_PC PC2 ON PC2.bi_pc_id = PCC.fact_comp_pc_pc_fk
		WHERE PC2.bi_pc_codigo = PC1.bi_pc_codigo
	) AS [Precio promedio en compras],
	AVG(PCV.fact_vent_pc_precio_venta * PCV.fact_vent_pc_cantidad_vendida) AS [Precio promedio en ventas]
	FROM FJGD_sql.BI_FACT_PC_VENTA PCV
	JOIN FJGD_sql.BI_DIM_PC PC1 ON PC1.bi_pc_id = PCV.fact_vent_pc_pc_fk
	GROUP BY PC1.bi_pc_codigo
GO*/

/*VISTA PC 3 */
/*
CREATE VIEW [pc_cantidad_vendido_comprado_x_sucursal_x_mes] AS
SELECT 
	(
	SELECT SUM(PCV.fact_vent_pc_cantidad_vendida) FROM FJGD_sql.BI_FACT_PC_VENTA PCV
	JOIN FJGD_sql.BI_DIM_Tiempo T2 ON T2.bi_tiem_id = PCV.fact_vent_pc_tiempo_fk
	JOIN FJGD_sql.BI_DIM_Sucursal S2 ON S2.bi_sucu_id = PCV.fact_vent_pc_sucu_fk
	WHERE T2.bi_tiem_mes = T.bi_tiem_mes AND S2.bi_sucu_mail = S.bi_sucu_mail
	) [cantidad_vendida],
	SUM(PCC.fact_comp_pc_cantidad_comprada) [cantidad comprada],
	t.bi_tiem_mes [mes],
	s.bi_sucu_mail [sucursal]
	FROM FJGD_sql.BI_FACT_PC_COMPRA PCC
	JOIN FJGD_sql.BI_DIM_Tiempo T ON T.bi_tiem_id = PCC.fact_comp_pc_tiempo_fk
	JOIN FJGD_sql.BI_DIM_Sucursal S ON S.bi_sucu_id = PCC.fact_comp_pc_sucu_fk 
	GROUP BY T.bi_tiem_mes, bi_sucu_mail
	
GO
*/
/*VISTA PC 4 */
/*
CREATE VIEW [pc_ganancias_x_sucursal_x_mes] AS

SELECT 
	(
	SELECT SUM(PCV.fact_vent_pc_precio_venta) FROM FJGD_sql.BI_FACT_PC_VENTA PCV
	JOIN FJGD_sql.BI_DIM_Tiempo T2 ON T2.bi_tiem_id = PCV.fact_vent_pc_tiempo_fk
	JOIN FJGD_sql.BI_DIM_Sucursal S2 ON S2.bi_sucu_id = PCV.fact_vent_pc_sucu_fk
	WHERE T2.bi_tiem_mes = T.bi_tiem_mes AND S2.bi_sucu_mail = S.bi_sucu_mail
	) - SUM(PCC.fact_comp_pc_precio) [Ganancia],
	t.bi_tiem_mes [mes],
	s.bi_sucu_mail [sucursal]
	FROM FJGD_sql.BI_FACT_PC_COMPRA PCC
	JOIN FJGD_sql.BI_DIM_Tiempo T ON T.bi_tiem_id = PCC.fact_comp_pc_tiempo_fk
	JOIN FJGD_sql.BI_DIM_Sucursal S ON S.bi_sucu_id = PCC.fact_comp_pc_sucu_fk 
	GROUP BY T.bi_tiem_mes, bi_sucu_mail
GO
*/
/*VISTA ACCESORIOS 1 */
/*
CREATE VIEW [ac_precio_promedio] AS

SELECT 
	AC1.bi_ac_codigo [CODIGO_PC],
	(
	SELECT 
		AVG(ACC.fact_comp_ac_precio * ACC.fact_comp_ac_cantidad_comprada)
		FROM FJGD_sql.BI_FACT_AC_COMPRA ACC
		JOIN FJGD_sql.BI_DIM_AC AC2 ON AC2.bi_ac_id = ACC.fact_comp_ac_ac_fk
		WHERE AC2.bi_ac_codigo = AC1.bi_ac_codigo
	) AS [Precio promedio en compras],
	AVG(ACV.fact_vent_ac_precio_venta * ACV.fact_vent_ac_cantidad_vendida) AS [Precio promedio en ventas]
	FROM FJGD_sql.BI_FACT_AC_VENTA ACV
	JOIN FJGD_sql.BI_DIM_AC AC1 ON AC1.bi_ac_id = ACV.fact_vent_ac_ac_fk
	GROUP BY AC1.bi_ac_codigo
GO
*/
/*VISTA ACCESORIOS 2 */
/*
CREATE VIEW [ac_ganancias_x_sucursal_x_mes] AS

SELECT 
	(
	SELECT SUM(ACV.fact_vent_ac_precio_venta) FROM FJGD_sql.BI_FACT_AC_VENTA ACV
	JOIN FJGD_sql.BI_DIM_Tiempo T2 ON T2.bi_tiem_id = ACV.fact_vent_ac_tiempo_fk
	JOIN FJGD_sql.BI_DIM_Sucursal S2 ON S2.bi_sucu_id = ACV.fact_vent_ac_sucu_fk
	WHERE T2.bi_tiem_mes = T.bi_tiem_mes AND S2.bi_sucu_mail = S.bi_sucu_mail
	) - SUM(ACC.fact_comp_ac_precio) [Ganancia],
	t.bi_tiem_mes [mes],
	s.bi_sucu_mail [sucursal]
	FROM FJGD_sql.BI_FACT_AC_COMPRA ACC
	JOIN FJGD_sql.BI_DIM_Tiempo T ON T.bi_tiem_id = ACC.fact_comp_ac_tiempo_fk
	JOIN FJGD_sql.BI_DIM_Sucursal S ON S.bi_sucu_id = ACC.fact_comp_ac_sucu_fk 
	GROUP BY T.bi_tiem_mes, bi_sucu_mail
GO
*/
/*VISTA ACCESORIOS 3 */

--FALTA

/*VISTA ACCESORIOS 4 */
/*
CREATE VIEW [ac_max_stock_anual] AS

SELECT 
	SUM(ACC.fact_comp_ac_cantidad_comprada) - 
	(
		SELECT SUM(ACV.fact_vent_ac_cantidad_vendida) 
		FROM FJGD_sql.BI_FACT_AC_VENTA ACV
		JOIN FJGD_sql.BI_DIM_Tiempo T2 ON T2.bi_tiem_id = ACV.fact_vent_ac_tiempo_fk
		JOIN FJGD_sql.BI_DIM_Sucursal S2 ON S2.bi_sucu_id = ACV.fact_vent_ac_sucu_fk
		WHERE T2.bi_tiem_anio = T.bi_tiem_anio AND S2.bi_sucu_mail = S.bi_sucu_mail
	)  [stock maximo],
	t.bi_tiem_anio [anio],
	s.bi_sucu_mail [sucursal]
	FROM FJGD_sql.BI_FACT_AC_COMPRA ACC
	JOIN FJGD_sql.BI_DIM_Tiempo T ON T.bi_tiem_id = ACC.fact_comp_ac_tiempo_fk
	JOIN FJGD_sql.BI_DIM_Sucursal S ON S.bi_sucu_id = ACC.fact_comp_ac_sucu_fk 
	GROUP BY T.bi_tiem_anio, bi_sucu_mail
GO*/