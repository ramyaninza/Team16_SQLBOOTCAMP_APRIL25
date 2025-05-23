create TABLE employees (
employeeID serial Primary Key,
employeeName Varchar(60),
title Varchar(100),
city Varchar(100),
country Varchar(60),
reportsTo Varchar(60)
);

CREATE TABLE order_details (
    orderID INT,
    productID INT,
    unitPrice DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(5, 2),
    PRIMARY KEY (orderID, productID)  -- Assumption: orderID + productID is the unique key
);

CREATE TABLE orders1 (
    orderID INT PRIMARY KEY,
    customerID VARCHAR(5),        
    employeeID INT,              
    orderDate DATE,               
    requiredDate DATE,           
    shippedDate DATE,             
    shipperID INT,               
    freight DECIMAL(10, 2)       
);

CREATE TABLE products (
    productID INT PRIMARY KEY,
    productName VARCHAR(100),
    quantityPerUnit VARCHAR(100),
    unitPrice DECIMAL(10, 2),
    discontinued BOOLEAN,
    categoryID INT
);
CREATE TABLE shippers (
    shipperID INT PRIMARY KEY,
    companyName VARCHAR(100)
);

ALTER TABLE orders1
ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customerID)
REFERENCES customers(customerID);

ALTER TABLE customers
ADD CONSTRAINT pk_customerID PRIMARY KEY (customerID);

ALTER TABLE orders1
ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customerID)
REFERENCES customers(customerID);
