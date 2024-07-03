--5. El gerente de Marketing desea preparar una promoción de importantes descuentos
--en las bebidas tipo Energy Drink para promocionar este tipo de bebidas en los
--eventos deportivos a producirse en los meses de setiembre, porque piensa que
--coincide con una etapa de picos en el monto de ventas dentro del año. Es correcta
--esta afirmación?
CREATE VIEW consulta5 as
SELECT top 1 p.descProduct, SUM(QUANTITY) as total_prod, t.mes
FROM Fact_Sales_G15 fa
join Product_G15 p on p.Key_Product = fa.Key_Product
join Time_G15 t on t.Key_Fecha = fa.DATE
where p.descProduct = 'Energy Drink' 
group by p.descProduct, t.Mes
order by total_prod desc
