-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT
	name,
	weightInGms,
	discountedSellingPrice,
	-- Compute unit price per gram and round to 2 decimal places
	ROUND(weightInGms / discountedSellingPrice, 2) AS price_per_grams
FROM gold.zepto
WHERE weightInGms >= 100  -- Exclude lightweight products for meaningful unit pricing
ORDER BY price_per_grams; -- Sort by price efficiency (lowest cost per gram first) 