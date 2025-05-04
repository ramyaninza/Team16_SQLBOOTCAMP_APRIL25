/* 3)      Filtering */
/* ●	Get all customers from Germany.*/

select * from customers

select * from customers where country = 'Germany'

/* ●	Find all customers from France or Spain*/
select * from customers where country in ('France','Spain')

select distinct city from customers 

/* ●	Retrieve all orders placed in 1997 (based on order_date), and either */
/* have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date)) */
select * from orders

select * from orders where EXTRACT(YEAR FROM orderdate) = 1997 and freight > 50 and shippeddate is not null;

