/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

--Determine the first and last order and total duration in months. 
-- Also, find the youngest and oldest customers based on birthdate.
SELECT 
  MIN(order_date) AS first_order_date,
  MAX(order_date) AS last_oreder_date,
  DATEDIFF(year, MIN(order_date),MAX(order_date)) AS date_range,
  DATEDIFF(YEAR, MIN(order_date), GETDATE()) AS oldest_customer,
  DATEDIFF(YEAR,MAX(order_date), GETDATE()) AS youngest_customer,
FROM gold.fact_sales;
