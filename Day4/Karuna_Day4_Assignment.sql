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