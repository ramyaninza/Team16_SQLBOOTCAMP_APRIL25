/*Day4,1.     List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products
Output should have below columns:
companyname AS customer,
orderid,
productname,
quantity,
orderdate*/
SELECT
	C.COMPANYNAME AS CUSTOMERS,
	O.ORDERID,
	P.PRODUCTNAME,
	OD.QUANTITY,
	O.ORDERDATE
FROM
	CUSTOMERS C
	INNER JOIN ORDERS O ON C.CUSTOMERID = O.CUSTOMERID
	INNER JOIN ORDER_DETAILS OD ON O.ORDERID = OD.ORDERID
	INNER JOIN PRODUCTS P ON P.PRODUCTID = OD.PRODUCTID
	/* Day 4,2. Show each order with customer, employee, shipper, and product info — even if 
	some parts are missing. (Left Join)
	Tables used: orders, customers, employees, shippers, order_details, products*/
SELECT
	O.ORDERID,
	C.COMPANYNAME AS CUSTOMERS,
	E.EMPLOYEEID,
	S.SHIPPERID,
	OD.ORDERID,
	P.PRODUCTID
FROM
	ORDERS O
	LEFT JOIN CUSTOMERS C ON O.CUSTOMERID = C.CUSTOMERID
	LEFT JOIN EMPLOYEES E ON O.EMPLOYEEID = E.EMPLOYEEID
	LEFT JOIN SHIPPERS S ON O.SHIPPERID = S.SHIPPERID
	LEFT JOIN ORDER_DETAILS OD ON O.ORDERID = OD.ORDERID
	LEFT JOIN PRODUCTS P ON OD.PRODUCTID = P.PRODUCTID
	/* Day 4, 3. Show all order details and products (include all products even if they were 
	never ordered). (Right Join)
	Tables used: order_details, products
	Output should have below columns:
	orderid,
	productid,
	quantity,
	productname*/

SELECT
od.orderid,
od.productid,
p.productname,
od.quantity
FROM Order_details od
RIGHT JOIN products p ON p.productid = od.productid
/*Day 4, 4. List all product categories and their products — including categories that have 
no products, and products that are not assigned to any category.(Outer Join)
Tables used: categories, products*/
SELECT 
c.categoryid AS categories,
p.categoryid AS product,
c.categoryname,
c.description,
p.productname
FROM categories c
FULL OUTER JOIN products p ON p.categoryid = c.categoryid



/*Day 4, 5.Show all possible product and category combinations (Cross join).*/

SELECT p.productname,c.categoryname
FROM products p
CROSS JOIN categories c


/*Day 4,6. 	Show all employees and their manager(Self join(left join))*/

SELECT * FROM EMPLOYEES
SELECT
e1.employeename AS employeename,
e2.employeename AS managername
FROM employees e1
LEFT JOIN employees e2 ON e1.employeeid = e2.reportsto

/*Day 4, 7. 	List all customers who have not selected a shipping method.
Tables used: customers, orders
(Left Join, WHERE o.shipvia IS NULL)*/


select * from customers
SELECT c.companyName , c.contactName, c.contacttitle
FROM customers c 
LEFT JOIN orders o on c.customerid = o.customerid
where o.shipperid is null











 


 
 


 
















	