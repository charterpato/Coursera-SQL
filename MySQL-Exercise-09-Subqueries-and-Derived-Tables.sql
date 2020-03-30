SELECT *
FROM exam_answers 
WHERE TIMESTAMPDIFF(MINUTE,start_time,end_time) >
    (SELECT AVG(TIMESTAMPDIFF(MINUTE,start_time,end_time))
     FROM exam_answers
     WHERE TIMESTAMPDIFF(MINUTE,start_time,end_time) > 0);

SELECT *
FROM exam_answers 
WHERE TIMESTAMPDIFF(MINUTE,start_time,end_time) >
    (SELECT AVG(TIMESTAMPDIFF(MINUTE,start_time,end_time))
     FROM exam_answers
     WHERE TIMESTAMPDIFF(MINUTE,start_time,end_time) > 0
    AND test_name = "Yawn Warm-Up");

SELECT AVG(TIMESTAMPDIFF(MINUTE,start_time,end_time))
FROM exam_answers
WHERE TIMESTAMPDIFF(MINUTE,start_time,end_time) > 0 AND test_name = "Yawn Warm-Up";

SELECT * 
FROM users
WHERE state NOT IN ('NC','NY');

SELECT COUNT(*)
FROM exam_answers
WHERE subcategory_name IN ("Puzzles", "Numerosity", "Bark Game");

SELECT COUNT(*)
FROM dogs
WHERE breed_group NOT IN ("Working", "Sporting", "Herding");

SELECT DISTINCT u.user_guid AS uUserID
FROM users u
WHERE EXISTS (SELECT d.user_guid
              FROM dogs d 
              WHERE u.user_guid = d.user_guid);

SELECT DISTINCT u.user_guid AS uUserID
FROM users u
WHERE EXISTS (SELECT *
              FROM dogs d 
              WHERE u.user_guid = d.user_guid);

SELECT DISTINCT users.user_guid
FROM users
WHERE NOT EXISTS (SELECT users.user_guid
                 FROM dogs
                 WHERE users.user_guid = dogs.user_guid);

SELECT DistinctUUsersID.user_guid AS uUserID, d.user_guid AS dUserID, count(*) AS numrows
FROM (SELECT DISTINCT u.user_guid 
      FROM users u) AS DistinctUUsersID 
LEFT JOIN dogs d
   ON DistinctUUsersID.user_guid=d.user_guid
GROUP BY DistinctUUsersID.user_guid
ORDER BY numrows DESC

SELECT DISTINCT dogs.dog_guid, dogs.breed_group, users.state, users.zip
FROM dogs, users
WHERE breed_group IN ('Working','Sporting','Herding') AND dogs.user_guid = users.user_guid;

SELECT DISTINCT dogs.dog_guid, dogs.breed_group, users.state, users.zip
FROM dogs JOIN users
    ON dogs.user_guid = users.user_guid
WHERE breed_group IN ('Working','Sporting','Herding');

SELECT dogs.user_guid
FROM dogs
WHERE NOT EXISTS (SELECT users.user_guid
                FROM users
                WHERE dogs.user_guid = users.user_guid)

SELECT DistinctUUsersID.user_guid AS uUserID, d.user_guid AS dUserID, count(*) AS numrows
FROM (SELECT DISTINCT u.user_guid
FROM users u
WHERE u.user_guid = 'ce7b75bc-7144-11e5-ba71-058fbc01cf0b') AS DistinctUUsersID
LEFT JOIN dogs d
ON DistinctUUsersID.user_guid = d.user_guid
GROUP BY DistinctUUsersID.user_guid ORDER BY numrows DESC;

SELECT DISTINCT d.user_guid FROM dogs d;

SELECT DistinctUUsersID.user_guid AS uUserID, DistictDUsersID.user_guid AS dUserID, count(*) AS numrows
FROM (SELECT DISTINCT u.user_guid FROM users u WHERE u.user_guid = 'ce7b75bc-7144-11e5-ba71-058fbc01cf0b') AS DistinctUUsersID
LEFT JOIN (SELECT DISTINCT d.user_guid FROM dogs d) AS DistictDUsersID
ON DistinctUUsersID.user_guid = DistictDUsersID.user_guid 
GROUP BY DistinctUUsersID.user_guid
ORDER BY numrows DESC;