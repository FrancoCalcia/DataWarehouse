--6.El gerente de Marketing también quiere saber cómo es la relación entre lasedades y
--los tipos de bebida, teniendo en cuenta la cantidad de litros vendidos. Es importante
--el tipo de bebida en la determinación de los grupos etarios?CREATE VIEW consulta6 as
SELECT
    CASE 
        WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 20 AND 30 THEN '20-30'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 30 AND 40 THEN '30-40'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 40 AND 50 THEN '40-50'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 50 AND 60 THEN '50-60'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 60 AND 70 THEN '60-70'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 70 AND 80 THEN '70-80'
        ELSE '80-110'
    END AS edad_grupo,
    P.descProduct AS tipo_bebida,
    SUM(fact.QUANTITY) AS cantidad_litros_vendidos
    
FROM 
    Fact_Sales_G15 fact
JOIN 
    Product_G15 P ON P.Key_Product = fact.Key_Product
JOIN 
    Customer_G15 C ON C.Key_Customer = fact.Key_Customer

GROUP BY 
    CASE 
        WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 20 AND 30 THEN '20-30'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 30 AND 40 THEN '30-40'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 40 AND 50 THEN '40-50'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 50 AND 60 THEN '50-60'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 60 AND 70 THEN '60-70'
		WHEN DATEDIFF(YEAR, C.Fecha_Nac, GETDATE()) BETWEEN 70 AND 80 THEN '70-80'
        ELSE '80-110'
    END,
    P.descProduct
    
--ORDER BY 
    --edad_grupo asc,cantidad_litros_vendidos desc
