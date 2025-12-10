-- Reporting
/*
==============================================================
Customer Report
==============================================================
Purpose:
	- This report consolidates key customer metrics and behaviours.

Highlights:
	1. Gather essential fields such as names, ages and transactional details.
	2. Segments customers into categories /9VIP, Regular, New) and age groups.
	3. Aggreagte customer level metrics:
		- total orders
		- total sales
		- total quantity purchases
		- total products
		- lifespan (in months)
	4. Calculate valuable KIPs:
		- recency (month since last order)
		- avarage order value
		- average monthly spend
*/

-- Base Query: Retrive core columns from fact and dimensions.
CREATE VIEW gold.report_customer AS 
WITH base_query AS (
SELECT 
s.order_number,
s.order_date,
s.product_key,
s.quantity,
s.sales_amount,
c.customer_key,
c.customer_number,
CONCAT(c.first_name,' ',c.last_name) AS name,
DATEDIFF(year,c.birthdate, GETDATE()) AS age
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
WHERE s.order_date IS NOT NULL)

-- Customer Aggregation: Summarize key metrics at customer level.
,customer_level_aggregations AS 
(
SELECT 
customer_key,
name,
customer_number,
age,
COUNT(DISTINCT order_number) AS total_orders,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity_purchased,
COUNT(DISTINCT product_key) AS total_products,
MAX(order_date) AS last_order,
DATEDIFF(month,MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query
GROUP BY customer_key, customer_number,name,age)

-- Final Result: Combine all customer results in one output.
SELECT 
customer_key,
name,
customer_number,
total_orders,
total_sales,
total_quantity_purchased,
total_products,
lifespan,

CASE 
	WHEN age < 20 THEN 'Under 20'
	WHEN age BETWEEN 20 AND 29 THEN '20-29'
	WHEN age BETWEEN 20 AND 29 THEN '30-39'
	WHEN age BETWEEN 40 AND 49 THEN '40-49'
	ELSE '50 and above'
END AS age_group,
CASE 
	WHEN lifespan >=12 AND total_sales > 5000
	THEN 'VIP'
	WHEN lifespan >=12 AND total_sales <= 5000
	THEN 'Regular'
	ELSE 'New'
END AS segments,
DATEDIFF(MONTH, last_order, GETDATE()) AS recency,
CASE 
	WHEN total_orders = 0 THEN 0
	ELSE total_sales / total_orders
END AS avg_order_value,
CASE 
	WHEN lifespan = 0 THEN total_sales
	ELSE total_sales / lifespan
END AS avg_monthly_spend
FROM customer_level_aggregations

-- Now the end user(Data Analyst) can quickly analyze the data from the view
SELECT 
age_group,
COUNT(customer_key) AS total_customers,
SUM(total_sales) AS total_sales
FROM gold.report_customer
GROUP BY age_group

SELECT 
segments,
COUNT(customer_key) AS total_customers,
SUM(total_sales) AS total_sales
FROM gold.report_customer
GROUP BY segments
