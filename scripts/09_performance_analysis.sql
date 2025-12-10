/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/


-- Analyze the yearly performance of products by comparing their sales
-- to both the average sales performance of the product and the previous year's sales
WITH yearly_product_sales AS
(
  SELECT
    YEAR(s.order_date) AS year,
    p.product_name,
    SUM(s.sales_amount) AS total_sales
  FROM gold.fact_sales s
  LEFT JOIN gold.dim_products p
    ON s.product_key = p.product_key
  WHERE order_date IS NOT NULL
  GROUP BY 
  YEAR(s.order_date),
  p.product_name
)

SELECT 
  order_year,
  product_name,
  current_sales,
  AVG(total_sales) OVER(PARTITION BY product_name) AS avg_sales,
  total_sales - AVG(total_sales) OVER(PARTITION BY product_name) AS avg_diff,
CASE 
	WHEN total_sales - AVG(total_sales) OVER(PARTITION BY product_name) < 0
	THEN 'Below Average'
	WHEN total_sales - AVG(total_sales) OVER(PARTITION BY product_name) > 0
	THEN 'Above Average'
	ELSE 'Equal to Average'
END AS Avg_performance,
  LAG(total_sales) OVER (PARTITION BY product_name ORDER BY year) AS previous_year_sale,
  total_sales - LAG(total_sales) OVER (PARTITION BY product_name ORDER BY year) AS prev_year_diff,
CASE
	WHEN total_sales - LAG(total_sales) OVER (PARTITION BY product_name ORDER BY year) > 0
	THEN 'Increase'
	WHEN total_sales - LAG(total_sales) OVER (PARTITION BY product_name ORDER BY year) < 0
	THEN 'Decrease'
	ELSE 'No Change'
END AS Performance_Improvement
FROM yearly_product_sales
ORDER BY 
  product_name,
  year;
FROM yearly_product_sales
ORDER BY product_name, year;
