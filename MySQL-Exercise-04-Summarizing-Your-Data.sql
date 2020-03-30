SELECT COUNT(breed)
FROM dogs;

SELECT COUNT(DISTINCT breed)
FROM dogs

SELECT COUNT(DISTINCT dog_guid)
FROM complete_tests
WHERE created_at > "2014-03-01";

SELECT COUNT(*)
FROM dogs;

SELECT COUNT(exclude)
FROM dogs;

SELECT COUNT(DISTINCT dog_guid)
FROM dogs
WHERE exclude = 1;

SELECT SUM(ISNULL(exclude))
FROM dogs

SELECT test_name, 
AVG(rating) AS AVG_Rating, 
MIN(rating) AS MIN_Rating, 
MAX(rating) AS MAX_Rating
FROM reviews
WHERE test_name = "Eye Contact Game";

SELECT TIMESTAMPDIFF(minute, start_time, end_time) AS duration
FROM exam_answers
LIMIT 2000;

SELECT AVG(TIMESTAMPDIFF(minute, start_time, end_time)) AS average_duration
FROM exam_answers;

SELECT AVG(TIMESTAMPDIFF(minute, start_time, end_time)) AS average_duration
FROM exam_answers
WHERE test_name = "Treat Warm-Up";

SELECT COUNT(DISTINCT test_name)
FROM exam_answers;

SELECT MIN(TIMESTAMPDIFF(minute, start_time, end_time)) AS maximum_duration, 
MAX(TIMESTAMPDIFF(minute, start_time, end_time)) AS minimum_duration
FROM exam_answers;

SELECT COUNT(*)
FROM exam_answers
WHERE TIMESTAMPDIFF(minute, start_time, end_time) < 0;

SELECT AVG(TIMESTAMPDIFF(minute, start_time, end_time)) AS average_duration
FROM exam_answers
WHERE TIMESTAMPDIFF(minute, start_time, end_time) > 0;