/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    Create or replace the 'gold.zepto' view to enrich product data with a unique row 
    key and filter out entries with non-positive MRP
    This script creates views for the Gold layer in the Zepto_sql_project. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- Drop the existing view if it already exists
IF OBJECT_ID('gold.zepto', 'v') IS NOT NULL
DROP VIEW gold.zepto;
GO

-- Define the new version of the 'gold.zepto' view
CREATE OR ALTER VIEW gold.zepto AS
SELECT
    ROW_NUMBER() OVER(ORDER BY s.quantity) AS srl_key, -- Generate a sequential key ordered by quantity
    s.Category,	
    s.name,	
    s.mrp,	
    s.discountPercent,			
    s.availableQuantity,	
    s.discountedSellingPrice,	
    s.weightInGms,	
    s.outOfStock,	
    s.quantity
FROM silver.zepto AS s
JOIN silver.zepto AS z
    ON s.srl_number = z.srl_number -- Redundant self-join unless additional z-based filters/joins are expected
WHERE s.mrp > 0; -- Exclude records with zero or negative MRP
GO

-- Query the resulting view to preview the gold layer output
SELECT * FROM gold.zepto;