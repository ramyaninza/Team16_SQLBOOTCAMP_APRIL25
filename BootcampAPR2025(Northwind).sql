CREATE TABLE IF NOT EXISTS categories
(
   categoryID INT PRIMARY KEY,
   categoryName VARCHAR(100),
   description VARCHAR 
);



CREATE TABLE IF NOT EXISTS customers
(
	customerID VARCHAR(50) PRIMARY KEY,
	companyName VARCHAR(100),
	contactName VARCHAR(50),
	contactTitle VARCHAR(50),
	city VARCHAR(50),
	country VARCHAR(50)
)


CREATE TABLE IF NOT EXISTS products
(
	productID SERIAL PRIMARY KEY,
	productName VARCHAR(100),
	quantityPerUnit VARCHAR(100),
	unitPrice FLOAT,
	discontinued INT,
	categoryID INT
);

CREATE TABLE IF NOT EXISTS employees
(
	employeeID SERIAL PRIMARY KEY,
	employeeName VARCHAR(50),
	title VARCHAR(50),
	city VARCHAR(50),
	country VARCHAR(50),
	reportsTo INT
);

CREATE TABLE IF NOT EXISTS shippers
(
	shipperID SERIAL PRIMARY KEY,
	companyName VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS order_details
(
	orderID INT PRIMARY KEY,
	productID INT,
	unitPrice FLOAT,
	quantity INT,
	discount FLOAT
);

CREATE TABLE IF NOT EXISTS orders
(
	orderID INT PRIMARY KEY,
	customerID VARCHAR(50),
	employeeID INT,
	orderDate DATE,
	requiredDate DATE,
	shippedDate DATE,
	shipperID INT,
	freight FLOAT
);
