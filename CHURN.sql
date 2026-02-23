Drop database churn_ibm;
CREATE DATABASE churn_ibm;
USE churn_ibm;
CREATE TABLE churn_data (
customerID VARCHAR(50),
gender VARCHAR(10),
SeniorCitizen VARCHAR(10),
Partner VARCHAR(10),
Dependents VARCHAR(10),
tenure INT,
PhoneService VARCHAR(10),
MultipleLines VARCHAR(20),
InternetService VARCHAR(20),
OnlineSecurity VARCHAR(20),
OnlineBackup VARCHAR(20),
DeviceProtection VARCHAR(20),
TechSupport VARCHAR(20),
StreamingTV VARCHAR(20),
StreamingMovies VARCHAR(20),
Contract VARCHAR(20),
PaperlessBilling VARCHAR(10),
PaymentMethod VARCHAR(50),
MonthlyCharges FLOAT,
TotalCharges VARCHAR(50),
Churn VARCHAR(10)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/IBM CU SQL1.csv'
INTO TABLE churn_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM churn_data WHERE TotalCharges = '';

SELECT *FROM churn_data WHERE customerID IS NULL OR customerID = '';

DELETE FROM churn_data WHERE customerID IS NULL OR customerID = '';

SELECT COUNT(*) FROM churn_data;

SELECT * FROM churn_data WHERE TotalCharges = '';

DELETE FROM churn_data WHERE TotalCharges = '';


SELECT COUNT(*) FROM churn_data WHERE Churn = 'Yes';

SELECT ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) 
AS Churn_Rate FROM churn_data;

SELECT Contract, COUNT(*) AS Total, SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM churn_data GROUP BY Contract;

SELECT InternetService, COUNT(*) AS Total, SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM churn_data GROUP BY InternetService;

SELECT PaymentMethod, COUNT(*) AS Total, SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM churn_data GROUP BY PaymentMethod;

SELECT 
CASE 
  WHEN tenure < 12 THEN '0-1 Year'
  WHEN tenure BETWEEN 12 AND 24 THEN '1-2 Years'
  ELSE '2+ Years'
END AS Tenure_Group,
COUNT(*) AS Total, SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
FROM churn_data GROUP BY Tenure_Group;