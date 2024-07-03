--consulta 16
-- Determinar los clientes más valiosos por monto total de ventas
CREATE VIEW consulta16 AS
WITH TotalSalesPerCustomer AS (
    SELECT 
        fa.Key_Customer,
        SUM(fa.QUANTITY * fa.PRICE) AS MontoTotal
    FROM 
        Fact_Sales_G15 fa
    GROUP BY 
        fa.Key_Customer
),

-- Filtrar los clientes más valiosos (por ejemplo, el top 5)
TopValuableCustomers AS (
    SELECT top 5
        Key_Customer,
        MontoTotal
    FROM 
        TotalSalesPerCustomer
    --ORDER BY 
        --MontoTotal DESC
 
)

-- Analizar el comportamiento de estos clientes a lo largo del tiempo
SELECT 
    fa.Key_Customer,
    t.Año,
    t.Mes,
    SUM(fa.QUANTITY * fa.PRICE) AS MontoTotalMensual
FROM 
    Fact_Sales_G15 fa
JOIN 
    Time_G15 t ON t.Key_Fecha = fa.DATE
JOIN 
    TopValuableCustomers tvc ON tvc.Key_Customer = fa.Key_Customer
GROUP BY 
    fa.Key_Customer, t.Año, t.Mes
--ORDER BY 
    --fa.Key_Customer, t.Año, t.Mes;
