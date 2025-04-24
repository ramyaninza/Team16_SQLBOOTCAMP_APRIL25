/*5)      LIMIT/FETCH
●	 Retrieve the first 10 orders from the orders table.
●	 Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).*/


/* Retrieve the first 10 orders from the orders table.*/

select * from orders fetch first 10 rows only


/*Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).*/

select * from orders LIMIT 10 OFFSET 10;