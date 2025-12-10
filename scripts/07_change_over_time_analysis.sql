/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyzing sales trend over time
SELECT 
  YEAR(order_date) AS order_year,
  SUM(sales_amount) AS total_sales,
  COUNT(customer_key) as total_customers,
  SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY 
  total_sales DESC,
  total_customers,
  total_quantity;

-- Analyzing seasonality of sales
SELECT 
  MONTH(order_date) AS order_month,
  SUM(sales_amount) AS total_sales,
  COUNT(customer_key) as total_customers,
  SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

-- DATETRUNC()
SELECT 
  DATETRUNC(month,order_date) AS order_date,
  SUM(sales_amount) AS total_sales,
  COUNT(customer_key) as total_customers,
  SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month,order_date)
ORDER BY DATETRUNC(month,order_date);
