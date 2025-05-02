/*Day5,2.  GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5*/

 SELECT 
ship_region,
MIN(freight) AS Minfreight,
MAX(freight) AS MaxFreight
FROM orders 
WHERE ship_region IS NOT NULL
GROUP BY
ship_region

/*Day 4, 4.      Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)*/

SELECT category_id
FROM products
WHERE discontinued = 1

INTERSECT

SELECT category_id
FROM products
WHERE units_in_stock > 0;
SELECT * FROM categories









