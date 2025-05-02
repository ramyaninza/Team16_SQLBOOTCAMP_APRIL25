---------------------------------------------- DAY 4 ---------------------------------------


/* 1.     List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products */


select c.company_name as customer,o.order_id,p.product_name,p.quantity_per_unit,o.order_date
from customers c
inner join orders o on c.customer_id = o.customer_id
inner join order_details od on o.order_id = od.order_id
inner join products p on od.product_id = p.product_id;


/* 2.     Show each order with customer, employee, shipper, 
and product info — even if some parts are missing. (Left Join)*/

select  o.order_id, p.product_name,concat(first_name, ' ',last_name) as employee_name,c.company_name as customer,
	   s.company_name as shipper
from orders o
left join customers c on o.customer_id = c.customer_id
left join employees e on o.employee_id = e.employee_id
left join shippers s on o.ship_via = s.shipper_id
left join order_details od on o.order_id = od.order_id
left join products p on od.product_id = p.product_id;


/*3.     Show all order details and products (include all products even if they were never ordered). (Right Join) */

select od.order_id,p.product_id,od.quantity,p.product_name
from order_details od
right join products p on od.product_id = p.product_id;

/* 4. 	List all product categories and their products — including categories that have no products, 
and products that are not assigned to any category.(Outer Join)*/

select c.category_name, p.product_name
from categories c 
full outer join products p on c.category_id = p.category_id;


/* 5. 	Show all possible product and category combinations (Cross join). */

select * from
categories c cross join products p;

/* 6. 	Show all employees and their manager(Self join(left join)) */

select * from employees;

select concat(e.first_name,' ',e.last_name) as Employee_Name,concat(e1.first_name,' ',e1.last_name) as Manager_Name
from employees e
left join employees e1
on e.reports_to = e1.employee_id;


/* 7. 	List all customers who have not selected a shipping method. */

select c.customer_id, c.company_name
from customers c
left join orders o on c.customer_id = o.customer_id
where o.ship_via is null;



---------------------- Day5 ------------------------------
/*1.      GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100 */


select extract(Year from order_date) as order_year, extract(quarter from order_date) as order_quarter,
		count(*) as order_count,avg(freight)
from orders
where freight >100
group by order_year,order_quarter
order by order_year,order_quarter;

/*2.      GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5
*/


select ship_region,count(*) as no_of_orders,min(freight) as minimum_freight_cost,max(freight) as maximum_freight_cost
from orders
group by ship_region
having count(*)>=5
order by count(*) ;


/* 3.      Get all title designations across employees and customers ( Try UNION & UNION ALL) */

-- Union

select  title 
from employees
UNION
select contact_title
from customers;

-- Union ALL
select  title 
from employees
UNION ALL
select contact_title
from customers;




/* 4.      Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)
*/

select category_id from products
where units_in_stock > 0
INTERSECT
select category_id from products 
where discontinued = 1;


/* 5.      Find orders that have no discounted items (Display the  order_id, EXCEPT) */

select distinct order_id from order_details
EXCEPT
select distinct order_id from order_details where discount>0;



----------------------------- Day6 --------------------
/* 1.      Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock')
*/


select product_name,
CASE
	WHEN units_in_stock = 0 THEN 'Out of Stock'
	WHEN units_in_stock < 20 THEN 'Low Stock'
	ELSE 'In Stock'
END AS Stock_Status
from products;


/* 2.      Find All Products in Beverages Category
(Subquery, Display product_name,unitprice)
*/

select * from categories;

select product_name
from products
where category_id = (select category_id 
						from categories
						where category_name = 'Beverages');


/* 3.      Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)
*/

select * from orders;

select order_id,order_date,freight,employee_id
from orders
where employee_id = (select employee_id
						from orders
						group by employee_id
						order by count(*) DESC
						limit 1);


/* 4.      Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. 
(Subquery, Try with ANY, ALL operators)*/

select * from orders;

-- ANY
select order_id, ship_country
from orders
where ship_country!='USA' AND freight > ANY(select freight 
											 from orders
											 where ship_country = 'USA');

-- ALL
select order_id, ship_country
from orders
where ship_country!='USA' AND freight > ALL(select freight 
											 from orders
											 where ship_country = 'USA');




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




------------------------------------- Day8----------------------------------------------


/*1.     Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:
UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;*/

CREATE VIEW vw_updatable_products AS
SELECT product_id,product_name,unit_price,units_in_stock,discontinued 
FROM products
WHERE discontinued = 0
WITH CHECK OPTION;

SELECT * FROM vw_updatable_products;

UPDATE vw_updatable_products
SET unit_price = unit_price * 1.1
WHERE units_in_stock < 10
--....................................................................................................................................................................

/* 2.     Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.*/
BEGIN;
UPDATE products
SET unit_price = unit_price * 1.10
WHERE category_id = 1;
ROLLBACK;

COMMIT;

SELECT * FROM products WHERE category_id = 1;

--....................................................................................................................................................................
/* 3. Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description
*/
CREATE VIEW vw_employee AS
select e.employee_id,CONCAT(e.first_name, ' ', e.last_name) AS employee_full_name,e.title,t.territory_id,
t.territory_description,r.region_description
from employees e
join employee_territories et ON e.employee_id = et.employee_id
join territories t ON et.territory_id = t.territory_id
join region r ON t.region_id = r.region_id;
	
SELECT * FROM vw_employee;		

/* 4.Create a recursive CTE based on Employee Hierarchy*/

WITH RECURSIVE cte_employee_hierarchy AS (
select employee_id,first_name,last_name,reports_to,
0 AS level
from employees e
where reports_to IS NULL
UNION ALL
select  e.employee_id,e.first_name,e.last_name,e.reports_to,eh.level + 1
from employees e
inner join cte_employee_hierarchy eh 
ON eh.employee_id = e.reports_to)
select level,
employee_id,first_name || ' ' || last_name as employee_name
from cte_employee_hierarchy
order by level, employee_id;
