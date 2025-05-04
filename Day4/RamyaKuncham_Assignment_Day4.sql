
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'customers';

SELECT 
    customers.company_name AS customer,
    orders.order_id,
    products.product_name,
    order_details.quantity,
    orders.order_date
FROM 
    customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id;

SELECT 
    orders.order_id,
    customers.company_name AS customer,
    employees.first_name || ' ' || employees.last_name AS employee,
    shippers.company_name AS shipper,
    products.product_name,
    order_details.quantity,
    orders.order_date
FROM 
    orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id
LEFT JOIN employees ON orders.employee_id = employees.employee_id
LEFT JOIN shippers ON orders.ship_via = shippers.shipper_id
LEFT JOIN order_details ON orders.order_id = order_details.order_id
LEFT JOIN products ON order_details.product_id = products.product_id;

SELECT 
    order_details.order_id,
    products.product_id,
    order_details.quantity,
    products.product_name
FROM 
    order_details
RIGHT JOIN products ON order_details.product_id = products.product_id;

SELECT 
    categories.category_id,
    categories.category_name,
    products.product_id,
    products.product_name
FROM 
    categories
FULL OUTER JOIN products ON categories.category_id = products.category_id;

SELECT 
    categories.category_id,
    categories.category_name,
    products.product_id,
    products.product_name
FROM 
    categories
CROSS JOIN products;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'employees';

SELECT 
    employees.employee_id,
    employees.first_name || ' ' || employees.last_name AS employee,
    managers.first_name || ' ' || managers.last_name AS manager
FROM 
    employees
LEFT JOIN employees AS managers ON employees.reports_to = managers.employee_id;

SELECT 
    customers.customer_id,
    customers.company_name AS customer,
    o.order_id
FROM 
    customers
LEFT JOIN orders AS o ON customers.customer_id = o.customer_id
WHERE 
    o.ship_via IS NULL;












