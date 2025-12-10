# SQL EDA and Advanced Data Analysis

This repository contains a complete SQL-based Exploratory Data Analysis (EDA) and advanced analytical workflow using a star-schema dataset. The goal is to understand the database structure, explore dimensions and measures, analyze business performance, and create reusable reporting views.

---

## What’s Included

### 1. Database Exploration
Basic inspection of tables, columns, naming conventions, and constraints using `INFORMATION_SCHEMA`.

### 2. Dimension Exploration
Understanding how customers, products, categories, and regions are structured:
- Countries where customers belong  
- Product category and subcategory granularity  
- Date boundaries and customer timelines  

### 3. Measure Exploration
Calculation of essential business metrics:
- Total sales  
- Total quantity sold  
- Average selling price  
- Total orders  
- Total products  
- Total customers  
- Customers who placed orders  

### 4. Magnitude & Comparison Analysis
Comparing metrics across different groups:
- Customers by country  
- Customers by gender  
- Products by category  
- Revenue by category  
- Sold items by country  

### 5. Ranking Analysis
Identifying top/bottom performers:
- Best and worst products  
- Top customers by revenue  
- Customers with the fewest orders  

### 6. Trend Analysis
Studying changes over time:
- Yearly sales trends  
- Monthly seasonality  
- Cumulative metrics (running totals, moving averages)

### 7. Performance Analysis
Evaluating product performance against:
- Historical averages  
- Previous year sales  
- Year-over-year growth or decline  

### 8. Customer Segmentation
Grouping customers as:
- VIP  
- Regular  
- New  
Based on order frequency, spending, and lifespan.

### 9. Reporting Views
Ready-made analytical views for simplified reporting:

#### `gold.report_customer`
Customer-level metrics: total orders, sales, quantity, lifespan, recency, average order value, and customer segments.

#### `gold.report_products`
Product-level metrics: total sales, quantity, customers, lifespan, performance segments, and revenue patterns.

These views remove the need for complex joins and allow faster analysis.

---

## Purpose

This project provides a practical, end-to-end reference for performing SQL EDA and advanced business analysis. It can be used for learning, teaching, or powering BI dashboards.

---
