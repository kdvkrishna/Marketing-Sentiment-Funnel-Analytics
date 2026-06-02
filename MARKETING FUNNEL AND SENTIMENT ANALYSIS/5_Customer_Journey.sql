select * from customer_journey

select distinct stage from customer_journey
-- Homepage, Productpage, Checkout
select distinct action from customer_journey
-- View, Click, Drop-off, Purchase
-- Customer Journey

-- CTE to Identify and Tag Duplicate Records

With DuplicateRecords AS (
SELECT 
journeyid, customerid, productid, visitdate, stage, action, duration,
ROW_NUMBER() OVER(
PARTITION BY customerid, productid, visitdate, stage, action
ORDER BY journeyid
) AS row_num
FROM customer_journey
)

SELECT *
FROM DuplicateRecords
WHERE row_num>1
ORDER BY journeyid


-- Outer query selects the final cleaned and standardized data
    
SELECT 
    journeyid,  
    customerid, 
    productid,  
    visitdate,  
    stage, 
    action,  
    COALESCE(duration, avg_duration) AS duration  -- Replaces missing durations with the average duration for the corresponding date
FROM 
    (
        -- Subquery to process and clean the data
        SELECT 
            journeyid, 
            customerid, 
            productid,  
            visitdate, 
            UPPER(stage) AS stage,  -- Converts Stage values to uppercase for consistency in data analysis
            action,  
            duration, 
            AVG(duration) OVER (PARTITION BY visitdate) AS avg_duration,  -- Calculates the average duration for each date, using only numeric values
            ROW_NUMBER() OVER (
                PARTITION BY customerid, productid, visitdate, UPPER(stage), action  
                ORDER BY journeyid  -- Orders by JourneyID to keep the first occurrence of each duplicate
            ) AS row_num  -- Assigns a row number to each row within the partition to identify duplicates
        FROM 
            customer_journey  
    ) AS subquery  
WHERE 
    row_num = 1;  -- Keeps only the first occurrence of each duplicate group identified in the subquery