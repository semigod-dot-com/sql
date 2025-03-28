create table sales_clean_data
like supermarket_sales;

insert sales_clean_data
select * from supermarket_sales;
-- CREATED A NEW TABLE WEERE I WOULD BE DOING THE DATA CLEANNG ON 
ALTER TABLE sales_clean_data 
RENAME TO sales_clean ;

select * from sales_clean;
-- CHANGED THE NAME OF THE COLUMNS THAT HAD SPAES AND PUT IN '_'
ALTER TABLE sales_clean
RENAME COLUMN `Invoice ID` TO Invoice_ID,
RENAME COLUMN `Customer type` TO Customer_type,
RENAME COLUMN `Product line` TO Product_line,
RENAME COLUMN `Unit price` TO Unit_price,
RENAME COLUMN `Tax 5%` TO Tax_5,
RENAME COLUMN `gross income` TO Gross_Income;
-- changing the data type
ALTER TABLE sales_clean
MODIFY COLUMN Date DATE,
MODIFY COLUMN Time TIME,
MODIFY COLUMN Unit_price DECIMAL(10,2),
MODIFY COLUMN Tax_5 DECIMAL(10,2),
MODIFY COLUMN Total DECIMAL(10,2),
MODIFY COLUMN cogs DECIMAL(10,2),
MODIFY COLUMN Gross_Income DECIMAL(10,2),
MODIFY COLUMN Rating DECIMAL(3,1);
-- I HAD AN ERROR CAUSE OF THE DATE FORMAT SO I HAD TO change IT FIRST
ALTER TABLE sales_clean ADD COLUMN Date_Formatted DATE;
UPDATE sales_clean
SET Date_Formatted = STR_TO_DATE(Date, '%m/%d/%Y');
ALTER TABLE sales_clean 
DROP COLUMN Date, 
CHANGE COLUMN Date_Formatted Date DATE;
-- Deleting duplicates 
DELETE FROM sales_clean
WHERE Invoice_ID IN (
    SELECT Invoice_ID FROM (
        SELECT Invoice_ID, ROW_NUMBER() OVER (PARTITION BY Invoice_ID ORDER BY Date) AS row_num
        FROM sales_clean
    ) t
    WHERE row_num > 1
);

ALTER TABLE sales_clean
DROP COLUMN `gross margin percentage`;

SET @avg_rating = (SELECT AVG(Rating) FROM sales_clean);

UPDATE sales_clean
SET Rating = @avg_rating
WHERE Rating IS NULL;

select * from sales_clean


