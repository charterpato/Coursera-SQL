SELECT d.dog_guid AS dogID, d.user_guid AS userID, AVG(r.rating) AS avg_rating, 
       COUNT(r.rating) AS num_ratings, d.breed, d.breed_group, d.breed_type
FROM dogs d, reviews r
WHERE d.dog_guid = r.dog_guid AND d.user_guid = r.user_guid
GROUP BY userID, dogID, d.breed, d.breed_group, d.breed_type
HAVING num_ratings >= 10
ORDER BY avg_rating DESC
LIMIT 200;

SELECT d.user_guid, d.dog_guid, d.breed, d.breed_type, d.breed_group
FROM dogs d, complete_tests c
WHERE d.dog_guid = c.dog_guid AND c.test_name = "Yawn Warm-up";

SELECT d.user_guid, u.state, u.zip, d.dog_guid, d.breed, d.breed_type, d.breed_group
FROM dogs d, complete_tests c, users u
WHERE d.dog_guid = c.dog_guid 
   AND d.user_guid = u.user_guid
   AND c.test_name="Yawn Warm-up";

SELECT DISTINCT d.user_guid, u.membership_type, d.dog_guid, d.breed
FROM users u, dogs d, complete_tests c
WHERE u.user_guid = d.user_guid 
AND d.dog_guid = c.dog_guid
AND d.breed = "golden retriever";

SELECT COUNT(DISTINCT d.dog_guid)
FROM users u, dogs d
WHERE u.user_guid = d.user_guid
AND u.state = "NC"
AND d.breed = "Golden Retriever";

SELECT u.membership_type, COUNT(DISTINCT r.user_guid)
FROM users u, reviews r
WHERE u.user_guid=r.user_guid AND r.rating IS NOT NULL
GROUP BY membership_type;

SELECT d.breed, COUNT(s.script_detail_id)
FROM dogs d, site_activities s
WHERE d.dog_guid = s.dog_guid
AND s.script_detail_id IS NOT NULL
GROUP BY d.breed
ORDER BY COUNT(s.script_detail_id) DESC;