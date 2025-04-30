 --1. Categorize products by stock status
--(Display product_name, a new column stock_status whose values are based on below condition
-- units_in_stock = 0  is 'Out of Stock'
--       units_in_stock < 20  is 'Low Stock')

SELECT product_name,
		units_in_stock,
	CASE 
		WHEN units_in_stock = 0 THEN 'Out of Stock'
		WHEN units_in_stock < 20 THEN 'Low Stock'
		ELSE 'High Stock'
	END AS Stock_Status
FROM products;


--2.  Find All Products in Beverages Category
--(Subquery, Display product_name,unitprice)
SELECT product_name,unit_price FROM products;
SELECT category_name FROM categories
WHERE category_name = 'Beverages';

SELECT product_name,unit_price 
FROM products
     WHERE category_id = 
	 (SELECT category_id FROM categories
      WHERE category_name = 'Beverages');



---Explaination of coalesce-----------------------------------------------
SELECT DISTINCT(employee_id),reports_to FROM employees;

SELECT 
	E1.first_name ||' '||E1.last_name AS Employee_Name,E2.employee_id
FROM employees E1
     LEFT JOIN employees E2 
	 ON E1.reports_to = E2.employee_id;

SELECT 
	E1.first_name ||' '||E1.last_name AS Employee_Name,E2.employee_id,
	COALESCE(E2.first_name ||' '||E2.last_name, 'No Manager') AS Manager_Name
FROM employees E1
     LEFT JOIN employees E2 
	 ON E1.reports_to = E2.employee_id;
-------------------------------------------------------------------------------
----Example of NULLIF , CAST function-------------
SELECT 
     first_name,
	 last_name,
	 --convert reports_to to text before COALESCE
	 COALESCE (CAST (NULLIF(reports_to,2) AS VARCHAR),'CEO') AS reports_to
FROM
	employees
ORDER BY
	last_name;
---(NULLIF(reports_to,2) change 2 with NULL
-- CAST (NULLIF(reports_to,2) AS VARCHAR changes integer to text
--COALESCE (CAST (NULLIF(reports_to,2) AS VARCHAR),'CEO') replace null with CEO
---------------------------------------------------------------------------------

--3. Find Orders by Employee with Most Sales
--(Display order_id,   order_date,  freight, employee_id.
--Employee with Most Sales=Get the total no.of of orders for 
--each employee then order by DESC and limit 1. Use Subquery)

SELECT SUM(quantity) FROM order_details;

SELECT 
	order_id,
	order_date,
	freight,
	employee_id
FROM 
	orders
WHERE 
	employee_id = (
		SELECT employee_id
		FROM orders O
			JOIN order_details OD 
			ON O.order_id = OD.order_id
		GROUP BY employee_id
		ORDER BY SUM(OD.quantity) DESC
		LIMIT 1
	);

--4. Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. 
--(Subquery, Try with ANY, ALL operators)
---ANY 
SELECT 
	ship_country,
	freight
FROM 
	orders
WHERE 
	ship_country != 'USA'
	AND freight > ANY(
		SELECT freight
		FROM orders
		WHERE ship_country = 'USA' 
	)
ORDER BY 
	freight;

SELECT 
	ship_country,
	freight
FROM 
	orders
WHERE 
		freight > ALL(
		SELECT freight
		FROM orders
		WHERE ship_country = 'USA' 
	)
ORDER BY 
	freight;	
