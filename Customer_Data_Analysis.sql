CREATE DATABASE db_bajaj;

USE db_bajaj;

-- import table from local device

SHOW TABLES;

DESC real_bajaj_insurance_data;

-- Fetching all records from the table

SELECT * FROM real_bajaj_insurance_data;

-- Modifying table column name and their datatypes

ALTER TABLE real_bajaj_insurance_data
MODIFY COLUMN PremiumAmount int;


ALTER TABLE real_bajaj_insurance_data
MODIFY COLUMN PolicyRenewed bool;

ALTER TABLE real_bajaj_insurance_data
MODIFY COLUMN Churned INT;


-- Updating the records in the table

UPDATE real_bajaj_insurance_data
SET PolicyRenewed = CASE WHEN PolicyRenewed = 'Yes' THEN 1 else 0 end;

UPDATE real_bajaj_insurance_data
SET Churned = CASE WHEN Churned = 'Yes' THEN 1 else 0 end;

UPDATE real_bajaj_insurance_data
set Gender = 'Female'
where Occupation = 'Housewife';


-- Data Cleaning & Handling NULL values

""" Assign IncomeGroup values based on real business context such as if occupation is 'Student' and 'Housewife' 
then Incomegroup should be 'lower' and so on. """

UPDATE bajaj_insurance_data
SET IncomeGroup = 'Lower', MaritalStatus = 'Single'
WHERE Occupation = 'Student' OR IncomeGroup is null OR MaritalStatus is null;

UPDATE bajaj_insurance_data
SET IncomeGroup = 'Lower', MaritalStatus = 'Married'
WHERE Occupation = 'Housewife' OR IncomeGroup is null OR MaritalStatus is null;


UPDATE bajaj_insurance_data
SET IncomeGroup = 'Middle', MaritalStatus = 'Married'
WHERE Occupation = 'Teacher' OR IncomeGroup is null or MaritalStatus is null;


UPDATE bajaj_insurance_data
SET IncomeGroup ='Middle'
WHERE Occupation = 'Freelancer' OR IncomeGroup is null;

UPDATE bajaj_insurance_data
SET IncomeGroup ='Middle'
WHERE Occupation = 'Retired' OR IncomeGroup is null;

UPDATE bajaj_insurance_data
SET IncomeGroup ='Upper'
WHERE Occupation = 'Business Owner' OR IncomeGroup is null;

UPDATE bajaj_insurance_data
SET IncomeGroup ='Upper'
WHERE Occupation = 'IT Professional' OR IncomeGroup is null;

UPDATE bajaj_insurance_data
SET IncomeGroup ='Upper'
WHERE Occupation = 'Engineer' OR IncomeGroup is null;


-- Handling NULL values in Marital Status column. assining values based on mode analysis. 

WITH ranked AS (
SELECT *, ROW_NUMBER() OVER (ORDER BY CustomerID) AS rn,
count(*) over() as cnt
FROM bajaj_insurance_data
where MaritalStatus is null OR occupation = 'Teacher'
)
UPDATE bajaj_insurance_data AS b
JOIN ( SELECT CustomerID, rn, cnt,
CASE WHEN rn <= FLOOR(cnt * 0.10) THEN 'Single' ELSE 'Married' END AS new_status
FROM ranked) AS r
ON b.CustomerID = r.CustomerID
SET b.MaritalStatus = r.new_status;


WITH ranked AS (
SELECT *, ROW_NUMBER() OVER (ORDER BY CustomerID) AS rn
FROM bajaj_insurance_data
where MaritalStatus is null OR occupation = 'Freelancer'
)
UPDATE bajaj_insurance_data AS b
JOIN ranked AS r ON b.CustomerID = r.CustomerID
SET b.MaritalStatus = CASE WHEN r.rn % 2 = 1 THEN 'Single' ELSE 'Married' END;


