USE GD2015C1

DROP DATABASE GD1C2021ENTREGA;

/* Creacion de la base de datos */

CREATE DATABASE GD1C2021ENTREGA;
USE GD1C2021ENTREGA;

/* Creacion de tablas */

CREATE TABLE Cliente(
	clie_idCliente int NOT NULL,
	clie_Apellido char(30) NOT NULL,
	clie_Nombre char(30) NOT NULL,
	clie_DNI char(15) NOT NULL,
	clie_Direccion char(50) NULL,
	clie_fechaNacimiento smalldatetime NULL,
	clie_mail char(50) NULL,
	clie_telefono char(50) NULL
)


CREATE TABLE Proveedor(
	prov_idProveedor int NOT NULL,
	prov_idCompra int NOT NULL,
	prov_Descripcion char(50) NOT NULL
)


CREATE TABLE Factura(
	fact_idFactura char(15) NOT NULL,
	fact_idCliente int NOT NULL,
	fact_Numero char(8) NOT NULL,
	fact_fecha smalldatetime NOT NULL,
	fact_Total decimal(14,2) NOT NULL
)



CREATE TABLE ItemFactura(
	ifact_idFactura char(15) NOT NULL,
	ifact_idProducto char(15) NOT NULL,
	ifact_idCategoria int NOT NULL,
	ifact_idCliente int NOT NULL,
	ifact_Cantidad decimal(10,2) NOT NULL,
	ifact_PrecioFactura decimal(14,2) NOT NULL
)



CREATE TABLE Compra(
	comp_idCompra int NOT NULL,
	comp_idSucursal int NOT NULL,
	comp_idProveedor int NULL,
	comp_FechaCompra smalldatetime NOT NULL,
	comp_NumeroCompra char(8) NOT NULL,
	comp_GastoTotal decimal(14,2) NOT NULL
)

CREATE TABLE ItemCompra(
	icomp_idCompra int NOT NULL,
	icomp_idProducto char(15) NOT NULL,
	icomp_idCategoria int NOT NULL,
	icomp_PrecioCompra decimal(14,2) NOT NULL,
	icomp_Cantidad decimal(10,2)
)


CREATE TABLE Sucursal(
	sucu_idSucursal int NOT NULL,
	sucu_Mail char(50) NULL,
	sucu_Direccion char(50) NOT NULL,
	sucu_Telefono char(50) NULL,
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
	acce_Descripcion char(50) NULL,
	pc_idRam char(15) NOT NULL,
	pc_idMicro char(15) NOT NULL,
	pc_idVideo char(15) NOT NULL,
	pc_idDisco char(15) NOT NULL,
	pc_profundida char(15) NOT NULL,
	pc_ancho char(15) NOT NULL
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
	vide_idVideo char(15) NOT NULL,
	vide_Chipset char(30) NOT NULL,
	vide_Capacidad char(30) NOT NULL,
	vide_Velocidad char(30) NOT NULL,
	vide_Modelo char(30) NOT NULL,
	vide_idFabricante char(30) NOT NULL
)

CREATE TABLE Disco(
	disc_idDisco char(15) NOT NULL,
	disc_tipo char(30) NOT NULL,
	disc_capacidad char(30) NOT NULL,
	disc_velocidad char(30) NOT NULL,
	disc_Modelo char(30) NOT NULL,
	disc_idFabricante  char(30) NOT NULL
)



/* Primaries key */
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY(clie_idCliente)

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

ALTER TABLE Video ADD CONSTRAINT PK_Video PRIMARY KEY (vide_idVideo)

ALTER TABLE Disco ADD CONSTRAINT PK_Disco PRIMARY KEY (disc_idDisco)

ALTER TABLE Fabricante ADD CONSTRAINT PK_Fabricante PRIMARY KEY (fabr_codigo)

/* Foreings key */

ALTER TABLE Factura
ADD 
	CONSTRAINT FK_FacturaCliente FOREIGN KEY(fact_idCliente) REFERENCES Cliente(clie_idCliente)

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
	CONSTRAINT FK_PCVideo FOREIGN KEY (pc_idVideo) REFERENCES Video(vide_idVideo),
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