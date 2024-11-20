-- Project :
-- SQL Instagram Analysis

SELECT 
    username, created_at
FROM
    users
WHERE
    id IN (SELECT DISTINCT
            id
        FROM
            photos)
ORDER BY created_at ASC
LIMIT 5;

-- 2. What day of the week do most users register on? 
SELECT 
    DAYNAME(created_at) `Day of Week`, COUNT(*) `Total Users`
FROM
    users
GROUP BY `Day of Week`
ORDER BY `Total Users` DESC
LIMIT 1;

-- 3. Find the users who have never posted a photo? 
SELECT 
    id, username
FROM
    users
WHERE
    id NOT IN (SELECT DISTINCT
            id
        FROM
            photos);

-- 4. Find the person who got more likes for one post? 
SELECT 
    p.id, p.user_id, u.username, COUNT(l.user_id) `Like Count`
FROM
    photos p
        JOIN
    likes l ON p.id = l.photo_id
        JOIN
    users u ON u.id = p.user_id
GROUP BY p.id , p.user_id
ORDER BY `Like Count` DESC
LIMIT 1;

-- 5. How many times does the average user post?  
SELECT 
    AVG(`Photo Count`) `Average Posts`
FROM
    (SELECT 
        user_id, COUNT(id) AS `Photo Count`
    FROM
        photos
    GROUP BY user_id) `User Posts`;

-- 6. Find total post by users? 
SELECT 
    p.user_id, u.username, COUNT(p.id) AS `Total Posts`
FROM
    photos p
        JOIN
    users u ON u.id = p.user_id
GROUP BY user_id;
      
-- 7. Total numbers of users who have posted at least one time? 
SELECT 
    COUNT(DISTINCT user_id) AS `Users with Posts`
FROM
    photos;

-- 8. What are the top 5 most commonly used hashtags? 
SELECT 
    t.tag_name, COUNT(pt.photo_id) `Tag Usage`
FROM
    tags t
        JOIN
    photo_tags pt ON t.id = pt.tag_id
GROUP BY t.tag_name
ORDER BY `Tag Usage` DESC
LIMIT 5;

-- 9. Find users who have liked every single photo on the site? 
SELECT 
    l.user_id, u.username
FROM
    likes l
        JOIN
    users u ON u.id = l.user_id
GROUP BY l.user_id
HAVING COUNT(l.photo_id) = (SELECT 
        COUNT(p.id)
    FROM
        photos p);

-- 10. Find users who have never commented on a photo? 
SELECT 
    username
FROM
    users
WHERE
    id NOT IN (SELECT DISTINCT
            user_id
        FROM
            comments);

-- 11. Find the percentage of our users who have either never commented on a photo or have liked on every photo? 
SELECT 
    (COUNT(DISTINCT u.id) * 100.0) / (SELECT 
            COUNT(*)
        FROM
            users) AS `Users Percentage`
FROM
    users u
WHERE
    u.id NOT IN (SELECT DISTINCT
            c.user_id
        FROM
            comments c)
        OR u.id IN (SELECT 
            l.user_id
        FROM
            likes l
        GROUP BY l.user_id
        HAVING COUNT(l.user_id) = (SELECT 
                COUNT(p.id)
            FROM
                photos p));

-- 12. Find users who have ever commented on a photo?
SELECT DISTINCT
    c.user_id, u.username
FROM
    comments c
        JOIN
    users u ON u.id = c.user_id
