Select * from products

-- Categorize Products based on their Price

Select
productid,
productname,
category,
price,
CASE
	WHEN price < 50  Then 'Low'
	WHEN price >=50 AND price < 200 Then 'Medium'
	Else 'High'
END AS pricecategory
FROM products
