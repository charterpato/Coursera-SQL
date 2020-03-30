SELECT dog_guid, created_at AS time_stamp
FROM complete_tests;

SELECT dog_guid, created_at AS "time stamp"
FROM complete_tests AS tests;

SELECT start_time AS "exam start time"
FROM exam_answers;

SELECT DISTINCT breed
FROM dogs;

SELECT DISTINCT state, city
FROM users;

SELECT DISTINCT test_name, subcategory_name
FROM complete_tests;

SELECT DISTINCT breed
FROM dogs 
ORDER BY breed;

SELECT DISTINCT user_guid, state, membership_type
FROM users
WHERE country = "US" AND state IS NOT NULL and membership_type IS NOT NULL
ORDER BY state ASC, membership_type ASC;

SELECT DISTINCT breed
REPLACE(breed,'-',' ') AS breed_fixed
FROM dogs
ORDER BY breed_fixed;

SELECT DISTINCT subcategory_name
FROM complete_tests
ORDER BY subcategory_name ASC;

SELECT DISTINCT country
FROM users
WHERE country != "US";

SELECT user_guid, dog_guid, test_name
FROM complete_tests
ORDER BY created_at;

SELECT DISTINCT user_guid, state, created_at
FROM users
WHERE membership_type = 2 AND state = "NC" AND country = "US" AND created_at > "2014-03-01"
ORDER BY created_at DESC;

SELECT DISTINCT UPPER(breed)
FROM dogs
ORDER BY breed;