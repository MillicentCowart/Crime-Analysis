-- Cleaning Checklist for Each Field (AREA and AREA_NAME):
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


-- AREA - numeric code for geographical area
-- AREA_NAME - name of geographical area

-- A.1. View top 20 records.
SELECT TOP 20 AREA, AREA_NAME
FROM crime_clean;


-- A.2. Check for NULLS.
SELECT COUNT(*) AS NullCount
FROM crime_clean
WHERE AREA IS NULL
   OR AREA_NAME IS NULL; 
-- No NULLs 

-- A.3. Change AREA to int
ALTER TABLE crime_clean
ALTER COLUMN AREA INT;

-- Check if there are unique codes and names
-- Return AREA, AREA_NAME, and the count of each
SELECT AREA, COUNT(AREA) AS AreaCount, AREA_NAME, COUNT(AREA_NAME) AS AreaNameCount
FROM crime_clean
GROUP BY AREA,AREA_NAME
ORDER BY AREA;
-- No Mispelling or duplication with spaces in AREA_NAME
-- Each area code and area spelling has the same count.

-- B.3. AREA_NAME stays a string

-- A.4. No blanks or empty spaces per counts in SELECT statement.  ^^

-- A.5.a Rename
EXEC sp_rename 'crime_clean.AREA', 'LAPDdivisionID', 'COLUMN';
EXEC sp_rename 'crime_clean.AREA_NAME', 'LAPDdivision', 'COLUMN';

-- A.5.b Duplicates. In this context, it is expected to have duplicates. The report couldn't be logged twice because ReportID is unique.

-- A.5.c. The range can be viewed in SELECT statement above. Area codes 1-21, and their corresponding LAPD divisions.
-- A.5.c. Any invalid observations would have been shown in the above select statement, as it includes each observation and its count. 

-- Conclusion: AREA was changed to LAPDdivisionID, an integer. AREA_NAME was changed to LAPDdivision and kept as a string. Neither field contains NULLs. 
-- The absence of spelling errors, blanks, or extra spaces was verified by a select statement, which showed each area code and name along with the count of each.
-- The dataset contains data from all 21 LAPD divisions.