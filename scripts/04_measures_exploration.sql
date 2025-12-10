/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the total sales.
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-- How many items are sold.
SELECT SUM(quantity) AS total_items_sold
FROM gold.fact_sales;

-- Find the average selling price.
SELECT AVG(price) AS avg_selling_price
FROM gold.fact_sales;

-- Find the total number orders.
SELECT COUNT(DISTINCT order_number) as total_orders
FROM gold.fact_sales;

-- Find the total number products.
SELECT COUNT(product_key) as total_products
FROM gold.dim_products

-- Find the total number customers.
SELECT COUNT(customer_key) as total_customers
FROM gold.dim_customers;

-- Find total number of customers that have placed an order.
SELECT COUNT(customer_key) AS totak_cutomer_placed_order
FROM gold.fact_sales;

-- Generate report of key business metrics.
SELECT 'Total Sales' as measure_name, SUM(sales_amount) AS total_sales
FROM gold.fact_sales
UNION ALL

SELECT 'Total Quantity' as measure_name, SUM(quantity) AS total_items_sold
FROM gold.fact_sales
UNION ALL

SELECT 'Average Selling Price' as measure_name, AVG(price) AS avg_selling_price
FROM gold.fact_sales
UNION ALL

SELECT 'Total Orders' as measure_name,COUNT(DISTINCT order_number) as total_orders
FROM gold.fact_sales
UNION ALL

SELECT 'Total Products' as measure_name, COUNT(product_key) as total_products
FROM gold.dim_products
UNION ALL

SELECT 'Total Customers' as measure_name,COUNT(customer_key) as total_customers
FROM gold.dim_customers
UNION ALL

SELECT 'Customers_Placed_Orders' as measure_name,COUNT(customer_key) AS totak_cutomer_placed_order
FROM gold.fact_sales;
