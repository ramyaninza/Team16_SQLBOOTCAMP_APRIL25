/*Filtering
●	List all products whose category_id is not 1, 2, or 3.
●	Find customers whose company name starts with "A".*/


/*List all products whose category_id is not 1, 2, or 3.*/

select * from products where categoryid not in (1,2,3)

/*Find customers whose company name starts with "A".*/

select * from customers where companyname like 'A%'