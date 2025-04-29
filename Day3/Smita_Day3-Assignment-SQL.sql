Day 3

/*USE Northwind from Kaggle:*/

/*Update the categoryName From “Beverages” to "Drinks" in the categories table.*/

UPDATE categories
SET categoryname ='Drinks'
WHERE (categoryname='Beverages');

 
/*Insert into shipper new record (give any values) Delete that new record from shippers table*/
select * from shippers;

insert into shippers(shipperid,companyname)values(4,'Speedy Express');
insert into shippers(shipperid,companyname)values(5,'United Package');

DELETE FROM shippers
WHERE (Shipperid=4);
 
/*
Update categoryID=1 to categoryID=1001. 
Delete the categoryID= “3”  from categories. 

Make sure related products update their categoryID too. 
Display the both category and products table to show the cascade
Verify that the corresponding records are deleted automatically from products.
(HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)
 */

select * from categories where  categoryID IN (1,3,1001);
select * from products where categoryID IN (1,3,1001);

ALTER TABLE products
ADD CONSTRAINT fk_Product_categories
FOREIGN KEY (categoryid)
REFERENCES Categories(categoryid)
ON UPDATE DELETE
ON DELETE CASCADE;
 
UPDATE Categories SET categoryid =1001 WHERE (categoryid=1); 
Delete categories where categoryID=3;

select * from categories where  categoryID IN (1,3,1001);
select * from products where categoryID IN (1,3,1001);


 
/*
Delete the customer = “VINET”  from customers. 
Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
*/
select * from customers where customerID ='VINET';
select * from orders where customerID ='VINET';

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customerID)
REFERENCES customers(customerID)
ON DELETE SET NULL;
 

Delete from customers where customerID ='VINET';

select * from customers where customerID ='VINET';
select * from orders where customerID ='VINET';

 
 
/*Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
(this should update the quantityperunit for product_id = 100)*/

INSERT INTO Products(Productid,productname,quantityperunit,unit_price,discontinued,categoryid)
                      VALUES (100,'White bread','1',13,0,3 )

INSERT INTO Products(Productid,productname,quantityperunit,unit_price,discontinued,categoryid)
                      VALUES (101,'White bread','5',13,0,3 )
INSERT INTO Products(Productid,productname,quantityperunit,unit_price,discontinued,categoryid)
                      VALUES (100,'White bread','10',13,0,3 )
ON CONFLICT(Productid)
DO UPDATE 
SET productname= EXCLUDED.productname, 
    quantityperunit= EXCLUDED.quantityperunit,
	unit_price=EXCLUDED.unit_price,
	discontinued=EXCLUDED.discontinued,
	categoryid=EXCLUDED.categoryid;
	
	
/*Write a MERGE query:
Create temp table with name:  ‘updated_products’ and insert values as below:
 
productID
productName
quantityPerUnit
unitPrice
discontinued
categoryID
                     	100
Wheat bread
10
20
1
3
101
White bread
5 boxes
19.99
0
3
102
Midnight Mango Fizz
24 - 12 oz bottles
19
0
1
103
Savory Fire Sauce
12 - 550 ml bottles
10
0
2
*/

Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 

If there are matching products and updated_products .discontinued =1 then delete 
 
 Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.*/

merge into product p
using( 
values(100,Wheat bread,10,20,1,3)
values(101,Wheat bread,5,19.99,0,3)
values(102,Midnight Mango Fizz,24 - 12,19,0,1)
values(103,Savory Fire Sauce,12 - 550 ,10,0,2)
)AS incoming(productID,productName,quantityPerUnit,unitPrice,discontinued,categoryID)
on p.Productid=incoming.Productid)
when matched AND incoming.discontinued=1 THEN
Delete
when matched AND incoming.discontinued=0 THEN
Update SET
productName=incoming.productName
unitprice=incoming.unitPrice
when not matched incoming.discontinued= 0 THEN
INSERT(productID,productName,quantityPerUnit,unitPrice,discontinued,categoryID)
values (incoming.productID,incoming.productName,incoming.quantityPerUnit,incoming.unitPrice,incoming.discontinued,incoming.categoryID)




/* 
USE NEW Northwind DB:
List all orders with employee full names. (Inner join)
*/

 SELECT CONCAT (EMP. first_name, EMP. Last_name) AS name,
ORD. employee_id, ORD. order_id, ORD. customer_id, ORD.order_date, ORD. required_date, ORD. shipped_date, ORD. ship_via, ORD. freight
FROM orders ORD, employees EMP where ORD. employee_id = EMP. employee_id;
