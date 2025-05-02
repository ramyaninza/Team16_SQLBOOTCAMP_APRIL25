--1.Create view vw_updatable_products (use same query whatever I used in the training)
--Try updating view with below query and see if the product table also gets updated.
--Update query:
--UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;

-------------Understanding of CRATE VIEWS--------------
CREATE VIEW vw_product_sales_summary AS
SELECT
	P.product_name,
	C.category_name,
	SUM(OD.quantity) AS total_units_sold,
	SUM(OD.quantity * OD.unit_price) AS total_revenue
FROM products P
JOIN order_details OD ON P.product_id = OD.product_id
JOIN categories C ON P.category_id = C.category_id
GROUP BY P.product_name, C.category_name;
--------------------------------------------------------

CREATE VIEW vw_upatable_products AS
SELECT 
	product_id,
	product_name,
	unit_price,
	units_in_stock,
	discontinued 
FROM products
WHERE discontinued = 0
WITH CHECK OPTION;
	

SELECT * FROM vw_upatable_products WHERE units_in_stock < 10;

UPDATE vw_upatable_products
SET unit_price = unit_price * 1.1 
WHERE units_in_stock < 10;

SELECT product_id,unit_price,units_in_stock FROM products WHERE units_in_stock < 10;


--2.Transaction:
--Update the product price for products by 10% in category id=1
--Try COMMIT and ROLLBACK and observe what happens.


BEGIN; 
		UPDATE products
		SET unit_price = unit_price *1.10
		WHERE category_id = 1;

ROLLBACK;
		

SELECT 
	category_id,
	product_name,
	unit_price
FROM products 
WHERE category_id = 1
--3.Create a regular view which will have below details (Need to do joins):
--Employee_id,
--Employee_full_name,
--Title,
--Territory_id,
--territory_description,
--region_description

CREATE VIEW vw_employee_territory_region AS
SELECT 
	E.employee_id,
	E.first_name ||' '||E.last_name AS Employee_full_name,
	E.Title,
	ET.Territory_id,
	T.territory_description,
	R.region_description
FROM employees E 
	JOIN employee_territories ET
			ON E.employee_id = ET.employee_id
	JOIN territories T
			ON ET.territory_id = T.territory_id
	JOIN region R
			ON T.region_id = R.region_id;
 
--4.Create a recursive CTE based on Employee Hierarchy
WITH RECURSIVE cte_employeehierarchy AS (
  -- BASE Case : employee with no manager(top level)
SELECT
	employee_id,
	first_name,
	last_name,
	reports_to,
	0 AS LEVEL
FROM
	employees E
WHERE
	reports_to IS NULL

UNION ALL
--Recursive case: employees reporting to managers
SELECT
	E.employee_id,
	E.first_name,
	E.last_name,
	E.reports_to,
	EH.level+1
FROM
	employees E
JOIN
cte_employeehierarchy EH
ON
EH.employee_id = E.reports_to
)

SELECT
LEVEL,
employee_id,
first_name || ' ' || last_name AS employee_name
FROM
cte_employeehierarchy
ORDER BY 
LEVEL,employee_id;
