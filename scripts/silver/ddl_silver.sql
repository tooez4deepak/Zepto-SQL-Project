/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    Recreate the 'silver.zepto' table to store cleaned and structured product 
    data for downstream use.
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
-- 

-- Drop the existing table if it already exists
IF OBJECT_ID('silver.zepto','U') IS NOT NULL
DROP TABLE silver.zepto;
GO

-- Create a structured version of the 'zepto' table in the 'silver' schema
CREATE TABLE silver.zepto (
    srl_number INT PRIMARY KEY IDENTITY(1,1), -- Auto-incremented unique identifier
	Category NVARCHAR(225),   -- Product category
    name VARCHAR(225),        -- Product name
    mrp INT,                  -- Maximum retail price
    discountPercent INT,      -- Discount percentage
    availableQuantity INT,    -- Inventory count
    discountedSellingPrice FLOAT, -- Price after applying discount
    weightInGms INT,          -- Weight of product in grams
    outOfStock  NVARCHAR(10),          -- Binary flag (e.g., 1 = out of stock, 0 = available)
    quantity INT,             -- Quantity per unit or transaction
    dwh_date DATETIME2 DEFAULT GETDATE() -- Data warehouse load timestamp
)