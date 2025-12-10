/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate total_sales for each month
-- runningtotal of  sales over time
SELECT 
  order_date,
  total_sales,
  SUM(total_sales) OVER(PARTITION BY order_date ORDER BY total_sales) AS running_sales,
  AVG(total_sales) OVER(PARTITION BY order_date ORDER BY total_sales) AS moving_average
FROM(
SELECT 
  DATETRUNC(month,order_date) AS order_date, -- DATETRUNC(year,order_date)
  SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month,order_date))t --DATETRUNC(year,order_date)
