-- Active: 1694603789152@@127.0.0.1@5432@northwind@public

-- 1

SELECT
    e.first_name || ' ' || e.last_name AS "employee name",
    COUNT(o.employee_id)
FROM employees e
    LEFT JOIN orders o ON o.employee_id = e.employee_id
GROUP BY e.employee_id
ORDER BY COUNT DESC;

-- 2

SELECT
    c.category_name,
    SUM(
        od.quantity * od.unit_price * (1 - od.discount)
    )
FROM order_details od
    INNER JOIN products p ON od.product_id = p.product_id
    INNER JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;

-- 3

SELECT
    c.contact_name,
    AVG(total) AS "average price"
FROM customers c
    INNER JOIN(
        SELECT
            o.customer_id,
            SUM(
                od.unit_price * od.quantity * (1 - od.discount)
            ) AS total
        FROM order_details od
            INNER JOIN orders o ON o.order_id = od.order_id
        GROUP BY
            o.order_id
    ) subQuery ON c.customer_id = subQuery.customer_id
GROUP BY c.contact_name
ORDER BY "average price" DESC;

-- 4

SELECT c.contact_name
FROM order_details od
    INNER JOIN orders o ON od.order_id = o.order_id
    INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.contact_name
ORDER BY
    SUM(
        od.unit_price * od.quantity * (1 - od.discount)
    ) DESC
LIMIT 10;

-- 5

SELECT
    to_char(o.order_date, 'yyyy-mm') AS date,
    SUM(
        od.quantity * od.unit_price * (1 - od.discount)
    )
FROM order_details od
    INNER JOIN orders o ON o.order_id = od.order_id
GROUP BY date
ORDER BY date DESC;

-- 6

SELECT
    product_name,
    units_in_stock
FROM products
WHERE units_in_stock < 10;

-- 7

SELECT
    c.contact_name,
    MAX(total)
FROM customers c
    INNER JOIN(
        SELECT
            o.customer_id,
            SUM(
                od.unit_price * od.quantity * (1 - od.discount)
            ) AS total
        FROM order_details od
            INNER JOIN orders o ON o.order_id = od.order_id
        GROUP BY
            o.order_id
    ) subQuery ON c.customer_id = subQuery.customer_id
GROUP BY c.contact_name
ORDER BY MAX DESC
LIMIT 1;

-- 8

SELECT
    o.ship_country,
    SUM(
        od.unit_price * od.quantity * (1 - od.discount)
    )
FROM orders o
    INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.ship_country
ORDER BY SUM DESC;

-- 9

SELECT
    ship_name,
    COUNT(ship_name)
FROM orders
GROUP BY ship_name
ORDER BY COUNT DESC
LIMIT 1;

-- 10

SELECT *
FROM products p
    LEFT JOIN order_details od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;

SELECT *
FROM products p
WHERE p.product_id NOT IN (
        SELECT DISTINCT product_id
        FROM order_details
    );