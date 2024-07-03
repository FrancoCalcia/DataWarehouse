--Cantidad de litros consumidos y de productos adquiridos por cliente en el tiempo
--CREATE VIEW vw_ConsumisionesClientes_1 AS
SELECT 
    fs.Key_Customer,
    SUM(fs.Cantidad_litros) AS Total_Litros,
    SUM(fs.QUANTITY) AS Total_Productos,
    t.Año,
	t.Mes
    
FROM datawarehouse.dbo.Fact_Sales_G15 fs
join Time_G15 t on Key_Fecha = DATE

GROUP BY Key_Customer, Año, Mes

