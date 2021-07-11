USE MASTER
GO

DROP DATABASE IF EXISTS dbMesajil
CREATE DATABASE dbMesajil
GO

USE dbMesajil
GO
--- TABLAS ---
DROP TABLE IF EXISTS UBIGEO;
CREATE TABLE UBIGEO (
    CODUBI char(6)  NOT NULL,
    DEPUBI varchar(30)  NULL,
    PROUBI varchar(30)  NULL,
    DISTUBI varchar(30)  NULL,
    CONSTRAINT UBIGEO_pk PRIMARY KEY  (CODUBI)
);

DROP TABLE IF EXISTS SUCURSAL;
CREATE TABLE SUCURSAL (
    IDSUC int  NOT NULL IDENTITY(1, 1),
    NOMSUC varchar(30)  NULL,
    DESCSUC varchar(70)  NULL,
    DIRSUC varchar(100) NULL,
    CODUBI char(6)  NOT NULL,
    ESTSUC char(1)  NULL,
    CONSTRAINT SUCURSAL_pk PRIMARY KEY  (IDSUC)
);

DROP TABLE IF EXISTS PERSONA;
CREATE TABLE PERSONA (
    IDPER int NOT NULL IDENTITY(1, 1), 
    NOMPER varchar(30)  NULL,
    APEPER varchar(40)  NULL,
    DNIPER char(8)  NULL,
    CELPER char(9)  NULL,
    DIRPER varchar(70) UNIQUE NULL,
    CODUBI char(6)  NOT NULL,
    TIPPER char(1)  NULL,
    IDSUC int  NOT NULL,
    USUPER varchar(10)  NULL,
    PASPER varchar(50)  NULL,
    ESTPER char(1)  NULL,
    CONSTRAINT PERSONA_pk PRIMARY KEY  (IDPER)
);

DROP TABLE IF EXISTS EQUIPO;
CREATE TABLE EQUIPO (
    IDEQU int NOT NULL IDENTITY(1, 1),
    NOMEQUI varchar(30)  NULL,
    DESCEQU varchar(50)  NULL,
    CATEQUI char(2)  NULL,
    CANTEQU int  NULL,
    ESTEQU char(1)  NULL,
    MAREQU varchar(50)  NULL,
    CONSTRAINT EQUIPO_pk PRIMARY KEY  (IDEQU)
);

DROP TABLE IF EXISTS PRECIO;
CREATE TABLE PRECIO (
    IDPRE int NOT NULL IDENTITY(1, 1),
	IDEQU int NULL,
    PRECOM decimal(8,2)  NULL,
    PREVEN decimal(8,2)  NULL,
    ESTPRE char(1)  NULL,
    CONSTRAINT PRECIO_pk PRIMARY KEY  (IDPRE)
);

DROP TABLE IF EXISTS VENTA;
CREATE TABLE VENTA (
    IDVEN int NOT NULL IDENTITY(1, 1),
    IDCLI int  NULL,
    IDVEND int NULL,
	FECVEN date  NULL,
    ESTVEN char(1)  NULL,
    CONSTRAINT VENTA_pk PRIMARY KEY  (IDVEN)
);

DROP TABLE IF EXISTS VENTA_DETALLE;
CREATE TABLE VENTA_DETALLE (
    IDVENDET int NOT NULL IDENTITY(1, 1),
    IDVEN int  NULL,
    IDEQU int  NULL,
    CANT int  NULL,
    CONSTRAINT VENTA_DETALLE_pk PRIMARY KEY  (IDVENDET)
);

-- RELACIONES ---

-- Reference: PERSONA_SUCURSAL (table: PERSONA)
ALTER TABLE PERSONA ADD CONSTRAINT PERSONA_SUCURSAL
    FOREIGN KEY (IDSUC)
    REFERENCES SUCURSAL (IDSUC);

