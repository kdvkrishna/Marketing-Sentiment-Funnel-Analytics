select * from customer_reviews

-- Formatting Reviews [Stripping Whitespace]

SELECT
reviewid, customerid, productid, reviewdate, rating,
REPLACE(reviewtext, '  ', ' ') AS review_text
FROM customer_reviews

