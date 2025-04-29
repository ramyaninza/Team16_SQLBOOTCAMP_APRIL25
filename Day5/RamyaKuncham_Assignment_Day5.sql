SELECT 
EXTRACT(year from "orderdate") as ORDERYEAR,
EXTRACT(quarter from "orderdate") as ORDERQUARTER,
count(*) as ORDERCOUNT,
AVG("Freight") AS AvgFreight
FROM "Orders"
WHERE "Freight" > 100
GROUP BY OrderYear, OrderQuarter
ORDER BY OrderYear, OrderQuarter;

SELECT tablename
FROM pg_catalog.pg_tables
WHERE schemaname = 'public';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'orders';

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(*) AS order_count,
    AVG(freight) AS avg_freight
FROM orders
WHERE freight > 100
GROUP BY order_year, order_quarter
ORDER BY order_year, order_quarter;

SELECT 
    ship_region,
    COUNT(*) AS order_count,
    MIN(freight) AS min_freight,
    MAX(freight) AS max_freight
FROM orders
GROUP BY ship_region
HAVING COUNT(*) >= 5
ORDER BY order_count DESC;

SELECT title AS designation
FROM employees

UNION

SELECT contact_title AS designation
FROM customers;

SELECT title AS designation
FROM employees

UNION ALL

SELECT contact_title AS designation
FROM customers;

-- Categories with discontinued products
SELECT category_id
FROM products
WHERE discontinued = 1

INTERSECT

-- Categories with in-stock products
SELECT category_id
FROM products
WHERE units_in_stock > 0;

-- All orders
SELECT order_id
FROM order_details

EXCEPT

-- Orders that have at least one discounted item
SELECT DISTINCT order_id
FROM order_details
WHERE discount > 0;








