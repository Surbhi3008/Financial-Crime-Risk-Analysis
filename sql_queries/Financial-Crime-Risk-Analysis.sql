CREATE TABLE aml_customers (
    customer_id VARCHAR(10),
    age INTEGER,
    country VARCHAR(50),
    occupation VARCHAR(100),
    annual_income BIGINT,
    monthly_transactions INTEGER,
    avg_transaction_value BIGINT,
    pep VARCHAR(3),
    high_risk_country VARCHAR(3),
    risk_score INTEGER,
    risk_category VARCHAR(20)
);
SELECT * from aml_customers;

====================================================================================
---1. Total Customers---
====================================================================================

SELECT COUNT(customer_id)
FROM
aml_customers;

====================================================================================
--2. Risk Category Distribution--
====================================================================================

SELECT risk_category,COUNT(*) as customer_count
FROM aml_customers 
GROUP BY risk_category;

====================================================================================
--3. Percentage of High-Risk Customers--
====================================================================================

SELECT ROUND(COUNT
(CASE WHEN risk_category='High Risk' THEN 1 END)*100.0/COUNT(customer_id),2) 
as High_Risk_Percentage 
FROM aml_customers;

====================================================================================
--4. Number of PEP Customers---
====================================================================================

SELECT COUNT(*) AS PEP_Customers
FROM aml_customers
WHERE PEP='Yes';

====================================================================================
--5. Average Risk Score--
====================================================================================

SELECT AVG(Risk_score) AS Avg_risk_score 
FROM aml_customers;

====================================================================================
--6. Average Risk Score by Occupation--
====================================================================================

SELECT Occupation,ROUND(AVG(Risk_score),2) AS Avg_risk_score 
FROM aml_customers
GROUP BY occupation
ORDER BY Avg_risk_score DESC;

====================================================================================
--7. Country-wise Customer Count--
====================================================================================

SELECT Country,COUNT(*)as Customer_count FROM 
aml_customers
GROUP BY Country
ORDER BY Customer_count DESC;

====================================================================================
--8. High-Risk Customers by Country--
====================================================================================

SELECT Country,Count(*)as high_risk_customers 
FROM aml_customers 
where risk_category='High Risk'
GROUP BY country
ORDER BY high_risk_customers DESC;

====================================================================================
--9. Average Risk Score by Country--
====================================================================================

SELECT Country,ROUND(AVG(risk_score),2)as Avg_risk_score  
FROM aml_customers 
GROUP BY country
ORDER BY Avg_risk_score DESC;


====================================================================================
--10. PEP vs Non-PEP Risk Score--
====================================================================================

SELECT PEP,
ROUND(AVG(Risk_Score),2) AS Avg_Risk_Score
FROM aml_customers
GROUP BY PEP;

====================================================================================
--11. High-Risk Customers who are PEPs--
====================================================================================

SELECT COUNT(*) AS High_Risk_PEP_Customers
FROM aml_customers
WHERE Risk_Category='High Risk'
AND PEP='Yes';

====================================================================================
--12. Occupations Contributing to High Risk--
====================================================================================

SELECT Occupation,
COUNT(*) AS High_Risk_Count
FROM aml_customers
WHERE Risk_Category='High Risk'
GROUP BY Occupation
ORDER BY High_Risk_Count DESC;


====================================================================================
--13. Customers from High-Risk Countries--
====================================================================================

SELECT Country,
COUNT(*) AS Customer_Count
FROM aml_customers
WHERE High_Risk_Country='Yes'
GROUP BY Country;

====================================================================================
--14. Top 10 Highest Risk Customers--
====================================================================================

SELECT Customer_ID,
Occupation,
Country,
Risk_Score
FROM aml_customers
ORDER BY Risk_Score DESC
LIMIT 10;

====================================================================================
--15. Risk Category and PEP Cross Analysis--
====================================================================================

SELECT Risk_Category,
PEP,
COUNT(*) AS Customer_Count
FROM aml_customers
GROUP BY Risk_Category,PEP
ORDER BY Risk_Category;
