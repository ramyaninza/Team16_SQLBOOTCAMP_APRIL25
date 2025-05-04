
/* 6)      Filtering (IN, BETWEEN)
●	List all customers who are either Sales Representative, Owner
●	Retrieve orders placed between January 1, 2013, and December 31, 2013. */


/*List all customers who are either Sales Representative, Owner*/

select * from customers where contacttitle in ('Sales Representative','Owner');


/*Retrieve orders placed between January 1, 2013, and December 31, 2013. */*/

select * from orders where orderdate between '2013-01-01' and '2013-12-31'