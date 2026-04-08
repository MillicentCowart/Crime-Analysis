-- Cleaning Checklist for Each Field (Part_1-2):
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


-- Part_1-2 is a crime classification. 1 for serious crimes, 2 for less serious crimes. 


-- 1. View the top 20 records.
SELECT TOP 20 [Part_1-2]
FROM crime_clean;



-- 2. Check for NULLs. 
SELECT COUNT(*) AS NullCount
FROM crime_clean
WHERE [Part_1-2] IS NULL; -- No NULLs


-- 3. Change to int.
ALTER TABLE crime_clean
ALTER COLUMN [Part_1-2] INT;
-- Return original column and casted column (Success if INT).
SELECT [Part_1-2],
       TRY_CAST([Part_1-2] AS INT) AS [Part_1-2_AsInt]
FROM crime_clean
ORDER BY [Part_1-2_AsInt]; -- ASC order puts NULLs (non-integer values) at the top.


-- 4. There is no need to check for blanks, as this is a field with the data type INT.


-- 5.b. Duplicates are expected. Only two observations.
-- 5.c. Field is binary. 1 or 2. 
-- 5.d. View counts to validate that there are no invalid observations. 
SELECT [Part_1-2], COUNT([Part_1-2]) AS CrimeClassCount
FROM crime_clean
GROUP BY [Part_1-2]
ORDER BY [Part_1-2];--looks good, only two observations 1 or 2.

-- 5.a. Rename [Part_1-2] to CrimeClass
EXEC sp_rename 'crime_clean.[Part_1-2]', 'CrimeClass', 'COLUMN';
