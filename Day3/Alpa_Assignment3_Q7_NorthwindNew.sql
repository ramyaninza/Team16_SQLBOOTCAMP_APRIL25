--7. List all orders with employee full names. (Inner join)

SELECT 
CONCAT(e.first_name, ' ', e.last_name) AS employeefullname,
o.employee_id,
o.order_id,
o.customer_id,
o.order_date,
o.required_date,
o.shipped_date,
o.ship_via,
o.freight
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id;
