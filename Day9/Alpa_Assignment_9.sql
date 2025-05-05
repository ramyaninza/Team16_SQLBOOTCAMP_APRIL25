
 
--1.Create AFTER UPDATE trigger to track product price changes
 
/*       Create product_price_audit table with below columns:
	audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
 
·       Create a trigger function with the below logic:
 
  INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
·       Create a row level trigger for below event:
          	AFTER UPDATE OF unit_price ON products
 
·        Test the trigger by updating the product price by 10% to any one product_id.*/

CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);

-- Define the trigger function
CREATE OR REPLACE FUNCTION funcn_track_price_change()
RETURNS TRIGGER
AS $$
BEGIN
-- Insert into product_price_audit table
    INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
	-- Return the new row
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER after_price_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
WHEN (OLD.unit_price IS DISTINCT FROM NEW.unit_price)
EXECUTE FUNCTION funcn_track_price_change();

SELECT * FROM products

SELECT product_id, product_name, unit_price FROM products WHERE product_id = 1;


UPDATE products SET unit_price = unit_price * 1.10
WHERE product_id = 1;

SELECT * FROM product_price_audit 
 
 
--2.Create stored procedure  using IN and INOUT parameters to assign tasks to employees
 
/*      Parameters:
IN p_employee_id INT,
IN p_task_name VARCHAR(50),
 INOUT p_task_count INT DEFAULT 0
 
·       Inside Logic: Create table employee_tasks:
 CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );
 
·       Insert employee_id, task_name  into employee_tasks
·       Count total tasks for employee and put the total count into p_task_count .
·       Raise NOTICE message:
 RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
 
 
After creating stored procedure test by calling  it:
 CALL assign_task(1, 'Review Reports');
 
You should see the entry in employee_tasks table.*/


 
CREATE OR REPLACE PROCEDURE Assign_Task(
	IN p_employee_id INT,
	IN p_task_name VARCHAR(50),
	INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
 ---let's create a table---
CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );
---insert values in above table--
INSERT INTO employee_tasks(employee_id,task_name)
VALUES (p_employee_id,p_task_name);

SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id; 
--raised a notice   
RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$; 


CALL Assign_Task(1, 'Review Reports');

SELECT * FROM employee_tasks WHERE employee_id =1;
