USE [intermedia]
GO

-- Crear la tabla de dimensión de tiempo
DECLARE @StartDate date;
SELECT @StartDate = MIN([date]) 
FROM intermedia.dbo.int_billing_hist_G15;

DECLARE @EndDate date;
SELECT @EndDate = MAX([date]) 
FROM intermedia.dbo.int_billing_G15;

WITH Fechas(Fecha) AS (
    SELECT @StartDate
    UNION ALL
    SELECT DATEADD(d, 1, Fecha)
    FROM Fechas
    WHERE Fecha < @EndDate
)
SELECT 
	   Fecha,
	   convert(varchar(8), Fecha, 112) AS key_tiempo,
       DAY(Fecha) AS Dia, 
       MONTH(Fecha) AS Mes, 
       DATENAME(MONTH, Fecha) AS NombreMes, 
       YEAR(Fecha) AS Año, 
       DATEPART(QUARTER, Fecha) AS Trimestre, 
       (DATEPART(QUARTER, Fecha) + 1) / 2 AS Semestre, 
       DATEPART(WEEKDAY, Fecha) AS DiaSemana, 
       DATENAME(WEEKDAY, Fecha) AS NombreDiaSemana, 
       DATEPART(WEEK, Fecha) AS Semana, 
       DATEPART(DAYOFYEAR, Fecha) AS DiaAño
INTO intermedia.dbo.dim_time_2024_G15
FROM Fechas
OPTION (MAXRECURSION 0);

-- Crear el procedimiento almacenado
CREATE PROCEDURE stored_procedure_int_tiempo_1
    @StartDate date,
    @EndDate date
AS
BEGIN
    -- Limpiar la tabla antes de insertar nuevos registros
    TRUNCATE TABLE intermedia.dbo.dim_time_2024_G15;

    WITH Fechas(Fecha) AS (
        SELECT @StartDate
        UNION ALL
        SELECT DATEADD(d, 1, Fecha)
        FROM Fechas
        WHERE Fecha < @EndDate
    )
    INSERT INTO intermedia.dbo.dim_time_2024_G15(Fecha, key_tiempo, Dia, Mes, NombreMes, Año, Trimestre, Semestre, DiaSemana, NombreDiaSemana, Semana, DiaAño)
    SELECT
		   Fecha,
		   convert(varchar(8), Fecha, 112) AS key_tiempo,
           DAY(Fecha) AS Dia, 
           MONTH(Fecha) AS Mes, 
           DATENAME(MONTH, Fecha) AS NombreMes, 
           YEAR(Fecha) AS Año, 
           DATEPART(QUARTER, Fecha) AS Trimestre, 
           (DATEPART(QUARTER, Fecha) + 1) / 2 AS Semestre, 
           DATEPART(WEEKDAY, Fecha) AS DiaSemana, 
           DATENAME(WEEKDAY, Fecha) AS NombreDiaSemana, 
           DATEPART(WEEK, Fecha) AS Semana, 
           DATEPART(DAYOFYEAR, Fecha) AS DiaAño
    FROM Fechas
    OPTION (MAXRECURSION 0);
END;
GO

-- Esto se pega en SSIS
DECLARE @RC int
DECLARE @StartDate date
DECLARE @EndDate date
SELECT @StartDate = MIN([date]) FROM intermedia.dbo.int_billing_hist_G15;
SELECT @EndDate = MAX([date]) FROM intermedia.dbo.int_billing_G15;
-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stored_procedure_int_tiempo_1] 
   @StartDate
   ,@EndDate
GO
