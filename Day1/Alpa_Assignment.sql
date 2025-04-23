drop table categories;
CREATE TABLE IF NOT EXISTS categories
(
   categoryID INT PRIMARY KEY,
   categoryName VARCHAR(100),
   description VARCHAR(255) 
);

select * from categories;

CREATE TABLE IF NOT EXISTS customers
(
	customerID VARCHAR(50) PRIMARY KEY,
	companyName VARCHAR(100),
	contactName VARCHAR(50),
	contactTitle VARCHAR(50),
	city VARCHAR(50),
	country VARCHAR(50)
)

select * from customers;
CREATE TABLE IF NOT EXISTS products
(
	productID SERIAL PRIMARY KEY,
	productName VARCHAR(100),
	quantityPerUnit VARCHAR(100),
	unitPrice FLOAT,
	discontinued INT,
	categoryID INT
);

select * from products;
select * from employees;
CREATE TABLE IF NOT EXISTS employees
(
	employeeID SERIAL PRIMARY KEY,
	employeeName VARCHAR(50),
	title VARCHAR(50),
	city VARCHAR(50),
	country VARCHAR(50),
	reportsTo INT
);
select * from shippers
CREATE TABLE IF NOT EXISTS shippers
(
	shipperID SERIAL PRIMARY KEY,
	companyName VARCHAR(50)
);

drop table order_details;
CREATE TABLE IF NOT EXISTS order_details
(
	orderID INT REFERENCES orders(orderID),
	productID INT,
	unitPrice FLOAT,
	quantity INT,
	discount FLOAT
		);
select * from orders

drop table orders;

select * from orders
CREATE TABLE IF NOT EXISTS orders
(
	orderID INT PRIMARY KEY,
	customerID VARCHAR(50) REFERENCES customers(customerID),
	employeeID INT REFERENCES employees(employeeID)  ,
	orderDate DATE,
	requiredDate DATE,
	shippedDate DATE,
	shipperID INT REFERENCES shippers(shipperID) ,
	freight FLOAT
		);
drop table orders

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
