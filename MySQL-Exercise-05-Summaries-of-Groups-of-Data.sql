SELECT test_name, AVG(rating) AS average_rating
FROM reviews
GROUP BY test_name;

SELECT test_name, MONTH(created_at) AS month, COUNT(created_at) AS num_completed_tests
FROM complete_tests
GROUP BY test_name, month;

SELECT test_name, MONTH(created_at) AS month, COUNT(created_at) AS num_completed_tests
FROM complete_tests
GROUP BY test_name, month
ORDER BY test_name ASC, month ASC;

SELECT breed_group, gender, COUNT(DISTINCT dog_guid) AS num_dogs
FROM dogs
GROUP BY breed_group, gender
ORDER BY num_dogs DESC;

SELECT test_name, MONTH(created_at) AS month, COUNT(created_at) AS num_completed_tests
FROM complete_tests
GROUP BY 1, 2
ORDER BY 1 ASC, 2 ASC;

SELECT test_name, MONTH(created_at) AS month, COUNT(created_at) AS num_completed_tests
FROM complete_tests
WHERE MONTH(created_at) = 11 OR MONTH(created_at) = 12
GROUP BY 1, 2
HAVING COUNT(created_at)>= 20
ORDER BY 3 DESC;

SELECT breed_group, gender, COUNT(DISTINCT dog_guid) AS num_dogs
FROM dogs
WHERE breed_group IS NOT NULL AND breed_group != "" AND breed_group != "None"
GROUP BY breed_group, gender
HAVING num_dogs >= 1000
ORDER BY num_dogs DESC;

SELECT breed_type, AVG(total_tests_completed), AVG(mean_iti_minutes)
FROM dogs
GROUP BY breed_type
ORDER BY AVG(total_tests_completed) DESC;

SELECT test_name, TIMESTAMPDIFF(HOUR, start_time, end_time)
FROM exam_answers
WHERE TIMESTAMPDIFF(HOUR, start_time, end_time) < 6000 
AND TIMESTAMPDIFF(SECOND, start_time, end_time) > 0
GROUP BY test_name

SELECT state, zip, COUNT(DISTINCT user_guid) AS num_combination
FROM users
WHERE country = "US"
GROUP BY state, zip
ORDER BY state, num_combination DESC

SELECT state, zip, COUNT(DISTINCT user_guid) AS num_combination
FROM users
WHERE country = "US"
GROUP BY state, zip
HAVING num_combination >= 5
ORDER BY state, num_combination DESC