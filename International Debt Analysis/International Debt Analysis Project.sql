-- Mini Project -  International-Debt-Analysis 

-- Problem Statement: 
-- 1. What is the purpose of connecting to the international debt database, and what is the initial step taken after connection? 
create database ida_db;
SHOW TABLES;
DESCRIBE international_debt;

/*
Purpose: Connecting to the international debt database allows us to query and analyze data about debt across various countries and indicators. 
Initial Step: After connecting to the database, the first step is typically to select a table and 
examine the structure of the table using commands like `SHOW TABLES;` or `DESCRIBE table_name;`.
*/

-- 2. How many unique countries are present in the international debt dataset, and why is it crucial for statistical analyses? 
SELECT 
    COUNT(DISTINCT country_name) `Total Number of Countries`
FROM
    international_debt;
    
/*
Importance: Knowing the number of unique countries helps in understanding the scope of the data, ensuring that each country’s data can be accounted for in analyses. 
It is crucial for statistical analysis as it gives insight into the diversity and coverage of the dataset, making comparisons and global insights more accurate.
*/

-- 3. What role do debt indicators play in understanding a country's economic situation, and how can they be categorized? 
SELECT DISTINCT
    indicator_name
FROM
    international_debt;

/*
Role and Categorization of Debt Indicators:
Role: Debt indicators provide insights into different aspects of a country’s debt, 
such as interest payments, principal repayments, disbursements, and long-term vs. short-term debt.
These indicators can be categorized into:
- Long-term Debt: Loans or bonds that are repayable over long periods, impacting a country's economic stability.
- Short-term Debt: Loans repayable within a year, indicating short-term liquidity needs.
- Principal and Interest Payments: The amount paid towards the loan principal and interest, which reflects ongoing financial obligations.
- Private vs. Public Debt: Debt held by private sectors or government institutions can influence socio-economic policies.
*/

-- 4. What is the significance of determining the total amount of debt owed by different countries, and how does it contribute to understanding the global economy? 
SELECT 
    country_name `Country`, SUM(debt) `Total Debt`
FROM
    ida_db.international_debt
GROUP BY country_name
ORDER BY `Total Debt` DESC;

/*
Calculating the total debt for each country gives an overall picture of its debt burden, 
which is essential for understanding economic health and sustainability. 
High debt levels may indicate potential economic risks and can affect a country's ability to fund development projects or respond to crises.
*/

-- 5. Which country owns the highest amount of debt overall, and why is this information valuable in socio-economic analysis? 
SELECT 
    country_name `Country`, SUM(debt) `Total Debt`
FROM
    ida_db.international_debt
GROUP BY country_name
ORDER BY `Total Debt` DESC
LIMIT 1;

/*
Knowing which country has the highest debt is valuable for socio-economic analysis, as it highlights regions at risk of debt distress. 
It can indicate economic vulnerabilities, dependencies, or areas requiring financial intervention.
*/

-- 6. How does investigating the average amount of debt owed by countries across different indicators provide insights into debt distribution? 
SELECT 
    indicator_name `Indicator`, AVG(debt) `Average Debt`
FROM
    ida_db.international_debt
GROUP BY `Indicator`
ORDER BY `Average Debt` DESC;

/*
Calculating the average debt across different indicators helps identify common trends and outliers in debt distribution. 
This insight allows us to see if certain indicators, like long-term debt or specific types of loans, are more burdensome, 
guiding financial planning and risk management.
*/

-- 7. What category of debt tops the chart of average debt, and why might this category be particularly significant? 
SELECT 
    indicator_name `Indicator`, AVG(debt) `Average Debt`
FROM
    ida_db.international_debt
GROUP BY `Indicator`
ORDER BY `Average Debt` DESC
LIMIT 1;

/*
Identifying the top category by average debt highlights the type of debt most affecting countries, such as long-term debt or interest payments. 
This is significant as it could guide debt management strategies or financial policy adjustments.
*/

-- 8. Which country owes the highest amount of debt in the long-term debt category, and what does this reveal about its economic condition? 
SELECT 
    country_name `Country`, SUM(debt) `Total Long-Term Debt`
FROM
    ida_db.international_debt
WHERE
    indicator_name LIKE '%long-Term%'
GROUP BY `Country`
ORDER BY `Total Long-Term Debt` DESC
LIMIT 1;

/*
The country with the highest long-term debt may face challenges with sustained debt servicing over time, impacting its ability to invest in development. 
This finding is key in assessing long-term economic stability and potential financial risks.
*/

-- 9. Is long-term debt the most common indicator in which countries owe their debt, and what does this finding suggest about global economic issues? 
SELECT 
    indicator_name, COUNT(*) `Debt Occurrences`
FROM
    international_debt
GROUP BY indicator_name
ORDER BY `Debt Occurrences` DESC
LIMIT 1;

/*
Checking if long-term debt is the most common type of debt owed provides insight into the nature of global debt. 
A prevalence of long-term debt could suggest that countries rely on sustained borrowing for growth, which can lead to prolonged financial obligations and affect economic flexibility.
*/

-- 10. What is the maximum amount of debt across different indicators, and how does identifying this help in understanding potential economic challenges faced by countries?
SELECT 
    indicator_name, MAX(debt) AS `Max Debt`
FROM 
    international_debt
GROUP BY 
    indicator_name
ORDER BY 
    `Max Debt` DESC;

/*
Identifying the maximum debt by indicator helps pinpoint specific high-burden debt types. 
This can uncover potential economic challenges, such as countries struggling with high principal repayments or interest obligations, 
which may lead to debt restructuring needs.
*/