#  Crime Pattern & Hotspot Analysis Using SQL

## Project Overview


---

##  Key Questions

1. Where should law enforcement focus patrols based on peak crime times(day, week, month, season)?
2. What are the most common crime types, and which are driving overall crime rates the most?
3. Are there correlations between location and type of crime?
4. Are there emerging trends that indicate a shift in crime patterns(from 2020 to now)?

---

## Files in this Repository

- `Cleaning.DR_NO.sql` → Cleaning of DR_NO ➡️ ReportID  
- `Cleaning.Date_Rptd.sql` → Cleaning of Date_Rptd ➡️ ReportDate  
- `Cleaning.DATE_OCC.TIME_OCC.sql` → Cleaning of DATE_OCC ➡️ DateOfCrime and TIME_OCC ➡️ TimeOfCrime
- `Cleaning.AREA.AREA_NAME.sql` → Cleaning of AREA ➡️ LAPDdivisionID and AREA_NAME ➡️ LAPDdivision
- `Cleaning.Rpt_Dist_No.sql` → Cleaning of Rpt_Dist_No ➡️ ReportDistID
- `Cleaning.Part_1-2.sql` → Cleaning of Part_1-2 ➡️ CrimeClass 

---

## Objective

The objective of this project is to:

* Clean dataset fields and create organized views. 
* Answer key questions.

---

##  Dataset
- **Source:** Kaggle Crime Dataset Link: https://www.kaggle.com/datasets/ishajangir/crime-data/data
- **My Dataset:** crime_clean

## crime__clean Column Descriptions:
- **ReportID** → [INT]unique identifier for each report.
- **ReportDate** → [DATE]date crime was reported, YY/MM/DD. January 1, 2020, to March 28, 2025. 
- **DateOfCrime** → [DATE]date the crime occurred, YY/MM/DD. January 1, 2020, to March 27, 2025.
- **TimeOFCrime** → [TIME]time of crime, HH:MM, twenty-four hour format.
- **LAPDdivisionID** → [INT]numerical code for LAPD division. 
- **LAPDdivision** → [VARCHAR,500]name of LAPD division.
- **ReportDistID** → [INT]reporting district code number for the incident.
- **CrimeClass** → [INT]classification of seriousness of crime: 1 for serious, 2 for less serious.
---

##  Tools & Technologies

* SQL Server
* 
* 

---




---

##  Exploratory Data Analysis (EDA)

Key areas explored:

* 
* 
* 

---


##  Key Insights

* 
* 
* 

---

##  Conclusion



---

##  Future Improvements

* Add geospatial mapping (heatmaps)
* Build a dashboard (Tableau/Power BI)
* Perform predictive analysis


---
