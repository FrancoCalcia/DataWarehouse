--13.El gerente supone que las bebidas diet están perdiendo popularidad.
CREATE VIEW consulta13 as
SELECT t.Año, p.descProduct, SUM(fa.QUANTITY) CantidadProductos
from Fact_Sales_G15 fa
join Time_G15 t on t.Key_Fecha = fa.DATE
join Product_G15 p on p.Key_Product = fa.Key_Product
WHERE p.Unidad LIKE 'Diet%'
group by t.Año, p.descProduct
--order by CantidadProductos asc