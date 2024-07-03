--10. Se desea saber también si los vendedores con mayor antigüedad en el empleo
--venden la mayor cantidad de productos.
CREATE VIEW consulta10 as
SELECT 
DATEDIFF(YEAR, E.Fecha_Ingreso, GETDATE()) as AñosAntiguedad,
SUM(f.QUANTITY) as TotalProductos
FROM Employee_G15 e
join Fact_Sales_G15 f on f.Key_Employee = e.Key_Employee
group by DATEDIFF(YEAR, E.Fecha_Ingreso, GETDATE())
--order by AñosAntiguedad desc, TotalProductos desc