--3. Rankear los productos por zonas geográficas a través del tiempo
CREATE VIEW consulta3 AS
SELECT 
    fact.key_product,
    fact.region,
    t.año,
    t.mes,
    SUM(fact.QUANTITY) AS total_prod_adquiridos,
    RANK() OVER (PARTITION BY fact.region, t.año, t.mes ORDER BY SUM(fact.QUANTITY) DESC) AS rank_prod_por_zona
FROM 
    datawarehouse.dbo.Fact_Sales_G15 fact
JOIN 
    datawarehouse.dbo.Time_G15 t 
    ON fact.DATE = t.Key_Fecha
GROUP BY 
    fact.key_product, fact.region, t.año, t.mes;
