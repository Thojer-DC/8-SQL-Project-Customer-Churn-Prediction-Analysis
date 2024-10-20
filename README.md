# Customer Churn Prediction Analysis

![](https://github.com/Thojer-DC/8-SQL-Project-Customer-Churn-Prediction-Analysis/blob/main/sqlp8.jpg)

## Overview
The project focuses on customer loss for a made up telecoms corporation. client churn happens when a client stops using a service, and organizations want to know why so they can strengthen retention strategies. By evaluating client demographics, usage habits, and service information, we want to deliver actionable insights to lower churn rates.

## Objective
1. Determine which categories of consumers are more likely to leave.
2. Determine whether specific services or usage patterns contribute to churn.
3. Analyze the association between customer tenure and churn.
4. Provide recommendations for reducing churn based on the analysis.

## Dataset
The data for this project is sourced from Kaggle
Dataset Link: https://www.kaggle.com/datasets/blastchar/telco-customer-churn


## SQL Schema
**Creating database** 
```SQL
   CREATE DATABASE telco_db;

```

**Creating table** 
```SQL
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

```


## SQL Query

**1. Customer Churn by Contract Type**
```SQL
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

```

**2. Churn Rate Based on Monthly Charges**
```SQL
   SELECT
      CASE
         WHEN monthlycharges > 120 THEN '>120'
         WHEN monthlycharges BETWEEN 91 AND 120 THEN '91-120'
         WHEN monthlycharges BETWEEN 61 AND 90 THEN '61-90'
         WHEN monthlycharges BETWEEN 31 AND 60 THEN '31-60'
         ELSE '1-30'
      END AS charge_range,
      ROUND(
         (COUNT(CASE WHEN churn = 'Yes' THEN 1 END)::numeric * 100) / COUNT(*), 1
      )AS y_churn_rate,
      ROUND(
         (COUNT(CASE WHEN churn = 'No' THEN 1 END)::numeric * 100) / COUNT(*), 1
      )AS n_churn_rate
   FROM telco_customers
   GROUP BY 1
   ORDER BY 1;

```

**3. Tenure vs. Churn Rate**
```SQL
   SELECT 
      CASE
         WHEN tenure <= 30 THEN '1-30'
         WHEN tenure BETWEEN 31 AND 60 THEN '31-60'
         ELSE '61-'
      END AS tenure_range,
      ROUND(
         (COUNT(CASE WHEN churn = 'Yes' THEN 1 END)::numeric * 100) / COUNT(*), 1
      )AS y_churn_rate,
      ROUND(
         (COUNT(CASE WHEN churn = 'No' THEN 1 END)::numeric * 100) / COUNT(*), 1
      )AS n_churn_rate
   FROM telco_customers
   GROUP BY 1

```

**4. Internet Service and Churn**
```SQL
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

```


**5. Senior Citizens and Churn**
```SQL
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

```

## Findings and Recommendations

**Findings:**  
1. Customers on month-to-month contracts have the highest churn rate, at 43 percent, showing that they may not happiness with the service.
2. Higher charges lead to a major rise in the amount of turnover. This means that the more expensive the plan, the more likely the client will leave.
3. Customers with shorter periods leave more frequently. Individuals that stay with the company for more than a year experience a considerable decrease in rates of leaving.
4. Fiber optic internet users have a more rate of leaving than DSL or non-internet subscribers, which could be due to unhappy with performance or budget.
5. Senior citizens churn at a higher rate than younger consumers, maybe due to differences in use or requirements.

**Recommendations:**
1. Offering plans, such as discounts, to clients who sign up for one- or two-year contracts may minimize churn among month-to-month users.
2. Look into changing the rates for high-paying clients, who are more likely to churn. Offering discounts for loyalty or extra benefits may help you retain customers.
3. Offer focused efforts to stay for consumers in their first year of service, who are more likely to churn.
4. Conduct a deeper analysis of fiber optic service to find potential service or pricing concerns that could lead to increased churn.
5. Offer customized service plans or customer support methods for senior citizens to better their experience and retention.


