#  Crime Pattern & Hotspot Analysis Using SQL

## Project Overview



---
#  Files

## 📂 Cleaning.DR_NO.sql  
**Field:** DR_NO → ReportID  

- The dataset crime_raw was duplicated with the new name crime_clean for the purposes of cleaning the data and preserving its original form.

- DR_NO was renamed to ReportID and changed from a string to an integer. There are no NULLS or duplicates. Although the range [817, 252104146] has a minimal amount of observations on the low end (those with less than six digits), there seems to be no reason to eliminate reccords based on ReportID.



---

## Objective

The objective of this project is to:

* Analyze crime incident data using SQL
* Identify spatial and temporal patterns
* Detect high-risk areas
* Generate insights that support data-driven decision-making in crime prevention

---

## 📊 Dataset

* Source: Kaggle Crime Dataset
* Link: https://www.kaggle.com/datasets/ishajangir/crime-data/data
* Description: This dataset contains reported crime incidents including location, time, and type of offense.

---

## 🛠 Tools & Technologies

* SQL Server
* Excel / CSV (data preview)
* 

---

## 🧹 Data Cleaning

Steps taken to prepare the data:

* Removed null or missing values
* Standardized date and time formats
* Cleaned inconsistent crime type labels
* Verified location data integrity

---

## 🔍 Exploratory Data Analysis (EDA)

Key areas explored:

* 
* 
* 

---

## 📈 Key Questions

1. Where should law enforcement focus patrols based on peak crime times(day, week, month, season)?
2. What are the most common crime types and which are are driving overall crime rates the most?
3. Are there correlations between location and type of crime?
4. Are there emerging trends that indicate a shift in crime patterns(from 2020 to now)?

---

## 🧠 Advanced Analysis

* Which areas consistently rank in the top 5 for crime? (window functions)
* Identifying trends over time (last key question)
* Comparing crime patterns across locations

---

## 📊 Key Insights

* 
* 
* 

---

## 📌 Conclusion



---

## 🚀 Future Improvements

* Add geospatial mapping (heatmaps)
* Build a dashboard (Tableau/Power BI)
* Perform predictive analysis

---

## 📂 Project Structure

* /data → raw dataset
* /sql → SQL queries
* /results → outputs/screenshots
* README.md → project documentation

---
