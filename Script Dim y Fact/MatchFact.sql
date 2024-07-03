-- Borrar la tabla temporal si existe
DROP TABLE IF EXISTS #PRICE;

-- Crear la tabla temporal con los precios
SELECT
    PRODUCT_ID,
    DATE AS FechaDesde,
    LEAD(DATE) OVER (PARTITION BY PRODUCT_ID ORDER BY DATE) AS FechaHasta,
    PRICE
INTO #PRICE
FROM staging.dbo.stg_prices_G15;

-- Insertar datos en la tabla de hechos
INSERT INTO datawarehouse.dbo.Fact_Sales_G15 (
    BILLING_ID, DATE, Key_Customer, Key_Employee, Key_Product, QUANTITY, REGION, PRICE, Cantidad_litros
)
SELECT 
    BillingSql.BILLING_ID, 
    BillingSql.FECHA, 
    Cus.Key_Customer, 
    Emp.Key_Employee, 
    Prod.Key_Product, 
    BillingSql.QUANTITY, 
    BillingSql.REGION, 
    Prices.PRICE,
    IntProd.Cantidad_litros
FROM intermedia.dbo.int_Billing_hist_G15 AS BillingSql
LEFT JOIN #PRICE AS Prices
    ON BillingSql.PRODUCT_ID = Prices.PRODUCT_ID
    AND BillingSql.DATE >= Prices.FechaDesde
    AND (BillingSql.DATE < Prices.FechaHasta OR Prices.FechaHasta IS NULL)
LEFT JOIN datawarehouse.dbo.Product_G15 AS Prod
    ON BillingSql.PRODUCT_ID = Prod.ID_Product
LEFT JOIN datawarehouse.dbo.Customer_G15 AS Cus
    ON BillingSql.CUSTOMER_ID = Cus.ID_Customer
LEFT JOIN datawarehouse.dbo.Employee_G15 AS Emp
    ON BillingSql.EMPLOYEE_ID = Emp.ID_Employee
LEFT JOIN intermedia.dbo.int_Producto_G15 AS IntProd
    ON BillingSql.PRODUCT_ID = IntProd.idProductos

UNION ALL

SELECT 
    MySql.BILLING_ID, 
    MySql.FECHA, 
    Cus.Key_Customer, 
    Emp.Key_Employee, 
    Prod.Key_Product, 
    MySqlDetail.QUANTITY, 
    MySql.REGION, 
    Prices.PRICE,
    IntProd.[Cantidad_litros]
FROM intermedia.dbo.int_Billing_G15 AS MySql
INNER JOIN stg_billing_details_G15 AS MySqlDetail
    ON MySql.BILLING_ID = MySqlDetail.BILLING_ID
LEFT JOIN #PRICE AS Prices
    ON MySqlDetail.PRODUCT_ID = Prices.PRODUCT_ID
    AND MySql.DATE >= Prices.FechaDesde
    AND (MySql.DATE < Prices.FechaHasta OR Prices.FechaHasta IS NULL)
LEFT JOIN datawarehouse.dbo.Product_G15 AS Prod
    ON MySqlDetail.PRODUCT_ID = Prod.ID_Product
LEFT JOIN datawarehouse.dbo.Customer_G15 AS Cus
    ON MySql.CUSTOMER_ID = Cus.ID_Customer
LEFT JOIN datawarehouse.dbo.Employee_G15 AS Emp
    ON MySql.EMPLOYEE_ID = Emp.ID_Employee
LEFT JOIN intermedia.dbo.int_Producto_G15 AS IntProd
    ON MySqlDetail.PRODUCT_ID = IntProd.idProductos;
