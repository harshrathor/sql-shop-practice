-- Online Shop SQL Practice
-- MySQL 8

CREATE DATABASE IF NOT EXISTS shop_starter;
USE shop_starter;

DROP TABLE IF EXISTS orders, products, customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(30) NOT NULL,
    signup_date DATE NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(30) NOT NULL,
    price INT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(10) NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Aarav', 'Mumbai', '2025-11-03'),
(2, 'Diya', 'Pune', '2025-11-20'),
(3, 'Kabir', 'Delhi', '2025-12-05'),
(4, 'Ishita', 'Mumbai', '2025-12-18'),
(5, 'Rohan', 'Bengaluru', '2026-01-10'),
(6, 'Ananya', 'Pune', '2026-01-25'),
(7, 'Zoya', 'Mumbai', '2026-02-14'),
(8, 'Vihaan', 'Delhi', '2026-03-02');

INSERT INTO products VALUES
(1, 'Wireless Mouse', 'Electronics', 799),
(2, 'Bluetooth Speaker', 'Electronics', 2499),
(3, 'Smart Watch', 'Electronics', 5999),
(4, 'Yoga Mat', 'Fitness', 1199),
(5, 'Dumbbell Set', 'Fitness', 3499),
(6, 'Water Bottle', 'Fitness', 499),
(7, 'Notebook Pack', 'Stationery', 299),
(8, 'Desk Lamp', 'Stationery', 1499);

INSERT INTO orders VALUES
(101, 1, 2, 1, '2026-01-05', 'completed'),
(102, 2, 4, 2, '2026-01-12', 'completed'),
(103, 3, 3, 1, '2026-01-20', 'completed'),
(104, 1, 6, 3, '2026-01-28', 'completed'),
(105, 4, 1, 2, '2026-02-03', 'completed'),
(106, 5, 5, 1, '2026-02-10', 'cancelled'),
(107, 2, 7, 5, '2026-02-18', 'completed'),
(108, 1, 4, 1, '2026-02-25', 'completed'),
(109, 3, 2, 2, '2026-03-04', 'completed'),
(110, 6, 8, 1, '2026-03-11', 'cancelled'),
(111, 4, 6, 2, '2026-03-19', 'completed'),
(112, 5, 3, 1, '2026-03-27', 'completed'),
(113, 1, 8, 1, '2026-04-02', 'completed'),
(114, 2, 5, 1, '2026-04-09', 'completed'),
(115, 3, 7, 4, '2026-04-15', 'completed'),
(116, 4, 2, 1, '2026-04-22', 'completed'),
(117, 1, 1, 1, '2026-05-06', 'completed'),
(118, 5, 4, 2, '2026-05-14', 'completed'),
(119, 2, 6, 2, '2026-05-21', 'cancelled'),
(120, 3, 5, 1, '2026-06-03', 'completed'),
(121, 4, 3, 1, '2026-06-10', 'completed'),
(122, 2, 1, 3, '2026-06-18', 'completed');

-- Verify inserted data
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_products FROM products;
SELECT COUNT(*) AS total_orders FROM orders;
