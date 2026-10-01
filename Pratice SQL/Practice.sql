CREATE DATABASE PRACTICE;
USE PRACTICE;

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

INSERT INTO Categories (category_id, category_name, description) VALUES
(1, 'Laptops', 'Laptops and notebooks'),
(2, 'Mobiles', 'Smartphones and mobile devices'),
(3, 'Accessories', 'Computer and mobile accessories'),
(4, 'Monitors', 'Computer monitors and displays'),
(5, 'Storage', 'SSD, HDD and storage devices');

CREATE TABLE products(
product_id INT PRIMARY KEY,
product_name varchar(50),
category_id INT,
price DECIMAL(10,2),
stock_quantity INT,
description varchar(100),
FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO Products
(product_id, product_name, category_id, price, stock_quantity, description)
VALUES
(1, 'Dell Inspiron 15', 1, 145000, 10, '15-inch Dell laptop'),
(2, 'HP ProBook 450', 1, 175000, 7, 'Business laptop'),
(3, 'Lenovo ThinkPad E14', 1, 185000, 5, 'Professional laptop'),
(4, 'Samsung Galaxy A55', 2, 125000, 15, 'Samsung smartphone'),
(5, 'iPhone 15', 2, 285000, 8, 'Apple smartphone'),
(6, 'Redmi Note 13', 2, 65000, 20, 'Xiaomi smartphone'),
(7, 'Logitech M185 Mouse', 3, 3500, 40, 'Wireless mouse'),
(8, 'HP Keyboard K150', 3, 4500, 30, 'USB keyboard'),
(9, 'Anker USB-C Cable', 3, 2500, 50, 'USB-C charging cable'),
(10, 'Dell 24 Monitor', 4, 42000, 12, '24-inch Full HD monitor'),
(11, 'Samsung 27 Monitor', 4, 65000, 9, '27-inch monitor'),
(12, 'Samsung 1TB SSD', 5, 22000, 18, '1TB NVMe SSD'),
(13, 'WD 1TB HDD', 5, 18000, 14, '1TB external HDD'),
(14, 'Kingston 512GB SSD', 5, 12500, 25, '512GB SSD'),
(15, 'Logitech C920 Webcam', 3, 18000, 11, 'Full HD webcam');

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name varchar(50),
email VARCHAR(100),
phone VARCHAR(11),
city varchar(25),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
--  email structure
    CONSTRAINT chk_email CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    
    --  starts with 030 and is followed by exactly 8 digits (Total 11)
    CONSTRAINT chk_phone CHECK (phone REGEXP '^030[0-9]{8}$')
);

INSERT INTO customers
(customer_id, name, email, phone, city, created_at)
VALUES
(1, 'Ali Khan', 'ali.khan@gmail.com', '03001234567', 'Karachi', '2026-01-10 09:15:00'),
(2, 'Sara Ahmed', 'sara.ahmed@gmail.com', '03012345678', 'Lahore', '2026-01-15 11:30:00'),
(3, 'Hamza Malik', 'hamza.malik@yahoo.com', '03023456789', 'Islamabad', '2026-02-01 14:20:00'),
(4, 'Ayesha Noor', 'ayesha.noor@gmail.com', '03034567890', 'Karachi', '2026-02-12 10:45:00'),
(5, 'Usman Raza', 'usman.raza@hotmail.com', '03045678901', 'Hyderabad', '2026-02-20 16:10:00'),
(6, 'Hina Shah', 'hina.shah@gmail.com', '03056789012', 'Lahore', '2026-03-05 08:50:00'),
(7, 'Bilal Ahmed', 'bilal.ahmed@yahoo.com', '03067890123', 'Karachi', '2026-03-18 13:35:00'),
(8, 'Zainab Ali', 'zainab.ali@gmail.com', '03078901234', 'Islamabad', '2026-04-02 12:05:00'),
(9, 'Danish Khan', 'danish.khan@gmail.com', '03089012345', 'Multan', '2026-04-15 15:40:00'),
(10, 'Maha Iqbal', 'maha.iqbal@hotmail.com', '03090123456', 'Peshawar', '2026-05-01 17:25:00');


CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE DEFAULT (CURRENT_DATE),
status VARCHAR(20) DEFAULT 'Pending' 
    CONSTRAINT chk_status CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    
total_amount DECIMAL(10,2),

FOREIGN KEY(customer_id) REFERENCES customers (customer_id)
);
INSERT INTO orders
(order_id, customer_id, order_date, status, total_amount)
VALUES
(101, 1, '2026-05-02', 'Delivered', 148500.00),
(102, 2, '2026-05-04', 'Delivered', 125000.00),
(103, 3, '2026-05-06', 'Pending', 285000.00),
(104, 1, '2026-05-10', 'Shipped', 42000.00),
(105, 4, '2026-05-12', 'Delivered', 188000.00),
(106, 5, '2026-05-15', 'Cancelled', 65000.00),
(107, 6, '2026-05-18', 'Processing', 24500.00),
(108, 7, '2026-05-20', 'Shipped', 196500.00),
(109, 8, '2026-05-23', 'Delivered', 83000.00),
(110, 9, '2026-05-25', 'Delivered', 30500.00),
(111, 2, '2026-05-27', 'Delivered', 285000.00),
(112, 3, '2026-05-29', 'Pending', 45000.00);

CREATE TABLE Order_Items(
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT NOT NULL CHECK(quantity>0),
unit_price DECIMAL(10,2),
subtotal DECIMAL(10,2) GENERATED ALWAYS AS(quantity*unit_price),

FOREIGN KEY(order_id) REFERENCES orders(order_id),
FOREIGN KEY(product_id) REFERENCES products(product_id)
);
INSERT INTO Order_Items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 101, 1, 1, 145000.00),
(2, 101, 7, 1, 3500.00),

(3, 102, 4, 1, 125000.00),

(4, 103, 5, 1, 285000.00),

(5, 104, 10, 1, 42000.00),

(6, 105, 2, 1, 175000.00),
(7, 105, 8, 1, 4500.00),
(8, 105, 9, 1, 2500.00),
(9, 105, 7, 1, 3500.00),
(10, 105, 9, 1, 2500.00),

(11, 106, 6, 1, 65000.00),

(12, 107, 12, 1, 22000.00),
(13, 107, 9, 1, 2500.00),

(14, 108, 3, 1, 185000.00),
(15, 108, 7, 2, 3500.00),
(16, 108, 8, 1, 4500.00),

(17, 109, 11, 1, 65000.00),
(18, 109, 15, 1, 18000.00),

(19, 110, 13, 1, 18000.00),
(20, 110, 14, 1, 12500.00),

(21, 111, 5, 1, 285000.00),

(22, 112, 8, 2, 4500.00),
(23, 112, 15, 2, 18000.00);




-- Basic
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM customers; -- 1
SELECT * FROM customers where city= 'karachi'; -- 2
SELECT * FROM products WHERE  price>10000; -- 3
SELECT * FROM products ORDER BY price ASC; -- 4
SELECT * FROM products ORDER BY price DESC limit 5; -- 5
 
-- INTERMEDIATE (QUERIES)
SELECT COUNT(*) FROM customers; -- 1
SELECT AVG(price) FROM products; -- 2
SELECT SUM(subtotal) FROM order_items; -- 3
SELECT customer_id, count(order_id) as order_count from orders group by customer_id; -- 4
SELECT * FROM customers WHERE customer_id NOT IN (SELECT customer_id FROM orders); -- 5

-- JOINS
SELECT c.name , O.total_amount from customers c RIGHT JOIN orders o on c.customer_id= o.customer_id; -- 1
SELECT o.* , p.* from orders o LEFT JOIN products p on p.product_id= o.product_id; -- 2
SELECT 
    o.order_id,
    o.order_date,
    o.status,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.subtotal
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN products p 
    ON oi.product_id = p.product_id;

SELECT 
    customer_id,
    SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id;  -- 4


SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC
LIMIT 1;



SELECT 
    customer_id,
    SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200000;



-- Advance 
SELECT customer_id, SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT customer_id, SUM(total_amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) AS t
);