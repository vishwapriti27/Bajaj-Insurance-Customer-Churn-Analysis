# Bajaj-Insurance-Customer-Churn-Analysis

# Project Demo

https://github.com/user-attachments/assets/cacb54e8-f235-4bf7-86bf-6c89808bed97

# Introduction:

This project analyzes customer churn behavior for Bajaj Finserv insurance products (Life, Health, Travel, and Pocket Insurance).
The goal is to identify key churn drivers and provide data-driven retention strategies to improve customer behaviour.

Asuming, Bajaj Finserv faces high customer churn, especially for short-term insurance products like Travel & Pocket Insurance and wants to analyse its customers data to gain insights and make informed decisions. 

## The business challenge:
How can Bajaj Finserv provide personalized, affordable, and accessible insurance solutions to a diverse customer base across India while improving customer retention through digital transformation?

##  I identified the following questions as important for their customer churn analysis:

. Why customer is churning?

. What factor lead to churn?

. In which occupations/locations/Income customer churn more?

. Is there high-value customer like (Business Owner, IT professionals) also churning?

. In which Bajaj Insurance Product customer most likely to churn? And why?

. Who are at high-risk? and how to prevent them?

. Is lower income customer paying more for short-term insurance plan which leads to churn?

## Workflow follow in this customize project is :

Tools & Tech: 

Python (Pandas, NumPy) – Data Generation, Cleaning & EDA

SQL (MySQL) – Churn rate analysis & outlier handling

Power BI – Interactive dashboards for churn insights

Data Collection & Preparation:

Step 1:

I explored Bajaj Finserv official website to understand real product offerings, such as Life Insurance, Health Insurance with coverage values, Travel Insurance with pricing based on age & travel days, Pocket Insurance with micro-coverage options.

Step 2:

From the website, I collected core product variables that influence pricing & churn:

Customer demographics: Age, Gender, IncomeGroup, Occupation, LocationType

Product Type (Life, Health, Travel, Pocket Insurance)

Engagement: PagesViewed, BrowsingTime, SessionDuration, ClickedOffer

Coverage Amount & Premium Amount (realistic values mapped from Bajaj plans)

Churn indicators: PolicyRenewed, Churned

Step 3:

Created a synthetic dataset (1,000 rows) using Python (NumPy & Pandas) scripts.

Ensured realistic correlations:

Age → Occupation → Income Group → Premium

Product Type → Coverage Amount → Premium

Region Tier & Location Type → Churn Probability

Added business-driven noise like outliers & missing values to mimic real-world data quality issue.

Step 4:

Data Cleaning & Feature Engineering

Filled missing values based on Age, Occupation, Income Group.

Removed extreme outliers beyond business logic thresholds.

Created new derived features using Python scripts

Chruned based on business problem

Churn Risk Score & Churn risk level(High/Medium/Low Churn Segments)

Step 5:

Once data is transformed and ready for analysis, load it into the Power BI Desktop application by establishing a connection with the MySQL database. After importing data perform exploratory data analysis to find trends and patterns within data. 
Create interactive dashboards focusing on different aspects like customer churn overview by (Product, Region, Income Group), Churn Risk Segmentation, Retention trend. Used visuals like bar chart, doughnut chart, and line chart to visualise the data and slicers to apply filters and make the dashboard interactive. At the end proposed insights & suggestions to reduce customer churn of Bajaj Finserv.


This project aims to provide the Bajaj Finserv with actionable insights that can help them make informed decisions about their 10–15% churn reduction, 20% higher renewals for Travel & Pocket Insurance, and Revenue protection for high-value urban customers.



