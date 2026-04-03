-- Cleaning Checklist for Each Field (DR_NO/ReportID):
-- 1. View Top 20 Reccords
-- 2. Check for NULLS
-- 3. Adjust Data Type
-- 4. Check for Blanks or Empty Strings
-- 5. Rename and Standardize Columns
--    5.a. Rename
--    5.b. Duplicates
--    5.c. Range
--    5.d. Invalid observations

-- Build 3-5 views for analysis




-- First, Create new dataset to clean while keeping the original intact:
SELECT *
INTO Crime2020.[dbo].[crime_clean]
FROM Crime2020.[dbo].[crime_raw];




-- A.1. View top 20 reccords of DR_NO (unique identifier for the crime report):
SELECT TOP 20 DR_NO
FROM crime_clean;

-- A.2. Check DR_NO for NULLS.
SELECT COUNT(*) AS NullCount
FROM crime_clean
WHERE DR_NO IS NULL;

-- A.3. Change to integer. Then, return DR_NO if it's an integer.
ALTER TABLE crime_clean
ALTER COLUMN DR_NO INT;

SELECT DR_NO,
       TRY_CAST(DR_NO AS INT) AS DR_NO_AsInt
FROM crime_clean;

-- A.4. No need to check for blanks here, as DR_NO was successfully converted to INT data type.


-- A.5. Rename and Standardize
-- A.5.a. Rename DR_NO
EXEC sp_rename 'crime_clean.DR_NO', 'ReportID', 'COLUMN';
--CHECK
SELECT TOP 20 crime_clean.ReportID
FROM crime_clean;

-- A.5.b. Duplicates: “Group all rows by ReportID, count how many times each one appears, and show me only the ones that appear more than once.”
SELECT ReportID, COUNT(*)
FROM crime_clean
GROUP BY ReportID
HAVING COUNT(*) > 1;

-- A.5.c. Check Range
SELECT MIN(ReportID) AS MIN, MAX(ReportID) AS MAX
FROM crime_clean;

-- A.5.d. Invalid observations 
-- Negatives
SELECT *
FROM crime_clean
WHERE ReportID <= 0;
--View the reccords with an ID under six digits to see if they are old
SELECT *
FROM crime_clean
WHERE ReportID < 100000;
-- It looks like the only possible connection is that these are vehicle related crimes. Not particualrly important for ReportID. All different dates and places.
-- Next check higher end: Ids over eight didgits
SELECT *
FROM crime_clean
WHERE ReportID > 10000000;
-- Returns just over one million rows. Nothing to note here. ReportID seems truly random.
-- Although there are some missing values in the reccords with a ReportID less under six digits, there is no reason to remove these reccords as of now.




-- CONCLUSION:
-- DR_NO was renamed to ReportID and changed from a string to an integer. 
-- There are no NULLS or duplicates. 
-- Although the range [817, 252104146] has a minimal amount of observations on the low end (those with less than six digits),  there seems to be no reason to eliminate reccords based on ReportID.














-- Date_Rptd(date crime was reported) is in M/D/YYYY 0:00 format. Check if they all have 0:00 as the time.
SELECT DISTINCT Date_Rptd
FROM crime_clean
WHERE Date_Rptd NOT LIKE '%0:00';


-- Clean Date_Rptd to reflect the YYYY/MM/DD format with new column(Date_Only). Drop time because they are all 0:00.
First create Date_Only Column
ALTER TABLE crime_clean
ADD Date_Only DATE;

-- 101 represents MM/DD/YYYY format and is used to make sure the imput is interpreted correctly and then changed to DATETIME format MM/DD/YYYY with no time.
UPDATE crime_clean
SET Date_Only = CAST(CONVERT(DATETIME, Date_Rptd, 101) AS DATE);

-- CHECK format
SELECT TOP 10 Date_Rptd, Date_Only
FROM crime_clean;


-- Rename Date_Only so it shows it was the date it was reported
EXEC sp_rename 'crime_clean.Date_Only', 'ReportDate', 'COLUMN';

SELECT * 
FROM crime_clean;