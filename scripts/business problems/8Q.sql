--Q8. What is the Total Inventory Weight Per Category

SELECT
	Category,
	-- Calculate total weight per category by multiplying unit weight with available quantity
	SUM(weightInGms * availableQuantity) AS total_weight
FROM gold.zepto
GROUP BY Category
ORDER BY total_weight; -- Sort categories from lowest to highest total weight