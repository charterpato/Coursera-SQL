SELECT d.dog_guid AS dogID, d.user_guid AS userID, AVG(r.rating) AS avg_rating, 
       COUNT(r.rating) AS num_ratings, d.breed, d.breed_group, d.breed_type
FROM dogs d JOIN reviews r
    ON d.dog_guid = r.dog_guid AND d.user_guid = r.user_guid
GROUP BY userID, dogID, d.breed, d.breed_group, d.breed_type
HAVING num_ratings >= 10
ORDER BY avg_rating DESC;

SELECT d.user_guid AS userID, d.dog_guid AS dogID, 
       d.breed, d.breed_type, d.breed_group
FROM dogs d JOIN complete_tests c
    ON d.dog_guid=c.dog_guid AND test_name='Yawn Warm-up';

SELECT r.dog_guid AS rDogID, d.dog_guid AS dDogID, r.user_guid AS rUserID, d.user_guid AS dUserID, 
       AVG(r.rating) AS avg_rating, COUNT(r.rating) AS num_ratings, d.breed, d.breed_group, d.breed_type
FROM reviews r LEFT JOIN dogs d
    ON r.dog_guid=d.dog_guid AND r.user_guid=d.user_guid
WHERE r.dog_guid IS NOT NULL
GROUP BY r.dog_guid
HAVING num_ratings >= 10
ORDER BY AvgRating DESC;

SELECT DISTINCT d.dog_guid, COUNT(c.dog_guid)
FROM dogs d LEFT JOIN complete_tests c
    ON d.dog_guid = c.dog_guid
GROUP BY d.dog_guid

SELECT DISTINCT c.dog_guid, COUNT(d.dog_guid)
FROM dogs d RIGHT JOIN complete_tests c
    ON d.dog_guid = c.dog_guid
GROUP BY c.dog_guid

SELECT COUNT(*)
FROM users u LEFT JOIN dogs d
    ON u.user_guid = d.user_guid
WHERE d.user_guid IS NULL

SELECT COUNT(*)
FROM dogs d RIGHT JOIN users u
    ON u.user_guid = d.user_guid
WHERE d.user_guid IS NULL

SELECT s.dog_guid, COUNT(*)
FROM site_activities s LEFT JOIN dogs d
    ON s.dog_guid = d.dog_guid
WHERE d.dog_guid IS NULL AND s.dog_guid IS NOT NULL 
GROUP BY s.dog_guid;