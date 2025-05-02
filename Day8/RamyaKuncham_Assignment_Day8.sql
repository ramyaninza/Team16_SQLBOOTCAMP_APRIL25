

-- Step 1: Create the view
CREATE VIEW vw_updatable_products AS
SELECT 
    product_id,
    product_name,
    unit_price,
    units_in_stock,
    discontinued
FROM products
WHERE discontinued = 0
WITH CHECK OPTION;

-- Step 2: Select from the view
SELECT * FROM vw_updatable_products;

-- Step 3: Update the view
UPDATE vw_updatable_products
SET unit_price = unit_price * 1.1
WHERE units_in_stock < 10;


BEGIN;
UPDATE products
SET unit_price = unit_price * 1.1
WHERE category_id = 1;
SELECT product_id, product_name, unit_price
FROM products
WHERE category_id = 1;
COMMIT;
ROLLBACK;

CREATE VIEW vw_employee_territories AS
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_full_name,
    e.title,
    t.territory_id,
    t.territory_description,
    r.region_description
FROM employees e
JOIN employee_territories et ON e.employee_id = et.employee_id
JOIN territories t ON et.territory_id = t.territory_id
JOIN region r ON t.region_id = r.region_id;

WITH RECURSIVE employee_hierarchy AS (
    -- Anchor member: top-level employees (no manager)
    SELECT 
        employee_id,
        first_name || ' ' || last_name AS employee_full_name,
        title,
        reports_to,
        1 AS level
    FROM employees
    WHERE reports_to IS NULL

    UNION ALL

    -- Recursive member: employees reporting to someone
    SELECT 
        e.employee_id,
        e.first_name || ' ' || e.last_name,
        e.title,
        e.reports_to,
        eh.level + 1
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.reports_to = eh.employee_id
)

SELECT * FROM employee_hierarchy
ORDER BY level, employee_id;



