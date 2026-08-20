# Sales-Customer-Analytics-Using-SQL


##Skills Demonstrated: SQL • MySQL • Data Analysis • Data Aggregation • Joins • CTEs • Subqueries • Customer Analysis • Sales Analysis • Query Optimization


##Project Overview::
This project focuses on analyzing sales and customer data using MySQL to generate meaningful business insights from transactional data.

The database consists of three main tables: customers, product, and sales. These tables are connected through primary and foreign key relationships, allowing sales transactions to be analyzed from different business perspectives, including customers, products, categories, regions, and time.
The project demonstrates practical SQL techniques commonly used in Data Analytics, including data aggregation, joins, subqueries, Common Table Expressions (CTEs), temporary tables, filtering, date-based analysis, and query optimization.

The overall objective is to transform raw transactional data into actionable insights that can support sales planning, customer retention, product strategy, and regional decision-making.


##Business Problem::
The business needs to better understand its sales performance, customer purchasing behavior, regional performance, and product-category contribution.

Without structured analysis, management may find it difficult to identify high-performing regions, high-value customers, important product categories, and changes in sales performance over time.

This project uses SQL to analyze transactional data and answer key business questions that can support:

Sales performance evaluation
Customer segmentation and retention
Product and category analysis
Regional sales planning
Identification of high-value customers
Data-driven business decision-making
Business Objectives

The main objectives of this project are to:

Evaluate overall sales performance.
Identify high-performing sales regions.
Analyze sales performance across product categories and regions.
Identify high-value customers.
Identify the top customers based on sales contribution.
Analyze monthly sales trends.
Compare individual transactions with overall sales benchmarks.
Identify region-category combinations that exceed a defined sales threshold.
Practice writing efficient and maintainable SQL queries.
Apply query optimization techniques to improve SQL logic and readability.
Database Schema

The database contains three primary tables:

              ┌──────────────────┐
              │    customers     │
              ├──────────────────┤
              │ customer_id (PK) │
              │ customer_name    │
              └────────┬─────────┘
                       │
                       │ customer_id (FK)
                       ▼
              ┌──────────────────┐
              │      sales       │
              ├──────────────────┤
              │ order_id (PK)    │
              │ customer_id (FK) │
              │ product_id (FK)  │
              │ region           │
              │ quantity         │
              │ sales_amount     │
              │ order_date       │
              └────────┬─────────┘
                       │
                       │ product_id (FK)
                       ▼
              ┌──────────────────┐
              │     product      │
              ├──────────────────┤
              │ product_id (PK)  │
              │ product_name     │
              │ category         │
              └──────────────────┘
Relationships
customers.customer_id → sales.customer_id
product.product_id → sales.product_id

These relationships allow customer and product information to be combined with transactional sales data for analysis.


##Database Structure:
product table-- Contains information about products.
Column	- Description
product_id -	Unique product identifier
product_name	- Product name
category	- Product category
Examples include:
iPhone
Samsung Galaxy
Laptop
Headphones
Mouse
Keyboard
Accessories
customers table -- Contains customer information.
Column -	Description
customer_id	- Unique customer identifier
customer_name	- Customer name
sales table -- Contains transaction-level sales information.
Column	- Description
order_id	- Unique order identifier
customer_id	- Links sales to customers
region	- Sales region
product_id	- Links sales to products


##Tools Used: 
MySQL
SQL
Relational Database Design
Primary & Foreign Keys
INNER JOIN
Aggregate Functions
GROUP BY
HAVING
Subqueries
Common Table Expressions (CTEs)
Temporary Tables
Date Functions
Query Optimization
