-- 1. Creating table for Categories
CREATE TABLE Categories (
    categoryID INT PRIMARY KEY, 
    categoryName VARCHAR(100) NOT NULL,   
    description TEXT         
);

/*
Explanation about Used Constraints
INT - The value should be a number 
PRIMARY KEY - Since categoryID is a unique identifier,a primary key is a unique identifier for each record in a database table.
Null Value is not allowed in Primary key.

*/

Select * from Categories

-- 2. Creating table for Customers
CREATE TABLE C
ustomers (
    customerID VARCHAR(10) PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL,
    contactName VARCHAR(100),
    contactTitle VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);

Select * from Customers

-- 3. Creating table for Employees

CREATE TABLE employees (
    employeeID INT PRIMARY KEY,
    employeeName VARCHAR(100) NOT NULL,
    title VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    reportsTo INT,
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
);

/*

Foreign Key - Here foreign key is used to represent manager of an employee. THe link is within the employees table .

*/

Select * from employees

-- 4. Creating table for Products

CREATE TABLE products (
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


Select * from products 

-- 5. Creating table for Shipper

CREATE TABLE shippers (
    shipperID INT PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL
);

Select * from shippers 

-- 6. Creating tables for Orders

CREATE TABLE orders (
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


Select * from orders 

-- 7. Creating tables for Order_details
CREATE TABLE order_details (
    orderID INT,
    productID INT,
    unitPrice DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(10, 2),

    FOREIGN KEY (orderID) REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);

Select * from order_details 

