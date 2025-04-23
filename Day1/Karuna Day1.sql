-- table for categories
create table categories (
    categoryID INT PRIMARY KEY, 
    categoryName VARCHAR(100) NOT NULL,   
    description TEXT         
);

/*

INT - The value should be a number 
PRIMARY KEY - categoryID is a unique identifier,a primary key is used when there is a unique identifier
NOT NULL is to specift that NULL values are not allowed in this column

*/



-- table for customers
create table customers (
    customerID VARCHAR(10) PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL,
    contactName VARCHAR(100),
    contactTitle VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);



--  table for employees

create table employees (
    employeeID INT PRIMARY KEY,
    employeeName VARCHAR(100) NOT NULL,
    title VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    reportsTo INT,
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
);

/*

Foreign Key - foreign key is used to represent manager of an employee. The link is within the employees table like a self join.

*/



-- table for products

create table products (
    productID INT PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    quantityPerUnit VARCHAR(50),
    unitPrice DECIMAL(10, 2),
    discontinued BOOLEAN,
    categoryID INT,
    FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

/*

Foreign Key - The categoryID which is a primary key in categories table  .
Each product belongs to a category that is already in category table
*/




-- table for shippers

create table shippers (
    shipperID INT PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL
);



-- table for orders

create table orders (
    orderID INT PRIMARY KEY,
    customerID VARCHAR(10),
    employeeID INT,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    shipperID INT,
    freight DECIMAL(10, 2),
	FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
    FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);




--table for Order_details
create table order_details (
    orderID INT,
    productID INT,
    unitPrice DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(10, 2),
	FOREIGN KEY (orderID) REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);

select * from order_details ;
select * from categories;
select * from customers;
select * from orders;
select * from employees;
select * from products;
select * from shippers;
