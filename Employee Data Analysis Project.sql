-- Mini Project – Employee_Data
-- Problem Statement:
CREATE DATABASE employee_db;

-- 1. Load the dataset into the SQL database.
-- Loaded Dataset using Python
DESC emp_table; -- Summary of Data

-- Columns: Education, Join_Year, City, Payment_Tier, Age, Gender, EverBenched, ExperienceInCurrentDomain, LeaveOrNot

-- 2. Rename the column `joiningyear` to `join_year`.
ALTER TABLE employee_db.emp_table CHANGE COLUMN JoiningYear Join_Year bigint NULL;

-- 3. Rename the column `paymenttire` to `Payment_Tier`.
ALTER TABLE employee_db.emp_table CHANGE COLUMN PaymentTier Payment_Tier bigint NULL;

-- 4. Check for duplicate records in the table.
SELECT 
    Education,
    Join_Year,
    City,
    Payment_Tier,
    Age,
    Gender,
    EverBenched,
    ExperienceInCurrentDomain,
    LeaveOrNot,
    COUNT(*) `Duplicate Count`
FROM
    emp_table
GROUP BY Education , Join_Year , City , Payment_Tier , Age , Gender , EverBenched , ExperienceInCurrentDomain , LeaveOrNot
HAVING COUNT(*) > 1;

-- 5. Display all records with null values.
SELECT 
    *
FROM
    emp_table
WHERE
    Education IS NULL OR Join_Year IS NULL
        OR City IS NULL
        OR Payment_Tier IS NULL
        OR Age IS NULL
        OR Gender IS NULL
        OR EverBenched IS NULL
        OR ExperienceInCurrentDomain IS NULL
        OR LeaveOrNot IS NULL;
        
-- 6. Replace 'male' with 1 and 'female' with 0 in the gender column.
UPDATE emp_table 
SET 
    Gender = 1
WHERE
    Gender = 'Male';
UPDATE emp_table 
SET 
    Gender = 0
WHERE
    Gender = 'Female';

-- 7. Perform aggregation functions grouped by join_year.
SELECT 
    join_year,
    COUNT(*) AS Total_Records,
    AVG(ExperienceInCurrentDomain) AS Avg_Experience
FROM
    emp_table
GROUP BY Join_Year;

-- 8. Display the top 20 records from the table.
ALTER TABLE emp_table ADD COLUMN S_No int NOT NULL FIRST; -- Added New Column at First to Index our Data

SELECT 
    *
FROM
    emp_table
LIMIT 20;

-- 9. Display the last 20 records from the table.
SELECT 
    *
FROM
    emp_table
ORDER BY S_No DESC
LIMIT 20;

SELECT 
    *
FROM
    emp_table
LIMIT 4633, 20;


-- 10. Count records for ExperienceInCurrentDomain grouped by city.
SELECT 
    City, COUNT(ExperienceInCurrentDomain) `Experience Count`
FROM
    emp_table
GROUP BY City;

-- 11. Display records where the city name has 4 letters.
SELECT 
    *
FROM
    emp_table
WHERE
    City LIKE '____';
-- Why underscore??

SELECT 
    *
FROM
    emp_table
WHERE
    City LIKE '%%%%';

-- or
SELECT 
    *
FROM
    emp_table
WHERE
    LENGTH(City) = 4;

-- 12. Display records for the years 2014, 2018, and 2013 where the city is New Delhi.
SELECT 
    *
FROM
    emp_table
WHERE
    Join_Year IN (2014 , 2018, 2013)
        AND city = 'New Delhi';

-- 13. Count gender based on LeaveOrNot status.
SELECT 
    LeaveOrNot, Gender, COUNT(Gender) `Gender Count`
FROM
    emp_table
GROUP BY LeaveOrNot , Gender;

-- 14. Display maximum ExperienceInCurrentDomain grouped by education.
SELECT 
    Education, MAX(ExperienceInCurrentDomain) `Max Experience`
FROM
    emp_table
GROUP BY Education;

-- 15. Find the average age grouped by gender.
SELECT 
    Gender, AVG(Age) `Average Age`
FROM
    emp_table
GROUP BY Gender;

-- 16. Find the minimum and average age grouped by gender.
SELECT 
    Gender, MIN(Age) `Min Age`, AVG(Age) `Average Age`
FROM
    emp_table
GROUP BY Gender;

-- 17. Display records where education is Bachelor, join_year is 2014, and age is above 30.
SELECT 
    *
FROM
    emp_table
WHERE
    Education = 'Bachelor'
        AND Join_Year = 2014
        AND Age > 30;

-- 18. Display all records with null values.
SELECT 
    *
FROM
    emp_table
WHERE
    Education IS NULL OR Join_Year IS NULL
        OR City IS NULL
        OR Payment_Tier IS NULL
        OR Age IS NULL
        OR Gender IS NULL
        OR EverBenched IS NULL
        OR ExperienceInCurrentDomain IS NULL
        OR LeaveOrNot IS NULL;
-- 19. Count the total number of records in the table.
SELECT 
    COUNT(*) `Total Records`
FROM
    emp_table;

-- 20. Find the age group that most frequently leaves the company.
SELECT 
    Age, COUNT(*) `Leave Count`
FROM
    emp_table
WHERE
    LeaveOrNot = 1
GROUP BY Age
ORDER BY `Leave COUNT` DESC
LIMIT 1;