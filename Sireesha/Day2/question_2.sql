/* Querying (Select)*/
/*Retrieve the first name, last name, and title of all employees*/

SELECT * from employees
SELECT split_part("employeeName", ' ', 1) as firstname, split_part("employeeName", ' ', 2) as lastname, title from employees

/* Find all unique unit prices of products*/
SELECT * FROM products

SELECT distinct unitPrice FROM products;

/*	 List all customers sorted by company name in ascending order*/

SELECT * FROM customers 
ORDER BY companyName asc

/*	 Display product name and unit price, but rename the unit_price column as price_in_usd*/
select * from products
select productname, unitprice as price_in_usd from products
