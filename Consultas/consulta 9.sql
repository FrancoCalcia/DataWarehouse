--9. También desea saber cuáles serán los 5 vendedores más prometedores 
--en monto de ventas para el año 2011.
CREATE VIEW consulta9 as
SELECT TOP 5
E.key_employee, 
T.año,
ROUND(SUM(fact.QUANTITY * fact.Price), 2) AS monto

FROM Fact_Sales_G15 fact
JOIN Employee_G15 AS E
ON E.Key_Employee = fact.Key_Employee
JOIN Time_G15 AS T
ON  T.Key_Fecha = fact.DATE

WHERE T.Año = 2009

GROUP BY
E.Key_Employee, T.Año