----------------------- Day1 ----------------------------------

-- table for categories
create table categories (
    categoryID INT PRIMARY KEY, 
    categoryName VARCHAR(100) NOT NULL,   
    description TEXT         
);

/*

INT - The value should be a number 
PRIMARY KEY - categoryID is a unique identifier,a primary key is used when there is a unique identifier
NOT NULL is to specift that NULL values are not allowed in this column

*/



-- table for customers
create table customers (
    customerID VARCHAR(10) PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL,
    contactName VARCHAR(100),
    contactTitle VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);



--  table for employees

create table employees (
    employeeID INT PRIMARY KEY,
    employeeName VARCHAR(100) NOT NULL,
    title VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    reportsTo INT,
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
);

/*

Foreign Key - foreign key is used to represent manager of an employee. The link is within the employees table like a self join.

*/



-- table for products

create table products (
    productID INT PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    quantityPerUnit VARCHAR(50),
    unitPrice DECIMAL(10, 2),
    discontinued BOOLEAN,
    categoryID INT,
    FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

/*

Foreign Key - The categoryID which is a primary key in categories table  .
Each product belongs to a category that is already in category table
*/




-- table for shippers

create table shippers (
    shipperID INT PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL
);



-- table for orders

create table orders (
    orderID INT PRIMARY KEY,
    customerID VARCHAR(10),
    employeeID INT,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    shipperID INT,
    freight DECIMAL(10, 2),
	FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
    FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);




--table for Order_details
create table order_details (
    orderID INT,
    productID INT,
    unitPrice DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(10, 2),
	FOREIGN KEY (orderID) REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);

select * from order_details ;
select * from categories;
select * from customers;
select * from orders;
select * from employees;
select * from products;
select * from shippers;


---------------------------------------  DAY2 ------------------------------------------------

--- 1. Alter Table

/* Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar */

ALTER TABLE employees
ADD COLUMN linkedin_profile VARCHAR(100);

select * from employees;

/* Change the linkedin_profile column data type from VARCHAR to TEXT */

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT;


/* Add unique, not null constraint to linkedin_profile */

 -- Updating linkedin_profile values to some value as it cannot be set to NOT NULL if it has NULL
 -- Values


UPDATE employees SET linkedin_profile = 'https://linkedin.com/' || '-' || employeeid 
WHERE linkedin_profile IS NOT NULL;

SELECT * FROM employees;

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL,
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);


/* Drop column linkedin_profile */

ALTER TABLE employees
DROP COLUMN linkedin_profile;


SELECT * FROM employees;


/* 2)      Querying (Select) */

/* Retrieve the first name, last name, and title of all employees */

select employeename,title from employees;

/* Find all unique unit prices of products */

select * from products;

select DISTINCT unitprice from products;

/*  List all customers sorted by company name in ascending order */

select * from customers;

select customerid,contactname,companyname
from customers
order by companyname asc;

/* Display product name and unit price, but rename the unit_price column as price_in_usd */
 select productname,unitprice as price_in_usd
 from products;


 ---- 3. Filtering ----

 /* Get all customers from Germany. */

 select customerid 
 from customers
 where country = 'Germany';

 /* Find all customers from France or Spain */

 select customerid 
 from customers
 where country IN ('Spain','France');

 /* Retrieve all orders placed in 2014 (based on order_date), 
 and either have freight greater than 50 or the shipped 
 date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date)) */

 select * from orders;

 select orderid 
 from orders
 where EXTRACT(YEAR FROM orderdate) = 2014 AND
 (freight>50 OR shippeddate is NOT NULL);


 ----------- 4)      Filtering ------------------

 /* Retrieve the product_id, product_name, 
 and unit_price of products where the unit_price is greater than 15. */

 select * from products;

 select productid,productname
 from products where unitprice>15;

 /*List all employees who are located in the USA and have the title 
 "Sales Representative".*/

select * from employees; 

select employeename
from employees
where country = 'USA' AND title = 'Sales Representative';

/*•	Retrieve all products that are not discontinued and priced greater than 30.*/

select productname 
from products
where discontinued = 'false' AND unitprice>30;


------- 5) LIMIT/FETCH -------------

/* Retrieve the first 10 orders from the orders table. */
select * 
from orders
limit 10;


/* Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).*/
select * 
from orders
limit 10
offset 10;


--------------- 6)      Filtering (IN, BETWEEN) -----------------

/* •	List all customers who are either Sales Representative, Owner */

select customerid,contactname 
from customers
where contacttitle IN ('Sales Representative','Owner');

/* •	Retrieve orders placed between January 1, 2013, and December 31, 2013.*/

select * from orders ;

select * 
from orders
where orderdate BETWEEN '2013-01-01' AND '2013-12-31';


----------- 7)      Filtering ------------------

/* •	List all products whose category_id is not 1, 2, or 3. */

select * from products;

select categoryid,productname 
from products
where categoryid NOT IN ('1','2','3')
order by categoryid asc;

/* •	Find customers whose company name starts with "A".*/

select * from customers;

select contactname,companyname
from customers
where companyname LIKE 'A%';


/* 8)       INSERT into orders table:

 Task: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50

*/

select * from orders;

INSERT INTO orders (orderid, customerid, employeeid, orderdate, requireddate, shippeddate,
shipperid,freight)
values(11078, 'ALFKI', 5, '2025-04-23', 
  '2025-04-30', '2025-04-25', 2, 45.50);

select * from orders where orderid = 11078;



/* 9)      Increase(Update)  the unit price of all products in category_id =2 by 10%.
(HINT: unit_price =unit_price * 1.10)
*/

select * from products;


update products
set unitprice = unitprice*1.10;


