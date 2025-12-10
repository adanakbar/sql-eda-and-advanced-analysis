/*
==============================================================
Product Report
==============================================================
Purpose:
	- This report consolidates key product metrics and behaviours.

Highlights:
	1. Gather essential fields such as product name, category,  subcategory and cost.
	2. Segments products by revenue to identify High-Performers, Mid-Range or Low-Performers.
	3. Aggreagte product level metrics:
		- total orders
		- total sales
		- total quantity purchases
		- total customers (unique)
		- total products
		- lifespan (in months)
	4. Calculate valuable KIPs:
		- recency (month since last order)
		- avarage order revenue (AOR)
		- average monthly spend
*/
-- Base Query: Retrive core columns from fact and dimensions.
CREATE VIEW gold.report_products AS 
WITH base_query AS (
SELECT 
s.order_number,
s.quantity,
s.customer_key,
s.sales_amount,
s.order_date,
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
WHERE s.order_date IS NOT NULL)
---- Product Aggregation: Summarize key metrics at product level.
,customer_aggregations AS (
SELECT 
product_key,
product_name,
category,
subcategory,
cost,
COUNT(DISTINCT order_number) AS total_orders,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT customer_key) AS total_customers,
COUNT(*) AS total_products,
MAX(order_date) AS last_order_date,
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
ROUND(AVG(CAST(sales_amount AS FLOAT) / ISNULL(quantity,0)),1) AS avg_selling_prive
FROM base_query
GROUP BY product_key,product_name,category,subcategory,cost)

-- Final Result: Combine all customer results in one output.
SELECT 
*,
CASE 
	WHEN total_sales > 50000 THEN 'High-Performer'
	WHEN total_sales >= 10000 THEN 'Mid-Range'
	ELSE 'Low-Performer'
END AS product_segment,
CASE 
	WHEN total_Sales = 0 THEN 0
	ELSE total_sales / total_orders
END AS avg_order_revenue,
CASE 
	WHEN lifespan = 0 THEN total_sales
	ELSE total_sales / lifespan
END AS avg_monthly_revenue
FROM customer_aggregations;


-- Now the end user(Data Analyst) can quickly analyze the data from the view
SELECT 
product_segment,
COUNT(product_key) AS total_products,
SUM(total_sales) AS total_sales
FROM gold.report_products
GROUP BY product_segment

SELECT 
segments,
COUNT(customer_key) AS total_customers,
SUM(total_sales) AS total_sales
FROM gold.report_customer
GROUP BY segments
