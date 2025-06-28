--Q3. Calculate Estimated Revenue for each category

SELECT DISTINCT 
	Category,
	SUM(discountedSellingPrice * availableQuantity) AS Totalrevenue
FROM gold.zepto
-- Calculate total revenue per category by summing price × quantity
GROUP BY Category
ORDER BY Totalrevenue; -- Sort categories from lowest to highest total revenue