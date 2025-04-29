																	--Elamathi_Day 5
--1. GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100		
SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(*) AS order_count,
    AVG(freight) AS avg_freight_cost
FROM 
    orders
WHERE 
    freight > 100
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY 
    order_year,
    order_quarter;
--....................................................................................................................................................................
--2. GROUP BY with HAVING - High Volume Ship Regions
--Display, ship region, no of orders in each region, min and max freight cost Filter regions where no of orders >= 5
SELECT 
    ship_region,
    COUNT(order_id) AS order_count,
    MIN(freight) AS min_freight_cost,
    MAX(freight) AS max_freight_cost
	
FROM 
    orders
GROUP BY 
    ship_region
HAVING 
    COUNT(order_id) >= 5 AND ship_region IS NOT NULL
ORDER BY 
    order_count DESC;
--....................................................................................................................................................................

-- 3.Get all title designations across employees and customers ( Try UNION & UNION ALL)
--3.1 With UNION
SELECT title FROM employees
UNION
SELECT contact_title FROM customers;

--3.2 With UNION ALL
SELECT title FROM employees
UNION ALL
SELECT contact_title FROM customers;
--....................................................................................................................................................................

-- 4.Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)
SELECT category_id FROM products
WHERE units_in_stock > 0

INTERSECT

SELECT category_id FROM products 
WHERE discontinued = 1;

SELECT * FROM products

--....................................................................................................................................................................

--5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT DISTINCT order_id FROM order_details

EXCEPT

SELECT DISTINCT order_id FROM order_details
WHERE discount > 0;

	