/*

10) Sample Northwind database:
Download
 Download northwind.sql from below link into your local. 
 Sign in to Git first https://github.com/pthom/northwind_psql
 Manually Create the database using pgAdmin:
 Right-click on "Databases" → Create → Database
Give name as ‘northwind’ (all small letters)
Click ‘Save’

Import database:
 Open pgAdmin and connect to your server          	
  Select the database  ‘northwind’
  Right Click-> Query tool.
  Click the folder icon to open your northwind.sql file
 Press F5 or click the Execute button.
  You will see total 14 tables loaded
  Databases → your database → Schemas → public → Tables

*/




----------------------------- DAY3 --------------

/* 1)      Update the categoryName From “Beverages” to "Drinks" in the categories table. */

select * from categories;

SELECT * FROM categories WHERE categoryname = 'Beverages';

UPDATE categories
SET categoryname = 'Drinks'
WHERE categoryname = 'Beverages';

SELECT * FROM categories WHERE categoryname = 'Drinks';


/* 2)      Insert into shipper new record (give any values) 
Delete that new record from shippers table.*/

select * from shippers;

Insert into shippers (shipperid,companyname)
values (4,'Garudawega');

delete from shippers where shipperid =4;


/* 3)      Update categoryID=1 to categoryID=1001. 
Make sure related products update their categoryID too. 
Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. 
 Verify that the corresponding records are deleted automatically from products.
 (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, 
 ON DELETE CASCADE, add ON DELETE CASCADE for order_details(productid) ) */

 ---- Step 1 -----
 

-- Delete foreign key on products table

ALter table products
drop constraint if exists products_categoryid_fkey;


--- step 2 ----


-- Now add constraint with ondelete update and on delete cascade

alter table products
add constraint products_categoryid_fkey
foreign key (categoryid)
references categories(categoryid)
on update cascade
on delete cascade;

----- step 3 -----

-- Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too

update categories
set categoryID = 1001
where categoryID = 1;

select * from categories;

select * from products where categoryID = 1001;


------- step 4 -------
 --Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted 
 --automatically from products.

 /* Since categoryid is referenced by product table and productid in product table  to order_details table 
 we need to alter order_details table drop constarint and set cascade */

 alter table order_details
 drop constraint if exists order_details_productid_fkey;

alter table order_details
add constraint order_details_productid_fkey
foreign key (productid)
references products(productid)
on update cascade
on delete cascade;

--- step 5 ----
 --Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted 
 --automatically from products.

 delete from categories where categoryID = 3;

 select * from categories where categoryID = 3;

 select * from products where categoryID = 3;


/* 4)      Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)*/

--- step 1 ----
-- drop foreign key constraint from orders table and cascade

alter table orders
drop constraint orders_customerid_fkey;

--- ste 2 ---
/* On delete set null */
ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerid)
REFERENCES customers(customerid)
ON DELETE SET NULL;

--delete the record with customerid = 'VINET' in customers table
DELETE FROM customers WHERE customerid = 'VINET';

-- Verify in orders table
SELECT * FROM orders WHERE customerid IS NULL;

/* 5)      Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100)
*/

INSERT INTO products (productid, productname, quantityperunit, unitprice, discontinued, categoryID)
VALUES 
    (100, 'Wheat bread', '1', 13, FALSE, 5),
    (101, 'White bread', '5 boxes', 13, FALSE, 5),
    (100, 'Wheat bread', '10 boxes', 13, FALSE, 5)
ON CONFLICT (productid) 
DO UPDATE 
SET 
    productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryID = EXCLUDED.categoryID;


-- First insert (product_id = 100)
INSERT INTO products (productid, productname, quantityperunit, unitprice, discontinued, categoryID)
VALUES 
    (100, 'Wheat bread', '1', 13, FALSE, 5)
ON CONFLICT (productid) 
DO UPDATE 
SET 
    productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryID = EXCLUDED.categoryID;

-- Second insert (productid = 101)
INSERT INTO products (productid, productname, quantityperunit, unitprice, discontinued, categoryID)
VALUES 
    (101, 'White bread', '5 boxes', 13, FALSE, 5)
ON CONFLICT (productid) 
DO UPDATE 
SET 
    productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryID = EXCLUDED.categoryID;

-- Now update productid = 100 with new quantityperunit '10 boxes'
INSERT INTO products (productid, productname, quantityperunit, unitprice, discontinued, categoryID)
VALUES 
    (100, 'Wheat bread', '10 boxes', 13, FALSE, 5)
ON CONFLICT (productid) 
DO UPDATE 
SET 
    productname = EXCLUDED.productname,
    quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryID = EXCLUDED.categoryID;





----------Q5 --------

CREATE TEMP TABLE updated_products (
    productid INT,
    productname TEXT,
    quantityperunit TEXT,
    unitprice NUMERIC,
    discontinued BOOLEAN,
    categoryid INT
);

INSERT INTO updated_products (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES
(100, 'Wheat bread', '10', 20, 'TRUE', 3),
(101, 'White bread', '5 boxes', 19.99, 'FALSE', 3),
(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 'FALSE', 1001),
(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 'FALSE', 2);

DELETE FROM updated_products;
SELECT * FROM updated_products;
SELECT * FROM categories;

-- Step 2: 
MERGE INTO products p
USING updated_products u
ON p.productid = u.productid
WHEN MATCHED AND u.discontinued = 'FALSE' THEN
UPDATE SET 
        unitprice = u.unitprice,
        discontinued = u.discontinued
WHEN MATCHED AND u.discontinued = 'TRUE' THEN
DELETE
WHEN NOT MATCHED AND u.discontinued = 'FALSE' THEN
INSERT (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (u.productid, u.productname, u.quantityperunit, u.unitprice, u.discontinued, u.categoryid);

SELECT * FROM products;
