--Question 1: Achieving 1NF (First Normal Form)
-- Create a new 1NF-compliant table
CREATE TABLE OrderDetails_1NF AS
SELECT 
    OrderID, 
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',', -1)) AS Product,
    1 AS Quantity -- Assuming default quantity of 1 for each product
FROM 
    ProductDetail
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) numbers
    ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
ORDER BY 
    OrderID, Product;




--Question 2: Achieving 2NF (Second Normal Form)
-- Create Orders table (removing partial dependency)
CREATE TABLE Orders AS
SELECT DISTINCT 
    OrderID, 
    CustomerName
FROM 
    OrderDetails;

-- Create OrderItems table (fully dependent on composite key)
CREATE TABLE OrderItems AS
SELECT 
    OrderID, 
    Product, 
    Quantity
FROM 
    OrderDetails;

-- Add primary keys to ensure data integrity
ALTER TABLE Orders ADD PRIMARY KEY (OrderID);
ALTER TABLE OrderItems ADD PRIMARY KEY (OrderID, Product);
