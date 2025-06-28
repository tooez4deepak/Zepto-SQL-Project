-- Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT DISTINCT TOP 5
	Category,
	AVG(discountPercent) AS highest_avg_discount_percent
FROM gold.zepto
-- Compute the average discount percent for each category and retrieve the top 5 with the highest values
GROUP BY Category
ORDER BY highest_avg_discount_percent DESC; -- Rank by descending average discount