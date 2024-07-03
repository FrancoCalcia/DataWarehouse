-- Eliminar las tablas si existen

IF OBJECT_ID('Fact_Sales_G15', 'U') IS NOT NULL
    DROP TABLE Fact_Sales_G15;

IF OBJECT_ID('Time_G15', 'U') IS NOT NULL
    DROP TABLE Time_G15;

IF OBJECT_ID('Customer_G15', 'U') IS NOT NULL
    DROP TABLE Customer_G15;

IF OBJECT_ID('Region_G15', 'U') IS NOT NULL
    DROP TABLE Region_G15;

IF OBJECT_ID('Product_G15', 'U') IS NOT NULL
    DROP TABLE Product_G15;

IF OBJECT_ID('Employee_G15', 'U') IS NOT NULL
    DROP TABLE Employee_G15;


-- Ahora crear las tablas

-- Crear tabla Dimensiones Empleado
CREATE TABLE Employee_G15 (
    Key_Employee INT PRIMARY KEY IDENTITY (1,1),  -- Identificador único para el empleado
    ID_Employee INT,
    Nombre NVARCHAR(100),          -- Nombre del empleado
    Genero NVARCHAR(2),            -- Género (M/F)
    Categoria NVARCHAR(50),        -- Categoría del empleado
    Fecha_Ingreso DATE,            -- Fecha de ingreso del empleado
    Fecha_Nac DATE,                -- Fecha de nacimiento del empleado
    Nivel_Educacion NVARCHAR(50)   -- Nivel de educación
);

CREATE TABLE [dbo].[Time_G15](
	[Key_Fecha] INT PRIMARY KEY,
	[Fecha] [date] NULL,
	[Dia] [int] NULL,
	[Mes] [int] NULL,
	[NombreMes] [nvarchar](30) NULL,
	[Año] [int] NULL,
	[Trimestre] [int] NULL,
	[Semestre] [int] NULL,
	[DiaSemana] [int] NULL,
	[NombreDiaSemana] [nvarchar](30) NULL,
	[Semana] [int] NULL,
	[DiaAño] [int] NULL
);

-- Crear tabla Dimensiones Producto
CREATE TABLE Product_G15 (
    Key_Product INT PRIMARY KEY IDENTITY(1,1),  -- Identificador único para el producto
    ID_Product INT,
    descProduct VARCHAR(255),           -- Rubro del producto
    Capacidad VARCHAR(255),             -- Tipo de presentación del producto
    Unidad NVARCHAR(255)                -- Detalle del producto
);


-- Crear tabla Dimensiones Regiones
CREATE TABLE Region_G15 (
    Cod_Postal INT PRIMARY KEY,                -- Código postal (PK)
    Zona VARCHAR(50),            -- Zona de la región
    Estado VARCHAR(50),          -- Estado de la región
    Ciudad VARCHAR(50)           -- Ciudad de la región
);

-- Crear tabla Dimensiones Cliente
CREATE TABLE Customer_G15 (
    Key_Customer INT PRIMARY KEY IDENTITY(1,1),   -- Identificador único para el cliente
    ID_Customer INT,
    Tipo_Cliente NVARCHAR(50),     -- Tipo de cliente
    Nombre NVARCHAR(100),          -- Nombre del cliente
    Fecha_Nac DATE,                -- Fecha de nacimiento del cliente
    Ciudad NVARCHAR(255),          -- Ciudad del cliente
    Estado NVARCHAR(255),          -- Estado del cliente
    Cod_Postal INT,                 -- Código postal del cliente

    CONSTRAINT ccp FOREIGN KEY (Cod_Postal) REFERENCES Region_G15(Cod_Postal)
);

-- Crear tabla Hecho Ventas con claves foráneas referenciando las dimensiones
-- Crear tabla Hecho Ventas con claves autoincrementables
CREATE TABLE Fact_Sales_G15 (
    Key_Fact INT PRIMARY KEY IDENTITY(1,1),
	BILLING_ID INT,
    DATE INT,
    Key_Customer INT,                    -- Clave sustituta de Cliente
    Key_Employee INT,                    -- Clave sustituta de Empleado
    Key_Product INT,                     -- Clave sustituta de Producto
    QUANTITY INT,
    REGION NVARCHAR(50),
    PRICE FLOAT,
    Cantidad_litros FLOAT,
	
    CONSTRAINT fc FOREIGN KEY (Key_Customer) REFERENCES Customer_G15(Key_Customer),
    CONSTRAINT fe FOREIGN KEY (Key_Employee) REFERENCES Employee_G15(Key_Employee),
    CONSTRAINT fp FOREIGN KEY (Key_Product) REFERENCES Product_G15(Key_Product),
	CONSTRAINT ff FOREIGN KEY (DATE) REFERENCES Time_G15(Key_Fecha)
);
