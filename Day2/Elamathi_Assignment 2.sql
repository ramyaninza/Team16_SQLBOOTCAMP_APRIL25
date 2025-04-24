-- 1. Alter Table 

	-- a. Add a new column 'linkedin_profile' to 'employees' table
	ALTER TABLE employees
	ADD COLUMN linkedin_profile VARCHAR(100);

	Select * from employees

	-- b. Change the column type from VARCHAR to TEXT and Add UNIQUE constraints
	ALTER TABLE employees
	ALTER COLUMN linkedin_profile TYPE TEXT,
	ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);

	-- c. Add NOT NULL constraints
	--First update with values since cannot set "NOT NULL " to the column which is already having null upon creation
	UPDATE employees
	SET linkedin_profile = CONCAT('N/A_', employeeid)
	WHERE linkedin_profile IS NULL;
	-- Then Alter the column with NOT NULL constraint
	ALTER TABLE employees
	ALTER COLUMN linkedin_profile SET NOT NULL;

	Select * from employees

	-- d. Drop the 'linkedin_profile' column
	ALTER TABLE employees
	DROP COLUMN linkedin_profile;
-- ..................................................................................................................................................................

-- 2. Querying (Select)

	--a. Retrieve first name, last name, title of all employees
	
	SELECT
  	employeename,
  	SPLIT_PART(employeename, ' ', 1) AS first_name,
 	SPLIT_PART(employeename, ' ', 2) AS last_name,
	 title
	FROM employees;

	--b. Find all unique unit prices of products
	SELECT DISTINCT unitprice FROM products ORDER BY unitprice DESC;

	-- c. List all customers sorted by company name in ascending order
	SELECT * FROM customers ORDER BY companyname ASC;

	--d. Display product name and unit price, but rename the unit_price column as price_in_usd
	SELECT productname, unitprice AS price_in_usd FROM products;

-- .................................................................................................................................................................
-- 3. Filtering

	--a. Get all customers from Germany.
	SELECT * FROM customers WHERE country = 'Germany';

	--b. Find all customers from France or Spain
	SELECT * FROM customers
	WHERE country = 'France' OR country = 'Spain';

	--c. Retrieve all orders placed in 1997 and either have freight greater than 50 or the shipped date available (i.e., non-NULL)
	SELECT * FROM orders
	WHERE EXTRACT(YEAR FROM orderdate) = 1997 AND (freight > 50 OR shippeddate IS NOT NULL);

--...................................................................................................................................................................
-- 4. Filtering

	-- a.  Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
	SELECT productid, productname, unitprice FROM products WHERE unitprice > 15;

	--b. List all employees who are located in the USA and have the title "Sales Representative".
	SELECT * FROM employees WHERE country = 'USA' AND title = 'Sales Representative';
	SELECT employeename FROM employees WHERE country = 'USA' AND title = 'Sales Representative';

	--c. Retrieve all products that are not discontinued and priced greater than 30.
	SELECT productid, productname, unitprice FROM products
	WHERE unitprice > 30 AND discontinued = FALSE;

--....................................................................................................................................................................
--5. LIMIT/FETCH
 
	--a. Retrieve the first 10 orders from the orders table.
	SELECT * FROM orders LIMIT 10;

	--b. Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
	SELECT * FROM orders LIMIT 10 OFFSET 10;

--.................................................................................................................................................................
-- 6. Filtering (IN, BETWEEN)

	--a. List all customers who are either Sales Representative, Owner
	SELECT * FROM customers
	WHERE contacttitle IN ('Sales Representative', 'Owner');

	-- b. Retrieve orders placed between January 1, 2013, and December 31, 2013.
	SELECT * FROM orders
	WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31';

--..................................................................................................................................................................
-- 7 . Filtering

	-- a.  List all products whose category_id is not 1, 2, or 3.
	SELECT * FROM products
	WHERE categoryid NOT IN (1, 2, 3);

	-- b. Find customers whose company name starts with "A".
	SELECT * FROM customers
	WHERE companyname LIKE 'A%';

--..................................................................................................................................................................
-- 8. INSERT into orders table:

	INSERT INTO orders (orderid, customerid, employeeid, orderdate, requireddate, shippeddate, shipperid, freight)
	VALUES (
    11078,
    'ALFKI',
    5,
    '2025-04-23',
    '2025-04-30',
    '2025-04-25',
    2,
    45.50
	);

	SELECT * FROM orders WHERE orderid = 11078;

--...................................................................................................................................................................
-- 9. Increase(Update)  the unit price of all products in category_id =2 by 10%.
	UPDATE products
	SET unitprice = unitprice * 1.10
	WHERE categoryid = 2;








