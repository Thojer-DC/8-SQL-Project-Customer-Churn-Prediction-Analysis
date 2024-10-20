
CREATE DATABASE telco_db;

DROP TABLE IF EXISTS telco_customers;
CREATE TABLE telco_customers
(
	customerID VARCHAR(25),
	gender VARCHAR(10),
	SeniorCitizen INT,
	Partner VARCHAR(25),
	Dependents VARCHAR(25),
	tenure INT,
	PhoneService VARCHAR(25),
	MultipleLines VARCHAR(25),
	InternetService VARCHAR(25),
	OnlineSecurity VARCHAR(25),
	OnlineBackup VARCHAR(25),
	DeviceProtection VARCHAR(25),
	TechSupport VARCHAR(25),
	StreamingTV VARCHAR(25),
	StreamingMovies VARCHAR(25),
	Contract VARCHAR(25),
	PaperlessBilling VARCHAR(25),
	PaymentMethod VARCHAR(35),
	MonthlyCharges DECIMAL(10,2),
	TotalCharges DECIMAL(10,2),
	Churn VARCHAR(25)
);

SELECT *
FROM telco_customers;



-- 1. Customer Churn by Contract Type
SELECT 
	contract,
	ROUND(
		(COUNT(CASE WHEN churn = 'Yes' THEN 1 END)::numeric * 100) / COUNT(*), 0
	)AS y_churn_rate,
	ROUND(
		(COUNT(CASE WHEN churn = 'No' THEN 1 END)::numeric * 100) / COUNT(*), 0
	)AS n_churn_rate
FROM telco_customers
GROUP BY contract;


-- 2. Churn Rate Based on Monthly Charges
SELECT
	CASE
		WHEN monthlycharges > 120 THEN '>120'
		WHEN monthlycharges BETWEEN 91 AND 120 THEN '91-120'
		WHEN monthlycharges BETWEEN 61 AND 90 THEN '61-90'
		WHEN monthlycharges BETWEEN 31 AND 60 THEN '31-60'
		ELSE '1-30'
	END AS charge_range,
	ROUND(
		(COUNT(CASE WHEN churn = 'Yes' THEN 1 END)::numeric * 100) / COUNT(*), 0
	)AS y_churn_rate,
	ROUND(
		(COUNT(CASE WHEN churn = 'No' THEN 1 END)::numeric * 100) / COUNT(*), 0
	)AS n_churn_rate
FROM telco_customers
GROUP BY 1
ORDER BY 1;



-- 3. Tenure vs. Churn Rate
SELECT
	CASE
		WHEN tenure <= 11 THEN '0-1 year'
		WHEN tenure BETWEEN 12 AND 24 THEN '1-2 years'
		WHEN tenure BETWEEN 13 AND 36 THEN '2-3 years'
		WHEN tenure BETWEEN 37 AND 48 THEN '3-4 years'
		WHEN tenure BETWEEN 49 AND 60 THEN '4-5 years'
		ELSE 'more than 5 years'
	END AS tenure_range,
	ROUND(
		(COUNT(CASE WHEN churn = 'Yes' THEN 1 END)::numeric * 100) / COUNT(*), 0
	)AS y_churn_rate,
	ROUND(
		(COUNT(CASE WHEN churn = 'No' THEN 1 END)::numeric * 100) / COUNT(*), 0
	)AS n_churn_rate
FROM telco_customers
GROUP BY 1


-- 4. Internet Service and Churn
SELECT
	internetservice,
	ROUND(
		(COUNT(CASE WHEN churn = 'Yes' THEN 1 END)::numeric * 100) / COUNT(*), 1
	)AS y_churn_rate,
	ROUND(
		(COUNT(CASE WHEN churn = 'No' THEN 1 END)::numeric * 100) / COUNT(*), 1
	)AS n_churn_rate
FROM telco_customers
GROUP BY 1;


-- 5. Senior Citizens and Churn
SELECT 
	CASE
		WHEN seniorcitizen = 1 THEN 'Yes'
		ELSE 'No'
	END AS senior_citizen,
	ROUND(
		(COUNT(CASE WHEN churn = 'Yes' THEN 1 END)::numeric * 100) / COUNT(*), 1
	)AS y_churn_rate,
	ROUND(
		(COUNT(CASE WHEN churn = 'No' THEN 1 END)::numeric * 100) / COUNT(*), 1
	)AS n_churn_rate	
FROM telco_customers
GROUP BY 1;









