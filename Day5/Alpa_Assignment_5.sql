-- 1. GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost 
--only for those orders where freight cost > 100

SELECT EXTRACT(YEAR FROM order_date) AS Order_Year,
	EXTRACT(QUARTER FROM order_date) AS Order_Quarter,
	ROUND(AVG(freight)::NUMERIC,2) AS Avg_Freight,
	COUNT(order_id) AS Order_Count
FROM orders
	WHERE freight > 100
GROUP BY Order_Year,Order_Quarter
ORDER BY Order_Year,Order_Quarter;

--GROUP BY with HAVING - High Volume Ship Regions
--Display, ship region, no of orders in each region, min and max freight cost
-- Filter regions where no of orders >= 5

SELECT ship_region, 
	COUNT(order_id) AS No_Of_Order,
	MIN(freight) AS Min_Freight,
	MAX(freight) AS Max_Freight
FROM orders
GROUP BY ship_region
HAVING COUNT(order_id) >= 5
ORDER BY No_Of_Order DESC;

SELECT DISTINCT(ship_region) FROM orders;

--3. Get all title designations across employees and customers ( Try UNION & UNION ALL)

SELECT distinct(title) FROM employees;

SELECT distinct(contact_title) FROM customers;

SELECT title FROM employees
UNION
SELECT contact_title FROM customers;

SELECT title FROM employees
UNION ALL
SELECT contact_title FROM customers;

--4. Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)

SELECT title FROM employees
INTERSECT
SELECT contact_title FROM customers;


SELECT * FROM categories;

SELECT category_id,units_in_stock,discontinued FROM products;





SELECT DISTINCT(category_id) FROM products
WHERE units_in_stock > 0 

INTERSECT

SELECT DISTINCT(category_id) FROM products
WHERE discontinued = 1
ORDER BY category_id;

--5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT DISTINCT(order_id) FROM order_details

EXCEPT 

SELECT DISTINCT(order_id) FROM order_details
WHERE discount > 0;
