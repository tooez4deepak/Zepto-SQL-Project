--Q2. What are the Products with High MRP but Out of Stock

SELECT DISTINCT
	name,
	mrp
FROM gold.zepto
-- Retrieve unique products that are out of stock and Let suppose priced above ₹250
WHERE outofstock = 'TRUE' AND mrp > 250
ORDER BY mrp DESC; -- Sort results from highest to lowest MRP