-- Q4. Find all products where MRP is greater than €500 and discount is less than 10%.

SELECT DISTINCT
	name,
	mrp,
	discountPercent
FROM gold.zepto
-- Retrieve unique products with a high MRP and minimal discount
WHERE mrp > 500 AND discountPercent < 10
ORDER BY 
	mrp DESC,             -- Prioritize products with highest price
	discountPercent DESC; -- Among those, show higher discounts first