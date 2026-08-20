CREATE DATABASE company_db
USE company_db


CREATE TABLE product (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
    )
 
INSERT INTO product (product_id, product_name, category) VALUES
 (1, 'iPhone 16 pro max', 'Electronics'),
 (2, 'iPhone 17 pro max', 'Electronics'),
 (3, 'Samsung Galaxy S26 Ultra', 'Electronics'),
 (4, 'Headphones', 'Gadget'),
 (5, 'Mouse', 'Gadget'),
 (6, 'Laptop', 'Electronics'),
 (7, 'Keyboard', 'Gadget'),
 (8, 'Mouse Pad', 'Accessories'),
 (9, 'RGB light', 'Accessories'),
 (10, 'Laptop Bag', 'Accessories')
 
 SELECT * FROM product
 
 
 CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
	)
    
INSERT INTO customers (customer_id, customer_name) VALUES
 (1, 'Messi'),
 (2, 'Neymar'),
 (3, 'Ronaldo'),
 (4, 'Mbappe'),
 (5, 'Haland'),
 (6, 'Vini'),
 (7, 'Raphinha'),
 (8, 'Alvarez'),
 (9, 'Martinez')
 
 SELECT * FROM customers
 
 
 CREATE TABLE sales (
	order_id INT PRIMARY KEY,
    customer_id INT,
    region VARCHAR(50),
    product_id INT,
    quantity INT,
    sales_amount DECIMAL(10, 2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
	)
    
INSERT INTO sales (order_id, customer_id, region, product_id, quantity, sales_amount, order_date) VALUES
 (1, 1, 'North', 1, 1, 1000.00, '2026-01-15'),
 (2, 2, 'North', 2, 1, 2000.00, '2026-01-18'),
 (3, 3, 'South', 4, 2, 300.00, '2026-02-10'),
 (4, 4, 'East', 6, 3, 270.00, '2026-02-14'),
 (5, 1, 'North', 3, 1, 1200.00, '2026-03-05'),
 (6, 6, 'West', 8, 2, 1800.00, '2026-03-22'),
 (7, 5, 'South', 5, 1, 600.00, '2026-04-02'),
 (8, 7, 'East', 7, 5, 250.00, '2026-04-19'),
 (9, 1, 'North', 10, 1, 150.00, '2026-05-01'),
 (10, 9, 'North', 3, 2, 1200.00, '2026-05-12'),
 (11, 8, 'South', 1, 1, 1000.00, '2026-05-25'),
 (12, 4, 'East', 9, 4, 160.00, '2026-06-02'),
 (13, 3, 'West', 2, 1, 2000.00, '2026-06-11'),
 (14, 4, 'North', 3, 2, 2400.00, '2026-06-18'),
 (15, 5, 'South', 6, 2, 180.00, '2026-06-25')
 
 SELECT * FROM product
 SELECT * FROM customers
 SELECT * FROM sales
 
 
 
-- step 2 --
CREATE TEMPORARY TABLE temp_Customers AS
SELECT
s.order_id, s.order_date, s.product_id,
c.customer_id, c.customer_name,
s.region, s.quantity, s.sales_amount
FROM sales as s
INNER JOIN customers as c ON s.customer_id=c.customer_id
ORDER BY s.sales_amount DESC

SELECT * FROM temp_Customers

SELECT 
p.product_id, p.product_name, p.category, 
t.customer_id, t.customer_name,
t.order_id, t.order_date, t.region, t.quantity, t.sales_amount
FROM product as p
INNER JOIN temp_Customers as t ON t.product_id=p.product_id



-- step 3 --
-- avg: 967.33333

SELECT p.product_id, p.product_name, s.sales_amount
FROM sales as s
INNER JOIN product as p 
ON s.product_id=p.product_id
WHERE s.sales_amount >(SELECT avg(sales_amount) 
					   FROM sales)



-- step 4 --
SELECT region, 
sum(sales_amount) as total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC
LIMIT 2


SELECT region, total_sales
FROM ( SELECT region, sum(sales_amount) as total_sales
		FROM sales
		GROUP BY region) as regionwise_TotalSales
WHERE total_sales > (SELECT AVG(total_sales) 
					 FROM (SELECT region, sum(sales_amount) as total_sales
							FROM sales
							GROUP BY region) AS regionwise_AvgSales)
                            
                            


-- step 5 --
SELECT
sales.region, product.category,
sum(sales.sales_amount) AS total_sales
FROM sales
INNER JOIN product 
ON sales.product_id=product.product_id
GROUP BY sales.region, product.category



-- step 6 --
SELECT
sales.region, product.category,
sum(sales.sales_amount) AS total_sales
FROM sales
INNER JOIN product 
ON sales.product_id=product.product_id
GROUP BY sales.region, product.category
HAVING total_sales > 1000



-- step 7 --
SELECT (SELECT 
		AVG(sales_amount)
        FROM sales) AS avg_sales,
SUM(sales_amount) AS total_sales
FROM sales



-- step 8 --
-- monthly sales summary
SELECT 
MONTHNAME(order_date) AS month_name,
MONTH(order_date) AS month,
COUNT(order_id) AS total_orders,
SUM(sales_amount) AS monthly_total_sales
FROM sales
GROUP BY month_name, month
ORDER BY monthly_total_sales DESC

-- top 5 customers by sales
SELECT 
c.customer_id, c.customer_name,
SUM(s.sales_amount) AS total_sales
FROM customers AS c
INNER JOIN sales AS s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_sales DESC
LIMIT 5



-- step 9 --
-- complex query
SELECT 
customer_id, customer_name
FROM customers
WHERE customer_id IN (SELECT customer_id
					  FROM sales
					  WHERE sales_amount > 1000)
                      
-- optimized
SELECT DISTINCT c.customer_id, c.customer_name
FROM sales AS s
INNER JOIN customers AS c ON s.customer_id=c.customer_id
WHERE sales_amount > 1000


-- Optimized approach using CTE and direct JOIN
WITH HighValueCustomers AS (
    SELECT customer_id
    FROM sales
    WHERE sales_amount > 1000
    GROUP BY customer_id
)
SELECT 
    c.customer_id, 
    c.customer_name
FROM customers AS c
JOIN HighValueCustomers AS hvc ON c.customer_id = hvc.customer_id