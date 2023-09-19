-- 1

SELECT *
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- 2

SELECT
    c.company_name,
    COUNT(o.customer_id) AS orders
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.company_name
HAVING
    COUNT(o.customer_id) >= 10
ORDER BY orders DESC;

-- 3

SELECT
    p.product_name,
    od.unit_price
FROM products p
    INNER JOIN order_details od ON od.product_id = p.product_id
WHERE od.unit_price > (
        SELECT
            AVG(unit_price)
        FROM order_details
    );

-- 5

SELECT country, COUNT(country)
FROM customers
GROUP BY country
HAVING COUNT(country) >= 5

-- 6

SELECT *
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id AND EXTRACT(
        YEAR
        FROM
            o.order_date
    ) = 1998
WHERE o.customer_id IS NULL;

-- 7

SELECT *
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id AND o.order_date >= '01-01-1998'
WHERE
    o.customer_id IS NULL
    AND c.country = 'USA';

-- 8

SELECT
    c.company_name,
    COUNT(o.customer_id)
FROM customers c
    INNER JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.company_name
HAVING COUNT(o.customer_id) = 3

-- 10

SELECT
    s.company_name,
    COUNT(p.supplier_id)
FROM suppliers s
    INNER JOIN products p ON s.supplier_id = p.supplier_id AND s.country = 'USA'
GROUP BY s.company_name
HAVING COUNT(p.supplier_id) > 1;

SELECT * FROM suppliers 