SELECT user_guid, free_start_user
FROM users
WHERE free_start_user = 1;

SELECT dog_guid, dna_tested
FROM dogs
WHERE dna_tested = 1;

SELECT user_guid
FROM users
WHERE membership_type = 2;

SELECT dog_guid, height
FROM dogs
WHERE height BETWEEN 10 AND 50;

SELECT *
FROM users
WHERE state = "NC" OR state = "NY";

SELECT *
FROM users
WHERE state IN ("NC", "NY");

SELECT dog_guid, breed
FROM dogs
WHERE breed LIKE "s%";

SELECT dog_guid, created_at
FROM complete_tests
WHERE DAYNAME(created_at) = "Tuesday";

SELECT dog_guid, created_at
FROM complete_tests
WHERE DAY(created_at) > 15;

SELECT dog_guid, created_at
FROM complete_tests
WHERE created_at < '2015-10-15';

SELECT user_guid
FROM users
WHERE free_start_user IS NOT NULL;

SELECT dog_guid, subcategory_name, test_name
FROM reviews
WHERE YEAR(created_at) = 2014
LIMIT 10;

SELECT user_guid
FROM dogs
WHERE gender = "female" AND breed LIKE "%terrier%";

SELECT dog_guid, test_name, subcategory_name
FROM complete_tests
WHERE YEAR(created_at) = 2014 AND MONTH(created_at) = 10
LIMIT 100;