WITH ranked AS (
SELECT *, ROW_NUMBER() OVER (ORDER BY CustomerID) AS rn,
count(*) over() as cnt
FROM bajaj_insurance_data
where MaritalStatus is null OR occupation = 'Retired'
)
UPDATE bajaj_insurance_data AS b
JOIN ( SELECT CustomerID, rn, cnt,
CASE WHEN rn <= FLOOR(cnt * 0.7) THEN 'Married' ELSE 'Widowed' END AS new_status
FROM ranked) AS r
ON b.CustomerID = r.CustomerID
SET b.MaritalStatus = r.new_status;

WITH ranked AS (
SELECT *, ROW_NUMBER() OVER (ORDER BY CustomerID) AS rn,
count(*) over() as cnt
FROM bajaj_insurance_data
where MaritalStatus is null OR occupation = 'Business Owner'
)
UPDATE bajaj_insurance_data AS b
JOIN ( SELECT CustomerID, rn, cnt,
CASE WHEN rn <= FLOOR(cnt * 0.05) THEN 'Widowed' 
WHEN rn >= FLOOR(cnt * 0.05) and rn <= FLOOR(cnt*0.10) THEN 'Single' ELSE 'Married' END AS new_status
FROM ranked) AS r
ON b.CustomerID = r.CustomerID
SET b.MaritalStatus = r.new_status;


WITH ranked AS (
SELECT *, ROW_NUMBER() OVER (ORDER BY CustomerID) AS rn
FROM bajaj_insurance_data
where MaritalStatus is null OR occupation = 'IT Professional'
)
UPDATE bajaj_insurance_data AS b
JOIN ranked AS r ON b.CustomerID = r.CustomerID
SET b.MaritalStatus = CASE WHEN r.rn % 2 = 1 THEN 'Single' ELSE 'Married' END;

WITH ranked AS (
SELECT *, ROW_NUMBER() OVER (ORDER BY CustomerID) AS rn
FROM bajaj_insurance_data
where MaritalStatus is null OR occupation = 'Engineer'
)
UPDATE bajaj_insurance_data AS b
JOIN ranked AS r ON b.CustomerID = r.CustomerID
SET b.MaritalStatus = CASE WHEN r.rn % 2 = 1 THEN 'Single' ELSE 'Married' END;



-- Analyzing key metrics for chustomer churn


-- Churned rate by Occupation

SELECT Occupation, COUNT(*) AS Total, 
       SUM(Churned) AS Churned, 
       ROUND(SUM(Churned)*100.0 / COUNT(*), 2) AS ChurnRate
FROM real_bajaj_insurance_data
GROUP BY Occupation
ORDER BY ChurnRate DESC;

-- Churned rate by IncomeGroup

SELECT IncomeGroup, COUNT(*) AS Total, 
       SUM(Churned) AS Churned, 
       ROUND(SUM(Churned)*100.0 / COUNT(*), 2) AS ChurnRate
FROM real_bajaj_insurance_data
GROUP BY IncomeGroup
ORDER BY ChurnRate DESC;

-- Churned rate by ProductType

SELECT ProductType, COUNT(*) AS Total, 
       SUM(Churned) AS Churned, 
       ROUND(SUM(Churned)*100.0 / COUNT(*), 2) AS ChurnRate
FROM real_bajaj_insurance_data
GROUP BY ProductType
ORDER BY ChurnRate DESC;

-- Churned rate by LocationType

SELECT LocationType, COUNT(*) AS Total, 
       SUM(Churned) AS Churned, 
       ROUND(SUM(Churned)*100.0 / COUNT(*), 2) AS ChurnRate
FROM real_bajaj_insurance_data
GROUP BY LocationType
ORDER BY ChurnRate DESC;

-- Churned rate by Gender

SELECT Gender, COUNT(*) AS Total, 
       SUM(Churned) AS Churned, 
       ROUND(SUM(Churned)*100.0 / COUNT(*), 2) AS ChurnRate
FROM real_bajaj_insurance_data
GROUP BY Gender
ORDER BY ChurnRate DESC;

-- Churned rate by ChurnRiskLevel

SELECT ChurnRiskLevel, AVG(Churned) AS ChurnRate
FROM real_bajaj_insurance_data
GROUP BY ChurnRiskLevel
ORDER BY ChurnRate DESC;







