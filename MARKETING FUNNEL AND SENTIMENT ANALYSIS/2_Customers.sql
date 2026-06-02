select * from customers
select * from geography

-- Enhance Customer Data with Geographic Information

SELECT c.customerid, c.customername, c.email, c.gender, c.age, c.geographyid,
g.country, g.city
FROM customers as c
LEFT JOIN geography as g ON c.geographyid = g.geographyid