/*Filtering
●	 Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
●	List all employees who are located in the USA and have the title "Sales Representative".
●	Retrieve all products that are not discontinued and priced greater than 30.*/


/*Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15*/

select * from products;

select productid, productname, unitprice from products where unitprice > 15;


/* List all employees who are located in the USA and have the title "Sales Representative". */

select * from employees

select * from employees where country = 'USA' and title = 'Sales Representative'

/*Retrieve all products that are not discontinued and priced greater than 30.*/

select * from products


select * from products where discontinued = true and unitprice > 30



