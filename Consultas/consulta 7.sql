--También para la segmentación de los consumidores se desea saber
--puntualmente cuál es el monto de ventas global para los teenagers (13-19), para
--los adultos medios (40-50) y, por un capricho propio del gerente, para los
--consumidores de su misma edad (66 años)
CREATE VIEW consulta7 as
SELECT
    CASE 
        WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 13 AND 19 THEN '13-19'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 40 AND 50 THEN '40-50'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) = 66 THEN '66'
		
        
    END AS edad_grupo,
    SUM(fact.QUANTITY * fact.PRICE) AS MontoTotal
FROM 
    Fact_Sales_G15 fact
JOIN 
    Product_G15 P ON P.Key_Product = fact.Key_Product
JOIN 
    Customer_G15 C ON C.Key_Customer = fact.Key_Customer

GROUP BY 
    CASE 
        WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 13 AND 19 THEN '13-19'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 40 AND 50 THEN '40-50'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) = 66 THEN '66'
        
    END
HAVING 
    CASE
        WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 13 AND 19 THEN '13-19'
        WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 40 AND 50 THEN '40-50'
        WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) = 66 THEN '66'
    END IS NOT NULL
--ORDER BY 
    --edad_grupo asc
