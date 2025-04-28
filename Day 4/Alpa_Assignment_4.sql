--List all customers and the products they ordered with the order date. (Inner join)
--Tables used: customers, orders, order_details, products
--Output should have below columns:
--  companyname AS customer,
-- orderid,
-- productname,
-- quantity,
--  orderdate


SELECT C.company_name AS customer,
	   OD.order_id,P.product_name,OD.quantity,O.order_date
FROM customers C
INNER JOIN orders O ON C.customer_id = O.customer_id
INNER JOIN order_details OD ON O.order_id = OD.order_id
INNER JOIN products P ON OD.product_id = P.product_id;

--2. Show each order with customer, employee, shipper, 
--and product info — even if some parts are missing. (Left Join)
--Tables used: orders, customers, employees, shippers, order_details, products

SELECT * FROM customers;

SELECT C.customer_id, E.first_name || ' ' || E.last_name AS Employee,
	   S.shipper_id, P.product_name
FROM orders O
LEFT JOIN customers C ON O.customer_id = C.customer_id
LEFT JOIN employees E ON O.employee_id = E.employee_id
LEFT JOIN shippers S ON O.ship_via = S.shipper_id
LEFT JOIN order_details OD ON O.order_id = OD.order_id
LEFT JOIN products P ON OD.product_id = P.product_id;

--3. Show all order details and products (include all products 
--even if they were never ordered). (Right Join)
--Tables used: order_details, products
--Output should have below columns:
--    orderid,
--    productid,
--   quantity,
--    productname

SELECT OD.order_id,P.product_id,OD.quantity,P.product_name
FROM order_details OD
RIGHT JOIN products P ON OD.product_id = P.product_id;

--4. List all product categories and their products — 
--including categories that have no products, and 
--products that are not assigned to any category.(Outer Join)
--Tables used: categories, products

SELECT * FROM categories;

SELECT CT.category_id, CT.category_name,
       P.product_id, P.product_name
FROM categories CT 
FULL OUTER JOIN products P
   ON CT.category_id = P.category_id;

--5. Show all possible product and category combinations (Cross join).
SELECT CT.category_name, P.product_name
FROM products P
CROSS JOIN categories CT;

--6. Show all employees and their manager(Self join(left join))

SELECT employee_id,first_name ||' '|| last_name AS Employee_Name,reports_to FROM employees;

SELECT E.first_name ||' '|| E.last_name AS Employee_Name,
       M.first_name ||' '|| M.last_name AS Manager_Name
FROM employees E
LEFT JOIN employees M
ON E.reports_to = M.employee_id;

--7. List all customers who have not selected a shipping method.
--Tables used: customers, orders
--(Left Join, WHERE o.shipvia IS NULL)

SELECT * FROM orders;
SELECT * FROM customers;

SELECT C.customer_id ,O.ship_via
FROM customers C
LEFT JOIN orders O
ON C.customer_id = O.customer_id
WHERE O.ship_via IS NULL;








