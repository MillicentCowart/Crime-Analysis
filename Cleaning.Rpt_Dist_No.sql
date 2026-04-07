-- Cleaning Checklist for Each Field (Rpt_Dist_No):
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


-- Rpt_Dist_No is the reporting district number for the incident.


-- 1. Top 20 records:
SELECT TOP 20 Rpt_Dist_No
FROM crime_clean;


-- 2. Check for NULLs.
SELECT COUNT(*) AS NullCount
FROM crime_clean
WHERE Rpt_Dist_No IS NULL;
-- No NULLs


-- 3. Change to int.
ALTER TABLE crime_clean
ALTER COLUMN Rpt_Dist_No INT;
-- Return original column and casted column (Success if INT).
SELECT Rpt_Dist_No,
       TRY_CAST(Rpt_Dist_No AS INT) AS Rpt_Dist_No_AsInt
FROM crime_clean
ORDER BY Rpt_Dist_No_AsInt; -- ASC order puts NULLs (non-integer values) at the top.


-- 4. There is no need to check for blanks as this is a field with the data type INT. 


--  5.b–d. Range(101, 2199) can be seen in the previous select statement. Duplicates are expected(multiple reports per reporting district). 
-- View counts to validate that there are no invalid observations. 
SELECT Rpt_Dist_No, COUNT(Rpt_Dist_No) AS DistrictCount
FROM crime_clean
GROUP BY Rpt_Dist_No
ORDER BY Rpt_Dist_No;
-- Everything looks OK for data cleaning purposes, but some reporting districts have only a few reports, while others have thousands. Review this later.


-- 5.a Rename Rpt_Dist_No to ReportDistID
EXEC sp_rename 'crime_clean.Rpt_Dist_No', 'ReportDistID', 'COLUMN';
