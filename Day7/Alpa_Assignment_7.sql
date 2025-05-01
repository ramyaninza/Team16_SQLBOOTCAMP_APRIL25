--1.Rank employees by their total sales
--(Total sales = Total no of orders handled, JOIN employees and orders table)
---Example Of Rank-------------------
SELECT 
	category_id,
	product_name,
	unit_price,
	RANK() OVER(
		PARTITION BY category_id
		ORDER BY unit_price DESC
		) AS Price_Rank
FROM
	products
WHERE 
	discontinued = 0
ORDER BY 
	category_id,
	Price_Rank;
----------------------------------------------

SELECT
	E.employee_id,
	COUNT(O.order_id) AS Total_orders,
	RANK() OVER(
			ORDER BY COUNT(O.order_id) DESC
			) AS Total_Sales_Rank
FROM employees E
JOIN orders O
	ON E.employee_id = O.employee_id
GROUP BY
	E.employee_id
ORDER BY 
	Total_Sales_Rank;


 
--2.Compare current order's freight with previous and next order for each customer.
--(Display order_id,  customer_id,  order_date,  freight,
--Use lead(freight) and lag(freight).

SELECT
	order_id,
	customer_id, 
	order_date,
	freight,
LAG(freight) OVER(PARTITION BY customer_id ORDER BY order_date) AS Previous_Freight,
LEAD(freight) OVER(PARTITION BY customer_id ORDER BY order_date) AS Next_Freight
FROM
orders
ORDER BY
	customer_id,
	order_date;



 
--3.Show products and their price categories, product count in each category, avg price:
-- (HINT:Create a CTE which should have price_category definition:
-- WHEN unit_price < 20 THEN 'Low Price' 	
--WHEN unit_price < 50 THEN 'Medium Price'       	
-- ELSE 'High Price'           
--In the main query display: price_category,  product_count in each price_category,  
--ROUND(AVG(unit_price)::numeric, 2) as avg_price)            

WITH CTE_Price_Category AS
(SELECT 
	product_id,
	unit_price,
	CASE WHEN unit_price < 20 THEN 'Low Price'
		 WHEN unit_price < 50 THEN 'Medium Price'
		 ELSE 'High Price'
	END AS Price_Category
FROM order_details)

SELECT 
	Price_Category,
	COUNT(product_id),
	ROUND(AVG(unit_price)::numeric, 2) AS Avg_Price
FROM CTE_Price_Category
GROUP BY Price_Category
ORDER BY COUNT(product_id) DESC;
	
