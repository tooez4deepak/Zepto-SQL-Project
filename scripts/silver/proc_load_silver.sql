/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/

-- Transforms and loads cleaned data from 'bronze.zepto' into 'silver.zepto', with error handling and runtime logging

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    BEGIN TRY 
        DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
        SET @batch_start_time = GETDATE();

        -- Logging the start of the silver layer load
        PRINT '=======================================';
        PRINT '============Silver Layer===============';
        PRINT '=======================================';
        PRINT '==========Loading zepto table==========';

        SET @start_time = GETDATE();
        TRUNCATE TABLE silver.zepto;

        -- Insert transformed and type-cast data from bronze layer into silver layer
        INSERT INTO silver.zepto (
            Category,	
            name,	
            mrp,	
            discountPercent,	
            availableQuantity,	
            discountedSellingPrice,	
            weightInGms,	
            outOfStock,	
            quantity
        )
        SELECT 
            CASE 
                WHEN Category LIKE '"%' THEN SUBSTRING(Category, CHARINDEX('"', Category) + 1, LEN(Category))
                ELSE Category
            END AS category,-- Remove leading quotes from Category if present
            REPLACE(name, '"', '') AS name,
            COALESCE(TRY_CAST(
                CASE 
                  WHEN mrp LIKE '%,%' THEN RIGHT(mrp, CHARINDEX(',', REVERSE(mrp)) - 1)
                  ELSE mrp
                END AS INT
            ),0)/ 100 AS mrp, -- Strip commas from numeric fields and convert to INT
            COALESCE(TRY_CAST(
                CASE 
                  WHEN discountPercent LIKE '%,%' THEN RIGHT(discountPercent, CHARINDEX(',', REVERSE(discountPercent)) - 1)
                  ELSE discountPercent
                END AS INT
            ),0) AS discountPercent, 
            TRIM(availableQuantity) AS availableQuantity,-- Trim spaces and cast values appropriately
            round(TRIM(discountedSellingPrice),2)/100 AS discountedSellingPrice,
            TRIM(weightInGms) AS weightInGms,
            CASE 
                  WHEN ISNUMERIC(outOfStock) = 1 THEN 'TRUE'
                  ELSE outOfStock
                END AS outOfStock,-- Handle non-numeric or NULL outOfStock values
            TRY_CAST(
                CASE 
                  WHEN quantity LIKE '%,%' THEN RIGHT(quantity, CHARINDEX(',', REVERSE(quantity)) - 1)
                  ELSE quantity
                END AS INT
            ) AS quantity
        FROM bronze.zepto;
        SET @end_time = GETDATE();
        PRINT 'Load Duration =' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
        PRINT '---------------------------------------';

        -- Print total procedure execution time
        PRINT '=======================================';
        SET @batch_end_time = GETDATE();
        PRINT 'Total Load Duration =' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' second';
        PRINT '=======================================';

    END TRY
    BEGIN CATCH
        -- Output detailed error message
        PRINT '=======================================';
        PRINT '============ERROR MESSAGE==============';
        PRINT '=======================================';
        PRINT 'ERROR MESSAGE OCCURRED =' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER OCCURRED =' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR LINE OCCURRED =' + CAST(ERROR_LINE() AS NVARCHAR);
    END CATCH
END;

GO

-- Execute the silver layer data load
EXEC silver.load_silver;