-- Reference: PERSONA_UBIGEO (table: PERSONA)
ALTER TABLE PERSONA ADD CONSTRAINT PERSONA_UBIGEO
    FOREIGN KEY (CODUBI)
    REFERENCES UBIGEO (CODUBI);

-- Reference: PRECIO_EQUIPO (table: PRECIO)
ALTER TABLE PRECIO ADD CONSTRAINT PRECIO_EQUIPO
    FOREIGN KEY (IDEQU)
    REFERENCES EQUIPO (IDEQU);

-- Reference: VENTA_PERSONA_CLIENTE (table: VENTA)
ALTER TABLE VENTA ADD CONSTRAINT VENTA_PERSONA_CLIENTE
    FOREIGN KEY (IDCLI)
    REFERENCES PERSONA (IDPER);

-- Reference: SUCURSAL_UBIGEO (table: SUCURSAL)
ALTER TABLE SUCURSAL ADD CONSTRAINT SUCURSAL_UBIGEO
    FOREIGN KEY (CODUBI)
    REFERENCES UBIGEO (CODUBI);

-- Reference: VENTA_DETALLE_EQUIPO (table: VENTA_DETALLE)
ALTER TABLE VENTA_DETALLE ADD CONSTRAINT VENTA_DETALLE_EQUIPO
    FOREIGN KEY (IDEQU)
    REFERENCES EQUIPO (IDEQU);

-- Reference: VENTA_DETALLE_VENTA (table: VENTA_DETALLE)
ALTER TABLE VENTA_DETALLE ADD CONSTRAINT VENTA_DETALLE_VENTA
    FOREIGN KEY (IDVEN)
    REFERENCES VENTA (IDVEN);

-- Reference: VENTA_PERSONA_VENDEDOR (table: VENTA)
ALTER TABLE VENTA ADD CONSTRAINT VENTA_PERSONA_VENDEDOR
    FOREIGN KEY (IDVEND)
    REFERENCES PERSONA (IDPER);
GO

--- INSERTAR REGISTROS ---

INSERT INTO UBIGEO 

 (CODUBI, DEPUBI, PROUBI, DISTUBI) 

VALUES
 ('100201', 'Ica', 'Chincha', 'Chincha Alta'),
 ('100203', 'Ica', 'Chincha', 'Tambo de Mora'),
 ('140406', 'Lima', 'Cañete', 'Imperial'),
 ('140401', 'Lima', 'Cañete', 'San Vicente'),
 ('140115', 'Lima', 'Lima', 'Miraflores'),
 ('140124', 'Lima', 'Lima', 'San Isidro'),
 ('140110', 'Lima', 'Lima', 'La Molina'),
 ('140101', 'Lima', 'Lima', 'Lima')
GO

INSERT INTO SUCURSAL 

(NOMSUC, DESCSUC, DIRSUC, CODUBI, ESTSUC) 

VALUES
('Mesajil Hnos', 'Tienda 107 Garcilaso', 'Av. Garcilaso de la Vega 1249', '140101', 'A'),
('Mesajil Hnos', 'Tienda 213 Garcilaso', 'Av. Garcilaso de la Vega 1261', '140101', 'A'),
('Mesajil Hnos', 'Tienda Lima Centro', 'Jr. Camaná 1127', '140101', 'A'),
('Mesajil Hnos', 'Tienda San Isidro', 'Av. República de Colombia', '140124', 'A'),
('Mesajil Hnos', 'Tienda Molina', 'Av. Javier Prado Este 5940', '140110', 'A'),
('Compupalace', 'Tienda 1073-1112-2107 Miraflores', 'Av. Petit Thouars 5356', '140115', 'A'),
('Mesajil Hnos', 'Tienda 1145 Mega Plaza', 'Av.Mariscal Benavides 115', '140401', 'A'),
('Mesajil Hnos', 'Tienda 1005 Chimcha', 'Av.Panamerisacana Sur', '100203', 'A')
GO
 
INSERT INTO PERSONA 

(NOMPER, APEPER, DNIPER, CELPER, DIRPER, CODUBI, TIPPER, IDSUC, USUPER, PASPER, ESTPER) 

