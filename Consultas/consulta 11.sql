--Se desea saber cuáles son los clientes minoristas 
--más valiosos siguiendo el principio de Pareto
CREATE VIEW consulta11 as
select top 72 c.Tipo_Cliente, c.Nombre, c.Key_Customer, 
ROUND(SUM(fa.PRICE * fa.QUANTITY),2) TotalVentas
from Customer_G15 c
join Fact_Sales_G15 fa on fa.Key_Customer = c.Key_Customer
where c.Tipo_Cliente = 'Minorista'
group by c.Tipo_Cliente, c.Nombre, c.Key_Customer
order by totalventas desc