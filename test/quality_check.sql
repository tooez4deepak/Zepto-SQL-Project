-----------------------------------------------------------
-- 1️⃣ Check and clean the 'mrp' column in the bronze layer
-- This query checks if 'mrp' values are numeric.
-- If not numeric, it replaces them with 'n/a' for clarity.
-----------------------------------------------------------
SELECT 
    mrp,
    CASE 
        WHEN NOT ISNUMERIC(mrp) = 1 THEN 'n/a'
        ELSE mrp
    END AS mrp
FROM bronze.zepto;


-----------------------------------------------------------
-- 2️⃣ Get distinct 'outOfStock' values from the silver layer
-- Useful to check all unique stock status values.
-----------------------------------------------------------
SELECT DISTINCT
    outOfStock
FROM silver.zepto;


-----------------------------------------------------------
-- 3️⃣ Count total records in the silver layer
-- Basic data validation step to verify record count.
-----------------------------------------------------------
SELECT COUNT(*) 
FROM silver.zepto;


-----------------------------------------------------------
-- 4️⃣ Check 'outOfStock' data consistency in the bronze layer
-- This identifies how many records fall under each 'outOfStock' value.
-- Also validates if 'outOfStock' values are numeric or not.
-----------------------------------------------------------
SELECT DISTINCT
    outOfStock,
    COUNT(outOfStock) AS count_outOfStock,
    CASE 
        WHEN ISNUMERIC(outOfStock) = 1 THEN 'TRUE'
        ELSE outOfStock
    END AS outOfStockType
FROM bronze.zepto
GROUP BY outOfStock;


-----------------------------------------------------------
-- 5️⃣ Count number of records per 'outOfStock' category
-- in the silver layer for comparison with bronze.
-----------------------------------------------------------
SELECT 
    outOfStock,
    COUNT(srl_number) AS total_records
FROM silver.zepto
GROUP BY outOfStock;


-----------------------------------------------------------
-- 6️⃣ Identify duplicate product names in bronze layer
-- Lists all product names appearing more than once,
-- which helps detect duplicate or redundant records.
-----------------------------------------------------------
SELECT 
    name,
    COUNT(name) AS duplicate_count
FROM bronze.zepto
GROUP BY name
HAVING COUNT(name) > 1
ORDER BY COUNT(name) DESC;


-----------------------------------------------------------
-- 7️⃣ Check for MRP values containing commas
-- Such values might indicate improper formatting (e.g., "1,000").
-- Non-standard entries are marked as 'N/A'.
-----------------------------------------------------------
SELECT 
    mrp,
    CASE 
        WHEN mrp LIKE '%,%' THEN 'N/A'
        ELSE mrp
    END AS cleaned_mrp
FROM bronze.zepto
GROUP BY mrp;


-----------------------------------------------------------
-- 8️⃣ Identify invalid pricing data in the silver layer
-- Fetches all records where MRP or discountedSellingPrice is 0,
-- which may indicate data errors or missing values.
-----------------------------------------------------------
SELECT 
    *
FROM silver.zepto
WHERE mrp = 0 
   OR discountedSellingPrice = 0;


-----------------------------------------------------------
-- 9️⃣ Delete invalid records with zero MRP
-- Removes all records from silver layer where MRP = 0.
-- ⚠️ Be cautious: this is a permanent delete.
-----------------------------------------------------------
DELETE FROM silver.zepto
WHERE mrp = 0;
