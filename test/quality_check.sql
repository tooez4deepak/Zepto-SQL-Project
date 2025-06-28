select
mrp,
 CASE 
       WHEN  NOT ISNUMERIC(mrp) = 1  THEN 'n/a'
                  ELSE mrp
                END AS  mrp
from bronze.zepto

select DISTINCT
    outOfStock
from silver.zepto


select count(*) from silver.zepto

SELECT distinct
	outOfStock,
   count(outOfStock),
                CASE 
                  WHEN ISNUMERIC(outOfStock) = 1 THEN 'TRUE'
                  ELSE outOfStock
                END AS outOfStock 
FROM bronze.zepto
group by outOfStock

select 
	outOfStock,
	count(srl_number)
from silver.zepto
group by outOfStock


SELECT 
    name,
    count(name)
FROM bronze.zepto
group by name
having count(name) > 1
order by count(name) desc


select
mrp,
 CASE 
       WHEN mrp LIKE '%,%' THEN 'N/A'
                  ELSE mrp
                END AS  mrp
from bronze.zepto
group by mrp

select 
*
from silver.zepto
where mrp =0 or discountedSellingPrice = 0

DELETE FROM silver.zepto
where mrp = 0;