VALUES 
('Andres', 'Cárdenas Chumpitaz', '74120152', '987456321', 'Av. La Molina Cuadra 28', '140110', 'C', 5, '', '','I'),
('Pedro', 'López Arias', '04180152', '987450321', 'Av. Las Malvinas 147', '100203', 'C', 8, '', '', 'A'),
('Jorge', 'Torres Candela', '84120102', '980456301', 'Av. Las Malvinas 128', '100203', 'C', 8, '', '', 'A'),
('Alberto', 'Zelada Vega', '75410455', '999000000', 'Av. Marical Benavides 223', '140401', 'C', 1, '', '', 'A'),
('Jaime ', 'De la Cruz Rojas', '44120152', '980406321', 'Av. La Molina Cuadra 40', N'140110', 'V', 5, 'Vend3', '202cb962ac59075b9', 'A'),
('Bryan', 'Benavente Casas', '71431184', '976315987', 'Av. Garcilaso de la Vega 1249', '140101', 'A', 1, 'Admin', '21232f297a57a5a74', 'A'),
('Angel', 'Carrillo Araujo', '71431560', '989219319', 'Av. Garcilaso de la Vega 1261', '140101', 'J', 2, 'Jefe', 'f4f068e71e0d87bf0', 'A'),
('Alexandro', ' Deza Mendez', '02431558', '980740291', 'Av. Garcilaso de la Vega 1243', '140101', 'J', 2, 'Jefe1', '8d6d3e8b969523e95', 'A'),
('Alexandra ', 'Benavente Casas', '71431183', N'981032131', 'Av. República de Colombia', '140124', 'V', 4, 'Vend2', '0953ce35a1c04be5e', 'A'),
('Arturo', 'Cavero López', '78102312', '989123320', 'Av. La Molina Cuadra 48', '140110', 'V', 5, 'Vend1', 'EU278WH72W27WY2W2', 'A')
GO

INSERT INTO EQUIPO 

(NOMEQUI, DESCEQU, CATEQUI, CANTEQU, ESTEQU, MAREQU) 

VALUES 
('Teclado AS', '', 'PF', 26, 'A',  'HP'),
('Computador', '', 'CP', 13, 'A',  'HP'),
('Celular Nokia', 'A34 tamaño 12', 'TB', 28, 'A', 'Motorola'),
('L450', 'Cartucho de 345', 'DM', 45, 'A',  'Lenovo'),
('LED XII K', '', 'TV', 28, 'A', 'HP'),
('Impresora LDF', 'Impresora de cartucho', 'DM', 0, 'A', 'EPSON'),
('Demo', '', 'CP', 0, 'I', 'HP'),
('Laptop', '', 'LP', 13, 'A ', 'HP'),
('dfg', 'Ideapad 520S', 'LP', 0, 'I', 'Lenovo'),
('fe', 'dfgh', 'LP', 0, 'I', 'HP'),
('Galaxy SV', '', 'TB', 90, 'A', 'Samsung'),
('Galaxy SVI', '', 'TB', 15, 'A', 'Samsung'),
('Galaxy Plus', '', 'TB', 0, 'A', 'HP'),
('Impresora Laser', '', 'DM', 0, 'A', 'HP'),
('JV', '', 'TB', 6, 'A', 'Samsung'),
('Tablet 234', '', 'TB', 19, 'A', 'Lenovo'),
('Tablet MQ', '', 'TB', 18, 'A',  'HP')
GO


INSERT INTO PRECIO

(IDEQU, PRECOM, PREVEN, ESTPRE) 

VALUES

(1,35.00, 50.00, 'A'),
(2,1900.00, 2450.00, 'I'),
(9,1770.00, 2200.00, 'A'),
(7,1700.00, 2000.00, 'A'),
(12,1500.00, 1895.00, 'A'),
(11,1200.00, 1650.00, 'I'),
(15,600.00, 950.00, 'A'),
(14,2000.00, 2450.00, 'A'),
(16,800.00, 900.00, 'A'),
(5,56.00, 45.00, 'I'),
(3,500.00, 1000.00, 'A'),
(8,3400.00, 5678.00, 'I'),
(13,1400.00, 1560.00, 'A')
GO

