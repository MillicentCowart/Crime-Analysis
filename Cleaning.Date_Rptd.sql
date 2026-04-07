-- Cleaning Checklist for Each Field (Date_Rptd):
-- 1. View Top 20 Records
-- 2. Check for NULLS
-- 3. Adjust Data Type
-- 4. Check for Blanks or Empty Strings
-- 5. Rename and Standardize Columns
--    5.a. Rename
--    5.b. Duplicates
--    5.c. Range
--    5.d. Invalid observations

-- Build 3-5 views for analysis


-- A.1. View top 20 records of Date_Rptd (Date report was recorded):
SELECT TOP 20 Date_Rptd
FROM crime_clean;

-- A.2. Check Date_Rptd for NULLS.
SELECT COUNT(*) AS NullCount
FROM crime_clean
WHERE Date_Rptd IS NULL;

-- A.3. Change data type from string to DATE.
-- Date_Rptd(date crime was reported) is in M/D/YYYY 0:00 format. Check if they all have 0:00 as the time.
SELECT DISTINCT Date_Rptd
FROM crime_clean
WHERE Date_Rptd NOT LIKE '%0:00';
-- Clean Date_Rptd to reflect the YYYY/MM/DD format with a new column(Date_Only). Drop time because they are all 0:00.
ALTER TABLE crime_clean
ADD Date_Only DATE;
UPDATE crime_clean
SET Date_Only = CAST(CONVERT(DATETIME, Date_Rptd, 101) AS DATE);
-- CHECK format
SELECT TOP 10 Date_Rptd, Date_Only
FROM crime_clean;

-- A.4. No Need to check for blanks

-- A.5.a. Rename Date_Only so it shows it was the date it was reported
EXEC sp_rename 'crime_clean.Date_Only', 'ReportDate', 'COLUMN';

-- A.5.b. Duplicates: no need to check because it is ok if more than one crime happens on a specific date. 

-- A.5.c Range
SELECT MIN(ReportDate) AS MIN, MAX(ReportDate) AS MAX
FROM crime_clean;
-- The time range that this dataset covers is January 1, 2020, to March 28, 2025.

-- A.5.d. DATE format should not have invalid observations. NULLS have already been checked. 

-- DROP Date_Rptd
ALTER TABLE crime_clean
DROP COLUMN Date_Rptd;

-- Conclusion
-- Date_Rptd(dropped) is now ReportDate in YYYY/MM/DD format. No NULLS or Duplicates. The data covers January 1, 2020, to March 28, 2025.
-- Times were excluded as they were all 0:00.