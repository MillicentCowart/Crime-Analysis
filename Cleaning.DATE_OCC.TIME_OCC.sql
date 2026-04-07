-- Cleaning Checklist for Each Field (DATE_OCC and TIME_OCC):
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

-- A.1. View Top 20 Records
SELECT TOP 20 DATE_OCC, TIME_OCC
FROM crime_clean;
-- DATE_OCC reflects the date the crime occurred in M/D/YYYY 0:00 format
-- TIME_OCC reflects the time the crime occurred in HHMM format (24hr)

-- A.2. Check for NULLs in each field
SELECT COUNT(*) AS NullCount
FROM crime_clean
WHERE DATE_OCC IS NULL 
   OR TIME_OCC IS NULL;
-- No NULLs

-- A.3. Data Type
 
-- Repeat the same process as before with DR_NO. Check if all records in DATE_OCC show a time of 0:00. Then, change the format to DATE.
SELECT DISTINCT DATE_OCC
FROM crime_clean
WHERE DATE_OCC NOT LIKE '%0:00';-- ALL RECORDS SHOW 0:00

-- Clean DATE_OCC to reflect the YYYY/MM/DD format with a new column(DateOfCrime). Drop time because they are all 0:00.
ALTER TABLE crime_clean
ADD DateOfCrime DATE;

UPDATE crime_clean
SET DateOfCrime = CAST(CONVERT(DATETIME, DATE_OCC, 101) AS DATE);

ALTER TABLE crime_clean
DROP COLUMN DATE_OCC; 

-- CHECK
SELECT TOP 10 DateOfCrime
FROM crime_clean;

-- B.3. Data Type - TIME_OCC needs to change format because it was imported as a string. Change to HH:MM(24hr)
ALTER TABLE crime_clean
ADD TimeOfCrime TIME; -- add clean time of crime field

UPDATE crime_clean
SET TimeOfCrime = CAST(
    STUFF(RIGHT('0000' + TIME_OCC, 4), 3, 0, ':') 
    AS TIME
);--populate new field with TIME_OCC with the correct formatting

ALTER TABLE crime_clean
DROP COLUMN TIME_OCC; -- Drop the old field

-- CHECK
SELECT TOP 10 TimeOfCrime
FROM crime_clean;

-- A.4. Neither a string anymore. 

-- A.5.a. Both have already been renamed

-- A.5.b. No need to check for duplicates becasue it does not matter in the context of time or date.

-- A.5.c. Range DateOfCrime
SELECT MIN(DateOfCrime) AS MIN, MAX(DateOfCrime) AS MAX
FROM crime_clean;
-- The time range that this dataset covers is January 1, 2020, to March 28, 2025, for ReportDate.
-- The time range that this dataset covers is January 1, 2020, to March 27, 2025, for DateOfCrime.

-- B.5.c. Range TimeOfCrime
SELECT MIN(TimeOfCrime) AS MIN, MAX(TimeOfCrime) AS MAX
FROM crime_clean;
-- The range for TimeOfCrime is [00:01:00,23:59:00], or 12:01AM to 11:59PM as expected. 

-- A.5. The range reflects what is expected of date and time columns, so invalid observations should not exist. 

-- Conclusion
-- DATE_OCC was changed to DateOfCrime, and it reflects a YYYY-MM-DD format.
-- TIME_OCC was changed to TimeOfCrime in HH:MM(24hr) format.
-- NULLs have been checked for, and the range has been validated. 
-- The time range that this dataset covers is January 1, 2020, to March 28, 2025, for ReportDate.
-- The time range that this dataset covers is January 1, 2020, to March 27, 2025, for DateOfCrime.