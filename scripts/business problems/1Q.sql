-- Q1. Find the top 10 best-value products based on the discount percentage.

SELECT TOP 10 
	name,
	mrp,
	discountPercent
FROM gold.zepto
-- Retrieve the top 10 products with the highest discount percentages
ORDER BY discountPercent DESC;