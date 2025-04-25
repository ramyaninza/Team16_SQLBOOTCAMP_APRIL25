UPDATE categories
SET categoryname = 'Drinks'
WHERE categoryname = 'Beverages';

INSERT INTO shippers (ShipperID, companyName)
VALUES (4 , 'UnitedPostal');
DELETE FROM shippers
WHERE ShipperID = 4 AND companyName = 'UnitedPostal';

ALTER TABLE categories
ADD CONSTRAINT categories_pk PRIMARY KEY (categoryID);

ALTER TABLE products
ADD CONSTRAINT fk_category
FOREIGN KEY (categoryID)
REFERENCES categories(categoryID)
ON UPDATE CASCADE;

UPDATE categories
SET categoryID = 1001
WHERE categoryID = 1;

SELECT * FROM categories WHERE categoryID = 1001;

SELECT * FROM products WHERE categoryID = 1001;

ALTER TABLE categories
ADD CONSTRAINT categories_pk PRIMARY KEY (categoryID);

ALTER TABLE products
DROP CONSTRAINT fk_categories;

DELETE from categories
WHERE categoryID=3;

SELECT conname
FROM pg_constraint
WHERE conrelid = 'products'::regclass
  AND contype = 'f';

  ALTER TABLE products
DROP CONSTRAINT fk_category;

ALTER TABLE products
ADD CONSTRAINT fk_category
FOREIGN KEY (categoryID)
REFERENCES categories(categoryID)
ON UPDATE CASCADE
ON DELETE CASCADE;

DELETE FROM categories
WHERE categoryID = 3;

SELECT * FROM products
WHERE categoryID = 3;

ALTER TABLE orders1
DROP CONSTRAINT IF EXISTS fk_customer;

ALTER TABLE orders1
DROP CONSTRAINT fk_orders_customers;

ALTER TABLE orders1
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customerID)
REFERENCES customers(customerID)
ON DELETE SET NULL;

DELETE FROM customers
WHERE customerID = 'VINET';

SELECT * FROM orders1
WHERE customerID IS NULL;

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
	
CREATE Temporary TABLE updated_products(
productID INT,
productName VARCHAR(100),
quantityPerUnit VARCHAR(60),
unitPrice DECIMAL,
discontinued INT,
categoryID INT
);
INSERT INTO updated_products (productid, productname, quantityperunit, unitprice, discontinued, categoryID)
VALUES 
    (100, 'Wheat bread', '10', 20 , 1, 5),
    (101, 'White bread', '5 boxes', 19.99, 0, 5),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);
SELECT * FROM updated_products;



UPDATE products
SET
    unitprice = u.unitprice,              
    discontinued = (u.discontinued = 0) ::boolean          
FROM updated_products u
WHERE products.productid = u.productid          
  AND u.discontinued = 0;                       


DELETE FROM products
WHERE productid IN (
    SELECT u.productid
    FROM updated_products u
    WHERE u.discontinued = 1
    AND products.productid = u.productid
);
INSERT INTO products (productid, productname, quantityperunit, unitprice, discontinued, categoryID)
SELECT u.productid, u.productname, u.quantityperunit, u.unitprice, (u.discontinued = 0)::boolean, u.categoryID
FROM updated_products u
WHERE u.discontinued = 0
  AND NOT EXISTS (
      SELECT 1 FROM products p WHERE p.productid = u.productid
  );

SELECT * FROM categories;

INSERT INTO categories (categoryID, categoryName)
VALUES (1, 'Example Category');
INSERT INTO products (productid, productname, quantityperunit, unitprice, discontinued, categoryID)
SELECT u.productid, u.productname, u.quantityperunit, u.unitprice, (u.discontinued = 0)::boolean, u.categoryID
FROM updated_products u
WHERE u.discontinued = 0
  AND NOT EXISTS (
      SELECT 1 FROM products p WHERE p.productid = u.productid
  );

  SELECT u.productid, u.productname, u.categoryID
FROM updated_products u
LEFT JOIN categories c ON u.categoryID = c.categoryID
WHERE c.categoryID IS NULL;
SELECT DISTINCT categoryID FROM updated_products;

SELECT categoryID FROM categories;

SELECT DISTINCT u.categoryID
FROM updated_products u
LEFT JOIN categories c ON u.categoryID = c.categoryID
WHERE c.categoryID IS NULL;

INSERT INTO categories (categoryID, categoryName)
VALUES (5, 'New Category 5'), 
       (2, 'New Category 2'), 
       (1, 'New Category 1');
SELECT DISTINCT u.categoryID
FROM updated_products u
LEFT JOIN categories c ON u.categoryID = c.categoryID
WHERE c.categoryID IS NULL;

INSERT INTO products (productid, productname, quantityperunit, unitprice, discontinued, categoryID)
SELECT u.productid, u.productname, u.quantityperunit, u.unitprice, (u.discontinued = 0)::boolean, u.categoryID
FROM updated_products u
WHERE u.discontinued = 0
  AND NOT EXISTS (
      SELECT 1 FROM products p WHERE p.productid = u.productid
  );

