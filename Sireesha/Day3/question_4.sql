/* Day3,(4) Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)*/

SELECT * FROM customers WHERE customerid = 'VINET'

ALTER TABLE orders DROP CONSTRAINT IF EXISTS orders_customerid_fkey

ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerID)
REFERENCES customers(customerID)
ON DELETE SET NULL;

DELETE FROM customers
WHERE customerID = 'VINET';

SELECT * FROM orders WHERE customerid = 'VINET'

SELECT * FROM orders WHERE customerID IS NULL;