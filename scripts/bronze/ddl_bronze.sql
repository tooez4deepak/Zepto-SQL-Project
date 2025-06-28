/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    Recreate the 'bronze.zepto' table to store raw product data, ensuring no previous version conflicts
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

-- Drop the table if it already exists in the 'bronze' schema
IF OBJECT_ID('bronze.zepto', 'U') IS NOT NULL
DROP TABLE bronze.zepto;
GO

-- Create a new 'bronze.zepto' table with basic product attributes
CREATE TABLE bronze.zepto (
    Category VARCHAR(225),  
    name VARCHAR(225),
    mrp VARCHAR(255), -- Maximum retail price; stored as text due to formatting variations
    discountPercent VARCHAR(50), -- Percentage value as string, e.g. '15%'
    availableQuantity   VARCHAR(50), -- Likely inventory stock value
    discountedSellingPrice  VARCHAR(50), -- Final price after applying discounts
    weightInGms VARCHAR(50), -- Weight in grams; stored as string for flexibility
    outOfStock  VARCHAR(50), -- Indicates availability status
    quantity VARCHAR(50) -- User-specified or standard product quantity
)
