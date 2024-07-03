# Proyecto de Data Warehouse

## Descripción General
Este proyecto consiste en la creación de un Data Warehouse utilizando como fuente de datos distintos tipos de archivos (.txt, .xml, .csv, etc). El objetivo principal es integrar y analizar datos provenientes de múltiples fuentes para generar insights valiosos a través de visualizaciones en Power BI.

## Estructura del Proyecto

### Bases de Datos
Se han creado tres bases de datos distintas en SQL Server:

1. **Staging**:
   - Creé una base de datos llamada `Staging` en SQL Server.
   - Conecté la base de datos en Visual Studio 2022 y traje los datos desde todas las fuentes y los cargué tal como estaban en SQL Server.
   - Además, me conecté a los dos servidores (MySQL y SQL Server) propuestos por los profesores para obtener más fuentes de datos.

2. **Intermedia**:
   - Creé una base de datos llamada `Intermedia`.
   - Utilicé Visual Studio 2022 para realizar el proceso de limpieza de datos, similar a un proceso ETL (Extract, Transform, Load).
   - En SQL Server, corrí un script que crea una tabla llamada `tiempo`, obteniendo la fecha mínima de la tabla BillingHist y la fecha máxima de la tabla Billing.
   - En la tabla `tiempo`, se realiza la conversión de todas las fechas, separándolas en Fecha, Día, Mes, Año, Trimestre, Semestre, etc.
   - Ejecute otro script en la base de datos `DataWarehouse` que crea las dimensiones y la tabla de hechos (fact table) con sus respectivas PK y FK.

3. **DataWarehouse**:
   - Desde VisualStudio relaicé la carga de todas las Dimensiones
   - Posteriormente, corrí otro script que realiza el match de todos los datos de las Dimensiones y los carga en la tabla de hechos (fact table), formando un esquema de copo de nieve.

### Diagrama de Datos
El diagrama de datos en forma de copo de nieve se puede visualizar perfectamente, permitiendo una clara comprensión de las relaciones entre las diferentes tablas.

![Diagrama Data Warehouse](ruta/a/tu/imagen/Diagrama_DW.png)

## Herramientas Utilizadas
- **SQL Server**: Para la creación y gestión de las bases de datos.
- **Visual Studio 2022**: Para la limpieza y modificación de datos.
- **Power BI**: Para la creación de visualizaciones y análisis de datos.

## Consultas SQL
Se respondieron ciertas preguntas que se pueden observar en el pdf llamado "TP-FINAL" mediante consultas SQL, las cuales se llevaron a Power BI como vistas para poder graficar y analizar los datos de manera efectiva.

## Visualizaciones en Power BI
Se crearon diversas visualizaciones en Power BI para representar los insights obtenidos del análisis de datos. Aquí puedes ver un ejemplo de las visualizaciones realizadas:

![Dashboard Power BI](Dashboard.pdf)

## Cómo Ejecutar el Proyecto

1. **Configurar Conexiones**:
   - Asegúrate de poder realizar bien las conexiones a los servidores correspondientes. En mi caso, utilicé ODBC Data Source (32-bit).

2. **Crear Bases de Datos**:
   - Crear las bases de datos `Staging`, `Intermedia` y `DataWarehouse` en SQL Server.

3. **Cargar Datos en Staging**:
   - Ejecutar el contenedor  `Carga BD Staging` para importar los datos crudos desde todas las fuentes a la base de datos `Staging`.

4. **Limpiar y Modificar Datos**:
   - Ejecutar el contenedor  `Carga BD Intermedia` que realiza la limpieza y transformación de datos.

5. **Crear Dimension Tiempo**:
   - Ejecutar el script ` `

7. **Crear Dimensiones y Tabla de Hechos**:
   - Ejecutar los scripts `DIM_Y_FACT.sql`, `MatchFact.sql` que se encuentran en el repositorio para crear las dimensiones y la tabla de hechos, y realizar el match de los datos hacia la base de datos `DataWarehouse`.

8. **Crear Visualizaciones en Power BI**:
   - Importar las vistas SQL a Power BI y crear las visualizaciones necesarias para analizar los datos.



Si tienes alguna duda o sugerencia, no dudes en contactarme.
