--Q7. Group the products into categories like Low, Medium, Bulk.

SELECT DISTINCT 
	name,
	weightInGms,
	-- Categorize products based on their weight for segmentation or analysis
	CASE
		WHEN weightInGms < 1000 THEN 'Low'
		WHEN weightInGms < 5000 THEN 'Medium'
		ELSE 'Bulk'
	END AS products_into_categories
FROM gold.zepto;