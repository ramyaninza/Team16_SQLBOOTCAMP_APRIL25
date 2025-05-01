------------------------------- Day7 ------------------------------------
/*1.     Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/

select employee_id,employee_name,Total_Orders_Handled,
RANK() OVER (ORDER BY Total_Orders_Handled DESC) AS rank1
from (select e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    count(o.order_id) AS Total_Orders_Handled
    from employees e
    join orders o ON e.employee_id = o.employee_id
    group by e.employee_id, e.first_name, e.last_name
	) AS employee_sales;



/*2.      Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).
*/

select order_id,customer_id,order_date,freight,
LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_freight,
LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_freight
FROM orders
ORDER BY 
customer_id, order_date;

/* 3.     Show products and their price categories, product count in each category, avg price:
        	(HINT:
·  	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·  	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)
*/

WITH CTE_PriceCategory AS (
    select product_id,product_name,unit_price,
    CASE
    when unit_price < 20 then 'Low Price'
    when unit_price < 50 then 'Medium Price'
    else 'High Price'
    END as price_category
    from 
        products
	)
	select  price_category,count(*) as product_count,ROUND(avg(unit_price)::numeric, 2) as avg_price
	from CTE_PriceCategory
	group by price_category
	order by avg_price;
