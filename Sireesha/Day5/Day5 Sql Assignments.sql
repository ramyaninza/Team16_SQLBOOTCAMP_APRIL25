/*Day 5, 1.      GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders
where freight cost > 100*/

SELECT * FROM orders

SELECT EXTRACT(YEAR FROM orderdate) AS orderyear, 
EXTRACT(QUARTER FROM orderdate) AS quarter,
COUNT(orderid) As ordercount, ROUND(AVG(freight)::numeric, 2) AS freightcost
FROM orders
WHERE freight > 100
GROUP BY orderyear,quarter

/*Day5,2.  GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5*/



/*Day 5, 3. Get all title designations across employees and customers ( Try UNION & UNION ALL)*/

SELECT title
FROM employees 
UNION
SELECT contacttitle
FROM customers

SELECT title
FROM employees 
UNION ALL
SELECT contacttitle
FROM customers

/*Day 4, 4.      Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)*/

SELECT * FROM products



/*Day 5,5.Find orders that have no discounted items (Display the  order_id, EXCEPT)*/


select  * from order_details where discount > 0

select  * from orders where discount <> 0

select  * from order_details where orderid = 10425



 
SELECT distinct orderid
FROM order_details
EXCEPT
SELECT distinct orderid
FROM order_details
WHERE discount = 0


SELECT distinct orderid
FROM orders
EXCEPT
SELECT distinct orderid
FROM order_details
WHERE discount > 0

SELECT * FROM orders


































	





































