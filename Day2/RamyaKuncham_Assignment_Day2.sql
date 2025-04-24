select * from employees
Alter table employees
add column  linkedin_profile varchar(60);

Alter table employees
Alter column linkedin_profile type TEXT;

Alter table employees
Alter column linkedin_profile set not null,
ADD CONSTRAINT unique_linkedin_profile unique(linkedin_profile);

UPDATE employees
SET linkedin_profile = 'not_provided'
WHERE linkedin_profile IS NULL;

SELECT linkedin_profile, COUNT(*)
FROM employees
GROUP BY linkedin_profile
HAVING COUNT(*) > 1;

SELECT * FROM employees WHERE linkedin_profile = 'not_provided';
WITH duplicates AS (
  SELECT employeeid,
         ROW_NUMBER() OVER (PARTITION BY linkedin_profile ORDER BY employeeid) AS rn
  FROM employees
  WHERE linkedin_profile = 'not_provided'
)
UPDATE employees
SET linkedin_profile = 'not_provided_' || rn
FROM duplicates
WHERE employees.employeeid = duplicates.employeeid;
SELECT linkedin_profile FROM employees WHERE linkedin_profile LIKE 'not_provided%';
ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL,
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);
ALTER TABLE employees
DROP COLUMN linkedin_profile;

-- Querying (Select)
Select employeename,title
from employees;

select * from products
select distinct unitprice
from products;
select * from customers
order by companyname asc;
select productname,unitprice 
as price_in_usd 
from  products;
-- Filtering
select * from customers
where country ='Germany';
select * from customers
where country ='France' or country ='Spain';
select * from orders1
where extract (year from orderdate) = 1997 
and (freight > 50 or shippeddate is not  null) ;

select productid , productname ,unitprice from products
where unitprice > 15; 



)

select * from employees 
where country = 'USA' and title = 'Sales Representative';

select * from products
where discontinued = false and unitprice > 30;

--LIMIT/FETCH
select * from orders1
order by orderdate
limit 10;

SELECT *
FROM orders1
ORDER BY orderid
OFFSET 10
LIMIT 10;

SELECT *
FROM customers
WHERE contacttitle IN ('Sales Representative', 'Owner');

SELECT *
FROM orders1
Where orderdate Between  '2013-01-01' AND '2013-12-31';

SELECT *
FROM products
WHERE categoryid NOT IN (1, 2, 3);

SELECT *
FROM customers
WHERE companyname LIKE 'A%';

ALTER TABLE employees
DROP COLUMN linkedin_profile;

INSERT into orders1 (OrderID,CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,shipperID,Freight)
Values (11078,'ALFKI',5,'2025-04-23', '2025-04-30','2025-04-25',2,45.50);

UPDATE products
SET unitprice = unitprice * 1.10
WHERE categoryid = 2;

SELECT productname, unitprice
FROM products
WHERE categoryid = 2;


