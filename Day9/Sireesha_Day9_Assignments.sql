/*Day 9,1.1.Create AFTER UPDATE trigger to track product price changes

 
 Create product_price_audit table with below columns:
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

CREATE OR REPLACE FUNCTION price_change_log()
RETURNS TRIGGER AS $$
BEGIN
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
    RETURN NEW;
END;

$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_product_price_change
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
WHEN (OLD.unit_price IS DISTINCT FROM NEW.unit_price)
EXECUTE FUNCTION price_change_log();


-- Check existing price
SELECT product_id, product_name, unit_price FROM products WHERE product_id = 1;

-- Update price by 10%
UPDATE products
SET unit_price = unit_price * 1.1
WHERE product_id = 1;

-- Check audit table
SELECT * FROM product_price_audit;


/* 2  Create stored procedure  using IN and INOUT parameters to assign tasks to employees */

CREATE OR REPLACE PROCEDURE sp_assign_tasks(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Step 1: Create the table if it doesn't exist
    CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );

    -- Step 2: Insert the new task
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);

    -- Step 3: Count total tasks for the employee
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

    -- Step 4: Raise a notice
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;

DO $$
DECLARE
    task_total INT := 0;
BEGIN
    CALL sp_assign_tasks(1, 'Review Reports', task_total);
END;

$$;

/*step4 verify the output*/
SELECT * FROM employee_tasks WHERE employee_id = 1;










