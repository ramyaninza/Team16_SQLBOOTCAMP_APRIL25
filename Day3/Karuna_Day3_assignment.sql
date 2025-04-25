

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
