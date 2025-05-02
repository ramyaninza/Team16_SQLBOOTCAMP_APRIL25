
/*INSERT into orders table:
Task: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50*/

SELECT * FROM orders
INSERT INTO public.orders(
	orderid, customerid, employeeid, orderdate, requireddate, shippeddate, shipperid, freight)
	VALUES (11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50);