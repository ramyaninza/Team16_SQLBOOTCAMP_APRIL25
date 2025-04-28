-- Update the categoryName From “Beverages” to "Drinks" in the categories table.

SELECT * From categories
WHERE categoryname = 'Beverages';

UPDATE categories
SET categoryname = 'Drinks'
WHERE categoryname = 'Beverages';

-- Insert into shipper new record (give any values) Delete that new record from shippers table.

SELECT * FROM shippers;

INSERT INTO shippers(shipperid,companyname)
VALUES (4,'Fedex shipping');

DELETE FROM shippers
WHERE shipperid = 4;

-- Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
--Display the both category and products table to show the cascade.
-- Delete the categoryID= “3”  from categories. -
--Verify that the corresponding records are deleted automatically from products
-- (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)

ALTER TABLE products
DROP CONSTRAINT IF EXISTS fk_customer;

ALTER TABLE products
ADD CONSTRAINT fk_customer
FOREIGN KEY (categoryid) REFERENCES categories(categoryid)
ON UPDATE CASCADE
ON DELETE CASCADE;

UPDATE categories
SET categoryid = 1001
WHERE categoryid = 1;

SELECT * FROM categories;
SELECT * FROM products
WHERE categoryid = 1001 ;

ALTER TABLE order_details
DROP CONSTRAINT IF EXISTS order_details_productid_fkey;

ALTER TABLE order_details
ADD CONSTRAINT order_details_productid_fkey
FOREIGN KEY (productid) REFERENCES products(productid)
ON DELETE SET NULL;

DELETE FROM categories
WHERE categoryid = 3;

-- Delete the customer = “VINET”  from customers. 
--Corresponding customers in orders table should be set to null 
--(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)

ALTER TABLE orders
DROP CONSTRAINT IF EXISTS orders_customerid_fkey;

ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerid) REFERENCES customers(customerid)
ON DELETE SET NULL;

DELETE FROM customers
WHERE customerid = 'VINET';

SELECT * FROM orders
WHERE customerid = 'VINET';


-- Insert the following data to Products using UPSERT:
--product_id = 100, product_name = Wheat bread,     
--      quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
--product_id = 101, product_name = White bread, 
--      quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
--product_id = 100, product_name = Wheat bread, 
--      quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
--(this should update the quantityperunit for product_id = 100)

INSERT INTO products
	(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (100,'Wheat bread',1,13,0,5),
	   (101,'White bread',5,13,0,5)
ON CONFLICT (productid)
DO UPDATE 
SET productname = EXCLUDED.productname,
	quantityperunit = EXCLUDED.quantityperunit,
	unitprice = EXCLUDED.unitprice,
	discontinued = EXCLUDED.discontinued,
	categoryid = EXCLUDED.categoryid;


SELECT * FROM products
WHERE productid IN (100,101);

INSERT INTO products
	(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (100,'Wheat bread',10,13,0,5)
ON CONFLICT (productid)
DO UPDATE 
SET productname = EXCLUDED.productname,
	quantityperunit = EXCLUDED.quantityperunit,
	unitprice = EXCLUDED.unitprice,
	discontinued = EXCLUDED.discontinued,
	categoryid = EXCLUDED.categoryid;

SELECT * FROM products
WHERE productid = 100;

-- Write a MERGE query:
--Create temp table with name:  ‘updated_products’ and insert values as below:
--Update the price and discontinued status for from below table ‘updated_products’ only 
--if there are matching products and updated_products .discontinued =0 
--If there are matching products and updated_products .discontinued =1 then delete 
--Insert any new products from updated_products that don’t exist in products only 
--if updated_products .discontinued =0.
SELECT * FROM products WHERE productid IN (100,101,102,103)
CREATE TEMP TABLE updated_products
(productID INT,
productName TEXT,
quantityPerUnit VARCHAR(50),
unitPrice NUMERIC,
discontinued INT,
categoryID INT);

DROP TABLE updated_products

SELECT * FROM products WHERE productid IN (100,101,102,103)

INSERT INTO updated_products(productID,productName,quantityPerUnit,unitPrice,discontinued,categoryID)
VALUES (100,'Wheat bread',10,20,1,3),
	   (101,'White bread','5 boxes',19.99,0,3),
	   (102,'Midnight Mango Fizz','24-12 oz bottles',19,0,1001),
	   (103,'Savory Fire Sauce','12-550 ml bottles',10,0,2)
	   
MERGE INTO products P
USING updated_products AS UP
ON P.productid = UP.productID
WHEN MATCHED AND UP.discontinued = 1 THEN 
     DELETE
WHEN MATCHED AND UP.discontinued = 0 THEN
	 UPDATE SET 
	 	productName = UP.productName,
		quantityPerUnit = UP.quantityPerUnit,
		unitPrice = UP.unitPrice,
		categoryID = UP.categoryID
WHEN NOT MATCHED AND UP.discontinued = 0 THEN
	INSERT(productID,productName,quantityPerUnit,unitPrice,discontinued,categoryID)
	VALUES(UP.productID,UP.productName,UP.quantityPerUnit,UP.unitPrice,UP.discontinued,UP.categoryID)
