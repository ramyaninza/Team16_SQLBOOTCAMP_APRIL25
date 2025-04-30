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

