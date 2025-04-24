/*  9  Increase(Update)  the unit price of all products in category_id =2 by 10%.
(HINT: unit_price =unit_price * 1.10)*/

SELECT * FROM products

UPDATE products
SET unitprice = unitprice * 1.10
WHERE categoryid = 2;
