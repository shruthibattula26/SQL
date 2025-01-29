--  Problem Statement:
-- 1) load the data from any database
CREATE database hotel_db;

ALTER TABLE hotel_db.hb_table 
ADD COLUMN id int not null FIRST ;

-- 2) to find the information about the table
DESC hb_table;

-- 3) to display the first 10 records
SELECT 
    *
FROM
    hb_table
LIMIT 10;

-- 4) to display the last 10 records
SELECT 
    *
FROM
    hb_table
ORDER BY id DESC
LIMIT 10;

-- 5) to find the total number of records
SELECT 
    COUNT(*) AS total_records
FROM
    hb_table;

-- 6) to find the null values count from the table.
SELECT 
    COUNT(*) `Null Values Count`
FROM
    hb_table
WHERE
    hotel IS NULL OR is_canceled IS NULL
        OR lead_time IS NULL
        OR arrival_date_year IS NULL
        OR arrival_date_month IS NULL
        OR arrival_date_week_number IS NULL
        OR arrival_date_day_of_month IS NULL
        OR stays_in_weekend_nights IS NULL
        OR stays_in_week_nights IS NULL
        OR adults IS NULL
        OR children IS NULL
        OR babies IS NULL
        OR meal IS NULL
        OR country IS NULL
        OR market_segment IS NULL
        OR distribution_channel IS NULL
        OR is_repeated_guest IS NULL
        OR previous_cancellations IS NULL
        OR previous_bookings_not_canceled IS NULL
        OR reserved_room_type IS NULL
        OR assigned_room_type IS NULL
        OR booking_changes IS NULL
        OR deposit_type IS NULL
        OR agent IS NULL
        OR company IS NULL
        OR days_in_waiting_list IS NULL
        OR customer_type IS NULL
        OR adr IS NULL
        OR required_car_parking_spaces IS NULL
        OR total_of_special_requests IS NULL
        OR reservation_status IS NULL
        OR reservation_status_date IS NULL;

SELECT COUNT(*) FROM hotel_db.hb_table WHERE agent IS NULL;
SELECT COUNT(*) FROM hotel_db.hb_table WHERE company IS NULL;
ALTER TABLE hb_table DROP COLUMN company;
DESCRIBE hb_table;
SELECT avg(agent) `Average` FROM hb_table;
UPDATE hb_table SET agent = 86.69 WHERE agent is null; 

-- 7) to find all the unique records from the table
SELECT DISTINCT
    *
FROM
    hb_table;

-- 8) Find the total count of the unique records from the table.
SELECT DISTINCT COUNT(*) AS unique_count FROM hb_table;

-- 9) to find the average lead_time based on the country
SELECT 
    country, AVG(lead_time) AS avg_lead_time
FROM
    hb_table
GROUP BY country;
-- AVG TIME CREATE NEW COL - AVG - ACTUAL TIME
ALTER TABLE hb_table ADD COLUMN avg_lead_time FLOAT ;
UPDATE hb_table SET avg_lead_time = ABS((SELECT AVG(lead_time)) - lead_time);
UPDATE hb_table
SET avg_lead_time = ABS(((SELECT AVG(lead_time) FROM hb_table) - lead_time));

-- 10) What is the most common market segment in the hotel bookings dataset, and how many bookings belong to this segment?
SELECT 
    market_segment, COUNT(*) AS booking_count
FROM
    hb_table
GROUP BY market_segment
ORDER BY booking_count DESC
LIMIT 1;

-- 11) What is the total number of bookings that were canceled and that were not canceled in the hotel bookings dataset?
SELECT 
    is_canceled, COUNT(*) AS total_bookings
FROM
    hb_table
GROUP BY is_canceled;

-- 12) Which hotel has the highest number of bookings in the dataset, and how many bookings were made for this hotel?
SELECT 
    hotel, COUNT(*) AS total_bookings
FROM
    hb_table
GROUP BY hotel
ORDER BY total_bookings DESC
LIMIT 1;

-- 13) What is the distribution of hotel bookings between cancellations and non-cancellations?
SELECT 
    is_canceled, 
    COUNT(*) AS booking_count
FROM 
    hb_table
GROUP BY 
    is_canceled;

-- or

SELECT 
    CASE 
        WHEN "is_cancelled" = 1 THEN 'Cancelled'
        ELSE 'Not Cancelled'
    END AS booking_status,
    COUNT(*) AS booking_count
FROM hb_table
GROUP BY booking_status;

-- 14) display the records from all the hotel bookings made through the direct market segment.
SELECT 
    *
FROM
    hb_table
WHERE
    market_segment = 'Direct';

-- 15) display the records where the lead_time is above 250 and below 500 
SELECT 
    *
FROM
    hb_table
WHERE
    lead_time > 250 AND lead_time < 500;

-- Ascending Order:
SELECT 
    *
FROM
    hb_table
WHERE
    lead_time > 250 AND lead_time < 500 ORDER BY lead_time;