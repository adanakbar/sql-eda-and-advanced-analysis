/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- It tells us from how many regions people buy.
SELECT 
	DISTINCT country
FROM gold.dim_customers;


-- It exposes the level of granularity of product and category
SELECT 
	DISTINCT category, 
	subcategory, 
	product_name
FROM gold.dim_products;
