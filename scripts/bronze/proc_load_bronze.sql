/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    Loads product data from a CSV file into the 'bronze.zepto' table, with logging and error handling
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_zepto AS
BEGIN
    BEGIN TRY
        DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
        SET @batch_start_time = GETDATE();

        -- Visual header for logging
        PRINT '============================';
        PRINT '========BRONZE LAYER========';
        PRINT '============================';
        
        -- Begin timing the bulk load operation
        SET @start_time = GETDATE();
        PRINT 'Loading bronze zepto';

        -- Clear existing data before new load
        TRUNCATE TABLE bronze.zepto;

        -- Load data from CSV file into the bronze.zepto table
        BULK INSERT bronze.zepto
        FROM 'C:\Users\18dee\Documents\Zepto_SQL_Project\dateset\zepto_v2.csv'
        WITH (
            FIELDTERMINATOR = ',',  -- Separate fields by comma
            ROWTERMINATOR = '\n',   -- Rows are separated by newline
            FIRSTROW = 2,           -- Skip header row
            MAXERRORS = 100         -- Allow minor parsing issues
        );

        -- Log load duration
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+ ' second';
        PRINT '-----------------------';

        -- Log total batch duration
        PRINT '=================================';
        SET @batch_end_time = GETDATE();
        PRINT '>> Total Loading Duration:' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' second';
        PRINT '=================================';
    END TRY
    BEGIN CATCH
        -- Log detailed error information
        PRINT '===================================';
        PRINT '======== ERROR MASSAGE ===========';
        PRINT '===================================';
        PRINT 'ERROR OCCURED DURING EXECTUTION =' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBERS =' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR LINE =' + CAST(ERROR_LINE() AS NVARCHAR);
    END CATCH
END;

-- Execute the procedure to perform the data load
 EXEC bronze.load_zepto;