SET DATEFORMAT dmy
GO

INSERT INTO VENTA

(IDCLI, IDVEND, FECVEN, ESTVEN) 

VALUES

(6,10 , '17-06-2021', 'A'),
(6, 9, '19-07-2021', 'A'),
(4, 5, '09-04-2021', 'A'),
(8, 9, '10-07-2021', 'A'),
(8, 9, '10-05-2021', 'A'),
(4, 5, '17-06-2021', 'A')
GO

--Datos de Venta_Detalle--
INSERT INTO VENTA_DETALLE

(IDVEN, IDEQU, CANT) 

VALUES

(1, 3, 4),
(5, 1, 3),
(1, 8, 2),
(2, 5, 4),
(3, 2, 2),
(5, 9, 2),
(3, 7, 4),
(4, 10, 3)
GO

--- VISTAS ---
/* Cuantos registros existen por tabla */
SELECT COUNT(*) AS 'Total de Venta' FROM VENTA GO


/*Vista de las cantidad de los Ventas por fecha */
CREATE VIEW vCantVen
AS
SELECT
    FECVEN AS 'Fecha de Venta',
    COUNT(FECVEN) AS 'Total'
FROM
    VENTA
GROUP BY FECVEN
GO

-- Listar registros de una vista 
SELECT * FROM vCantVen
GO

/** Listar los montos totales de venta por cada mes **/
CREATE VIEW vTotVen
AS
SELECT 
    E.IDEQU AS 'ID del Equipo',
    E.NOMEQUI AS 'Nombre del Equipo',
	V.IDVEN AS 'Nùmero de Venta',
	V.FECVEN AS 'Fecha de Venta'
    
FROM EQUIPO AS E
    INNER JOIN VENTA AS V ON 
    E.IDEQU = V.IDVEN
WHERE
  MONTH (V.FECVEN) = 04

GO

-- Listar registros de una vista 
SELECT * FROM vTotVen
GO

/** Listar las cantidad  de equipo por venta **/
CREATE VIEW vCanEquVent
AS
SELECT 
	E.IDEQU AS 'ID del Equipo',
	E.CANTEQU AS 'Cantidad de Equipo',
	P.PREVEN AS 'Precio de Venta'
FROM 
	VENTA_DETALLE AS VD
	INNER JOIN VENTA AS V ON
	VD.IDVEN = V.IDVEN
	INNER JOIN EQUIPO AS E ON
	VD.IDEQU = E.IDEQU
	LEFT JOIN PRECIO AS P ON
	E.IDEQU = P.IDEQU
WHERE
MONTH (V.FECVEN) >= 04
GO

-- Listar registros de una vista 
SELECT * FROM vCanEquVent
GO

--- PROCEDIMIENTO ALCENADO ---
/* Procedimiento Almacenado para insertar VENTA */
CREATE PROCEDURE spInsertVenta
    (
        @idCliente INT,
		@idVendedor INT,
		@fechaVenta CHAR(1)
    )
AS
    BEGIN
    SET NOCOUNT ON
        BEGIN TRY
            BEGIN TRAN
                INSERT INTO VENTA
                    ( IDCLI, IDVEND, FECVEN)
                VALUES
                    (@idCliente, @idVendedor, UPPER(@fechaVenta)) 
                IF(@fechaVenta) = 'D' OR (@fechaVenta) = 'E'
                    COMMIT TRAN
                ELSE
                    ROLLBACK TRAN;
        END TRY
        BEGIN CATCH
            SELECT 'No se ha registrado la venta' AS 'FALLA'
            IF @@TRANCOUNT > 0 ROLLBACK TRAN; 
        END CATCH
    END 
GO 
