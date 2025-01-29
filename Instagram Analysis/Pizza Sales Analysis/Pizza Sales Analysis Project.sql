-- Mini Project – Pizza Sales
-- Problem Statement:
CREATE DATABASE pizza_sales_db;
-- 1) Retrieve the total number of orders placed.
SELECT 
    COUNT(*) AS Total_Orders
FROM
    orders;

-- 2) Calculate the total revenue generated from pizza sales.
SELECT 
    SUM(od.quantity * p.price) `Total_Revenue`
FROM
    order_details od
        INNER JOIN
    pizza p ON od.pizza_id = p.pizza_id;

-- 3) Identify the highest-priced pizza.
SELECT pt.name `Pizza Name`, p.price `Highest Price`
FROM pizza p
INNER JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

SELECT MAX(price) FROM pizza; -- To know Max price 

-- 4) Identify the most common pizza size ordered.
SELECT p.size, COUNT(*) AS `Size Count`
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY `Size Count` DESC
LIMIT 1;

-- 5) List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pt.name `Pizza`, SUM(od.quantity) `Total Quantity`
FROM
    order_details od
        INNER JOIN
    pizza p ON od.Pizza_id = p.Pizza_id
        INNER JOIN
    pizza_types pt ON p.Pizza_type_id = pt.Pizza_type_id
GROUP BY pt.name
ORDER BY `Total Quantity` DESC
LIMIT 5;

-- 6) To display the unique records in each table and count.
-- Pizza Table:
SELECT DISTINCT
    *, (SELECT DISTINCT COUNT(*)) `Unique Records Count`
FROM
    pizza;
SELECT DISTINCT
    COUNT(*) AS Unique_Record_Count
FROM
    pizza;
 
-- Pizza_types Table:
SELECT DISTINCT
    *, (SELECT DISTINCT COUNT(*)) `Unique Records Count`
FROM
    pizza_types;
SELECT DISTINCT
    COUNT(*) AS Unique_Record_Count
FROM
    pizza_types;

-- Orders_details Table:
SELECT DISTINCT
    *, (SELECT DISTINCT COUNT(*)) `Unique Records Count`
FROM
    order_details;
SELECT DISTINCT
    COUNT(*) AS Unique_Record_Count
FROM
    order_details;

-- Orders Table:
SELECT DISTINCT
    *, (SELECT DISTINCT COUNT(*)) AS `Unique Records Count`
FROM
    orders;
SELECT DISTINCT
    COUNT(*) AS Unique_Record_Count
FROM
    orders;

-- 7) To display the null values in each column and each table.
-- Pizza Table:
SELECT 
    *
FROM
    pizza
WHERE
    Pizza_id IS NULL
        OR Pizza_type_id IS NULL
        OR size IS NULL
        OR price IS NULL; 

-- Pizza_types Table:
SELECT 
    *
FROM
    pizza_types
WHERE
    Pizza_type_id IS NULL OR name IS NULL
        OR category IS NULL
        OR ingredients IS NULL;  

-- Orders_details Table:
SELECT 
    *
FROM
    order_details
WHERE
    order_details_id IS NULL
        OR order_id IS NULL
        OR Pizza_id IS NULL
        OR quantity IS NULL;

-- Orders Table:
SELECT 
    *
FROM
    orders
WHERE
    order_id IS NULL OR date IS NULL
        OR time IS NULL;
        
-- 8) Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category, SUM(od.quantity) `Total_Quantity`
FROM
    order_details od
        INNER JOIN
    pizza p ON od.pizza_id = p.pizza_id
        INNER JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- 9) Determine the distribution of orders by hour of the day.
SELECT 
    EXTRACT(HOUR FROM time) `Order Hour`, COUNT(*) `Order Count`
FROM
    orders
GROUP BY `Order Hour`
ORDER BY `Order Hour`;

-- 10) Join relevant tables to find the category-wise distribution of pizza.
SELECT 
    pt.category, COUNT(*) `Category Count`
FROM
    order_details od
        JOIN
    pizza p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- 11) Group the orders by date and calculate the average number of daily pizzas.
SELECT 
    o.date, AVG(od.quantity) `Avg Daily Pizzas`
FROM
    orders o
        INNER JOIN
    order_details od ON o.order_id = od.order_id
GROUP BY o.date;

-- 12) Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pt.name, SUM(od.quantity * p.price) AS `Total Revenue`
FROM
    order_details od
        INNER JOIN
    pizza p ON od.pizza_id = p.pizza_id
        INNER JOIN
    pizza_types pt ON p.Pizza_type_id = pt.Pizza_type_id
GROUP BY pt.name
ORDER BY `Total Revenue` DESC
LIMIT 3;

-- 13) Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pt.name AS Pizza_Type,
    SUM(od.quantity * p.price) AS Pizza_Type_Revenue,
    (SUM(od.quantity * p.price) / (SELECT 
            SUM(od2.quantity * p2.price)
        FROM
            order_details od2
                INNER JOIN
            pizza p2 ON od2.pizza_id = p2.pizza_id)) * 100 AS Revenue_Percentage
FROM
    order_details od
        INNER JOIN
    pizza p ON od.pizza_id = p.pizza_id
        INNER JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY Revenue_Percentage DESC;

-- 14) Analyze the cumulative revenue generated over time.
SELECT o.date,
       SUM(od.quantity * p.price) OVER (ORDER BY o.date) AS Cumulative_Revenue
FROM orders o
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN pizza p ON od.pizza_id = p.pizza_id;

-- 15) Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT 
    pt.category,
    pt.name,
    SUM(od.quantity * p.price) AS Total_Revenue
FROM
    order_details od
        INNER JOIN
    pizza p ON od.pizza_id = p.pizza_id
        INNER JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category , pt.name
ORDER BY pt.category , Total_Revenue DESC
LIMIT 3;
