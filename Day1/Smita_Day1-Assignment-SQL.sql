CREATE Table customers
		(
		customerID	VARCHAR(5) primary key,	,	
		companyName	VARCHAR(40),	
		contactName	VARCHAR(30),	
		contactTitle VARCHAR(30),	
		city		VARCHAR(15),	
		country	    VARCHAR(15),
		);
		
CREATE Table categories
		(
		categoryID	bigint primary key,		
        categoryName VARCHAR(100),,	
        description  VARCHAR(100),
        );		

CREATE Table products
		(
		productID	 bigint primary key,		
     	productName	 VARCHAR(100),
		quantityPerUnit	VARCHAR(100),
		unitPrice	numeric,	
		discontinued smallint,	
		categoryID	integer,
		FOREIGN KEY  (categoryID) REFERENCES categories (categoryID)
		);

CREATE TABLE orders 
	(	orderID			bigint primary key,
		customerID		VARCHAR(50),
		FOREIGN KEY (customerID) REFERENCES customers(customerID),
        employeeID		bigint,
		FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
        orderDate		date,
        requiredDate 	date,
        shippedDate	 	date,
        shipperID		bigint,
		FOREIGN KEY (shipperID) REFERENCES shippers(shipperID),
		freight			numeric
	);	

CREATE TABLE order_details
		(
			orderID		bigint ,		
			FOREIGN KEY (orderID) REFERENCES orders(orderID),
			productID	bigint ,		
			FOREIGN KEY (productID) REFERENCES products(productID),
			unitPrice	numeric(10,2) ,		
			quantity	integer ,				
			discount	numeric(6,2)	
		);

CREATE TABLE shippers
        (  
        shipperID bigint Primary key,	
        companyName	VARCHAR(50)		
		);		

CREATE Table employees
		(
        employeeID bigint primary key,			
		employeeName 	VARCHAR(50),
		title			VARCHAR(50),
		city VARCHAR(50),
		country     VARCHAR(50),
		reportsTo	bigint,
		FOREIGN KEY  (reportsTo) REFERENCES employees (employeeID)
		);		

CREATE TABLE orders 
	(	orderID			bigint primary key,
		customerID		VARCHAR(50),
		FOREIGN KEY (customerID) REFERENCES customers(customerID),
        employeeID		bigint,
		FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
        orderDate		date,
        requiredDate 	date,
        shippedDate	 	date,
        shipperID		bigint,
		FOREIGN KEY (shipperID) REFERENCES shippers(shipperID),
		freight			numeric
	);		