
-- Q1: Products priced between 1000 and 4000
SELECT product_name, price
FROM products
WHERE price BETWEEN 1000 AND 4000;

-- Q2: Count customers by city
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY city;

-- Q3: Revenue by category for completed orders
SELECT p.category,
       SUM(o.quantity) AS total_units,
       SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY p.category;

-- Q4: Customers who never placed an order
SELECT c.customer_id, c.name, c.city
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Q5: Customers who spent more than 10000
SELECT c.name,
       COUNT(o.order_id) AS completed_orders,
       SUM(o.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.name
HAVING SUM(o.quantity * p.price) > 10000;

-- Q6: Classify completed orders by value
SELECT
    CASE
        WHEN o.quantity * p.price < 1500 THEN 'Small'
        WHEN o.quantity * p.price < 4000 THEN 'Medium'
        ELSE 'Large'
    END AS order_size,
    COUNT(*) AS total_orders,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY order_size
ORDER BY FIELD(order_size, 'Small', 'Medium', 'Large');

-- Q7: Month-over-month revenue change
WITH monthly_revenue AS (
    SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
           SUM(o.quantity * p.price) AS revenue
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE o.status = 'completed'
      AND o.order_date >= '2026-01-01'
      AND o.order_date < '2026-07-01'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
),
revenue_comparison AS (
    SELECT month,
           revenue,
           LAG(revenue) OVER (ORDER BY month) AS previous_revenue
    FROM monthly_revenue
)
SELECT month,
       revenue,
       previous_revenue,
       revenue - previous_revenue AS revenue_change
FROM revenue_comparison
ORDER BY month;

-- Q8: Best-selling product(s) in each category
WITH product_sales AS (
    SELECT p.category,
           p.product_id,
           p.product_name,
           SUM(o.quantity) AS units_sold
    FROM products p
    JOIN orders o ON p.product_id = o.product_id
    WHERE o.status = 'completed'
    GROUP BY p.category, p.product_id, p.product_name
),
ranked_products AS (
    SELECT category,
           product_name,
           units_sold,
           RANK() OVER (
               PARTITION BY category
               ORDER BY units_sold DESC
           ) AS product_rank
    FROM product_sales
)
SELECT category, product_name, units_sold
FROM ranked_products
WHERE product_rank = 1
ORDER BY category;
