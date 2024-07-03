--15.Determinar que productos discontinuar.CREATE VIEW consulta15 asSELECT p.descProduct, t.Año, SUM(fa.QUANTITY) CantidadProductos
from Fact_Sales_G15 fa
join Time_G15 t on t.Key_Fecha = fa.DATE
join Product_G15 p on p.Key_Product = fa.Key_Product
where t.año = 2009
group by t.Año, p.descProduct
--order by CantidadProductos asc

-- se podria decir que el producto a discontinuar seria el Trappiste Beer