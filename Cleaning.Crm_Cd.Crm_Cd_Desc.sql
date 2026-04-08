-- Cleaning Checklist for Each Field (Crm_Cd and Crm_Cd_Desc):
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

-- Crm_Cd is type of crime numeric code.
-- Crm_Cd_Desc is description of crime type 

-- 1. View Top 20 records 
SELECT TOP 20 Crm_Cd, Crm_Cd_Desc
FROM crime_clean;


-- View count of each crime description and crime code.
SELECT Crm_Cd AS Code, 
       COUNT(Crm_Cd) AS CodeCount, 
	   Crm_Cd_Desc AS CodeDescription,
	   COUNT(Crm_Cd_Desc) AS CodeDescCount
FROM crime_clean
GROUP BY Crm_Cd, Crm_Cd_Desc
ORDER BY CodeDescription;

-- 140 crime codes with descriptions.
-- It looks like all code counts match code description counts. 

-- Start grouping crime code descriptions to lower the different crime types. Lots of duplicate names and extra characters like "

-- "ASSAULT WITH DEADLY WEAPON
UPDATE crime_clean
SET Crm_Cd_Desc = TRIM(REPLACE(Crm_Cd_Desc, '"', ''))
WHERE Crm_Cd_Desc LIKE '%ASSAULT WITH DEADLY WEAPON%';--remove records with " or extra spaces. 
--                                                      Only in records that at least have this part of the string: ASSAULT WITH DEADLY WEAPON
-- Check with select statement below.
SELECT Crm_Cd_Desc AS CodeDescription,
	   COUNT(Crm_Cd_Desc) AS CodeDescCount
FROM crime_clean
GROUP BY Crm_Cd_Desc
ORDER BY CodeDescription;




-- REPLACE anything like 'BUNCO' with BUNCO.
UPDATE crime_clean
SET Crm_Cd_Desc = 'BUNCO'
WHERE Crm_Cd_Desc LIKE '%BUNCO%';
-- BEASTIALITY
UPDATE crime_clean
SET Crm_Cd_Desc = 'BEASTIALITY'
WHERE Crm_Cd_Desc LIKE '%BEASTIALITY%';
-- BURGLARY
UPDATE crime_clean
SET Crm_Cd_Desc = 'BURGLARY'
WHERE Crm_Cd_Desc LIKE '%BURGLARY%';
-- CREDIT CARDS
UPDATE crime_clean
SET Crm_Cd_Desc = 'CREDIT CARDS'
WHERE Crm_Cd_Desc LIKE '%CREDIT CARDS%';
-- DEFRAUDING INNKEEPER/THEFT OF SERVICES
UPDATE crime_clean
SET Crm_Cd_Desc = 'DEFRAUDING INNKEEPER/THEFT OF SERVICES'
WHERE Crm_Cd_Desc LIKE '%DEFRAUDING INNKEEPER/THEFT OF SERVICES%';
-- DRUGS
UPDATE crime_clean
SET Crm_Cd_Desc = 'DRUGS'
WHERE Crm_Cd_Desc LIKE '%DRUGS%';
-- EMBEZZLEMENT
UPDATE crime_clean
SET Crm_Cd_Desc = 'EMBEZZLEMENT'
WHERE Crm_Cd_Desc LIKE '%EMBEZZLEMENT%';
-- LETTERS
UPDATE crime_clean
SET Crm_Cd_Desc = 'LETTERS'
WHERE Crm_Cd_Desc LIKE '%LETTERS%';
-- MANSLAUGHTER
UPDATE crime_clean
SET Crm_Cd_Desc = 'MANSLAUGHTER'
WHERE Crm_Cd_Desc LIKE '%MANSLAUGHTER%';
-- PICKPOCKET
UPDATE crime_clean
SET Crm_Cd_Desc = 'PICKPOCKET'
WHERE Crm_Cd_Desc LIKE '%PICKPOCKET%';
-- RAPE
UPDATE crime_clean
SET Crm_Cd_Desc = 'RAPE'
WHERE Crm_Cd_Desc LIKE '%RAPE%';
--REPLICA FIREARMS(SALE)
UPDATE crime_clean
SET Crm_Cd_Desc = 'REPLICA FIREARMS(SALE)'
WHERE Crm_Cd_Desc LIKE '%REPLICA FIREARMS(SALE%';
-- SEX
UPDATE crime_clean
SET Crm_Cd_Desc = 'SEX'
WHERE Crm_Cd_Desc LIKE '%SEX%';
-- SHOTS FIRED AT MOVING VEHICLE
UPDATE crime_clean
SET Crm_Cd_Desc = 'SHOTS FIRED AT MOVING VEHICLE'
WHERE Crm_Cd_Desc LIKE '%SHOTS FIRED AT MOVING VEHICLE%';
-- THEFT
UPDATE crime_clean
SET Crm_Cd_Desc = 'THEFT'
WHERE Crm_Cd_Desc LIKE '%THEFT%';
-- VANDALISM - FELONY ($400 & OVER
UPDATE crime_clean
SET Crm_Cd_Desc = 'VANDALISM'
WHERE Crm_Cd_Desc LIKE '%VANDALISM - FELONY ($400 & OVER%';
-- VEHICLE
UPDATE crime_clean
SET Crm_Cd_Desc = 'VEHICLE'
WHERE Crm_Cd_Desc LIKE '%VEHICLE%';
-- THIS TAKES IT FROM 140 to 98 crime code descriptions.

-- The rest can be kept as they are. All already strings, length 500.


-- Change Crm_Cd to INT and check for NULLs. Check the range and counts to validate that there are no invalid observations. 
ALTER TABLE crime_clean
ALTER COLUMN Crm_Cd INT;
-- Check conversion to INT and for NULLs
SELECT Crm_Cd,
       TRY_CAST(Crm_Cd AS INT) AS Crm_Cd_AsInt
FROM crime_clean
ORDER BY Crm_Cd_Asint;
-- Range and invalid observations check:
SELECT Crm_Cd, COUNT(Crm_Cd) AS CodeCount
FROM crime_clean
GROUP BY Crm_Cd
HAVING COUNT(Crm_Cd) > 1
ORDER BY Crm_Cd;


-- RENAME
EXEC sp_rename 'crime_clean.Crm_Cd_Desc', 'CrimeTypeDescription', 'COLUMN';
EXEC sp_rename 'crime_clean.Crm_Cd', 'CrimeTypeID', 'COLUMN';