-- BASE STATISTICS
SELECT 
    COUNT(*) AS Total_Records, 
    COUNT(DISTINCT Invoice_ID) AS Unique_Invoices,
    COUNT(DISTINCT Branch) AS Unique_Branches, 
    COUNT(DISTINCT City) AS Unique_Cities
FROM sales_clean;

-- SALES PERFORMANCE
SELECT 
    SUM(Total) AS Total_Revenue, 
    AVG(Total) AS Avg_Sale, 
    MAX(Total) AS Max_Sale
FROM sales_clean;

-- SALES PERFORMANCE BY BRANCHES
SELECT 
    Branch, 
    City, 
    SUM(Total) AS Total_Sales, 
    COUNT(*) AS Total_Transactions
FROM sales_clean
GROUP BY Branch, City
ORDER BY Total_Sales DESC;

-- SALES TREND PER DAY
SELECT 
    Date, 
    SUM(Total) AS Daily_Sales
FROM sales_clean
GROUP BY Date
ORDER BY Date;

-- BEST SHOPPING TIME(HOUR)
SELECT 
    HOUR(Time) AS Hour, 
    COUNT(*) AS Transactions
FROM sales_clean
GROUP BY Hour
ORDER BY Transactions DESC;

-- BEST SELLING PRODUCT LINE
SELECT 
    Product_line, 
    COUNT(*) AS Sales_Count, 
    SUM(Total) AS Total_Sales
FROM sales_clean
GROUP BY Product_line
ORDER BY Total_Sales DESC;

SELECT 
    Customer_type, 
    COUNT(*) AS Total_Customers, 
    AVG(Total) AS Avg_Spending
FROM sales_clean
GROUP BY Customer_type;

-- CUSTOMER SALES BASED ON GENDER
SELECT 
    Gender, 
    COUNT(*) AS Total_Customers, 
    AVG(Total) AS Avg_Spending
FROM sales_clean
GROUP BY Gender;
