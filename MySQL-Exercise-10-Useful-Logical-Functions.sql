SELECT created_at, IF(created_at < '2014-06-01', 'early_user', 'late_user') AS user_type
FROM users;

SELECT cleaned_users.user_guid as UserID,
       IF(cleaned_users.first_account < '2014-06-01', 'early_user', 'late_user') AS user_type
FROM (SELECT user_guid, MIN(created_at) AS first_account 
      FROM users
      GROUP BY user_guid) AS cleaned_users;

SELECT IF(cleaned_users.first_account < '2014-06-01', 'early_user', 'late_user') AS user_type,
       COUNT(cleaned_users.first_account)
FROM (SELECT user_guid, MIN(created_at) AS first_account 
      FROM users
      GROUP BY user_guid) AS cleaned_users
GROUP BY user_type;

SELECT DISTINCT user_guid, country
FROM users
WHERE user_guid IS NOT NULL AND country IS NOT NULL;

SELECT user_guid_resident.resident, COUNT(DISTINCT user_guid_resident.user_guid)
FROM (SELECT DISTINCT user_guid, IF(country = "US", "US resident", "Non-US resisent") AS resident
        FROM users
        WHERE user_guid IS NOT NULL AND country IS NOT NULL) AS user_guid_resident
GROUP BY user_guid_resident.resident;

SELECT IF(user_guid_resident.country = "US", "US resident", "Non-US resident") AS resident, 
        COUNT(DISTINCT user_guid_resident.user_guid)
FROM (SELECT DISTINCT user_guid, country
        FROM users
        WHERE user_guid IS NOT NULL AND country IS NOT NULL) AS user_guid_resident
GROUP BY resident;

SELECT IF(user_guid_resident.country = "US", "US resident", 
         IF(user_guid_resident.country = 'N/A', 'Not Applicable', 'Non-US resident')) AS resident, 
        COUNT(DISTINCT user_guid_resident.user_guid)
FROM (SELECT DISTINCT user_guid, country
        FROM users
        WHERE user_guid IS NOT NULL AND country IS NOT NULL) AS user_guid_resident
GROUP BY resident;

SELECT CASE WHEN user_guid_resident.country = "US" THEN "US residernt"
            WHEN user_guid_resident.country = "N/A" THEN "Not Applicable"
            ELSE "Non-US resident"
            END AS resident, 
         COUNT(DISTINCT user_guid_resident.user_guid)
FROM (SELECT DISTINCT user_guid, country 
      FROM users
      WHERE country IS NOT NULL) AS user_guid_resident
GROUP BY resident;

SELECT CASE user_guid_resident.country
            WHEN "US" THEN "US resident"
            WHEN "N/A" THEN "Not Applicable"
            ELSE "Non-US resident"
            END AS resident, 
      count(DISTINCT user_guid_resident.user_guid)   
FROM (SELECT DISTINCT user_guid, country 
      FROM users
      WHERE country IS NOT NULL) AS user_guid_resident
GROUP BY resident;

SELECT dog_guid, dog_fixed,
        CASE dog_fixed
        WHEN 1 THEN "neutered"
        WHEN 0 THEN "not neutered"
        ELSE "NULL"
        END AS dog_fixed_desc
FROM dogs;

SELECT dog_guid, exclude,
        CASE exclude
        WHEN 1 THEN "exclude"
        ELSE "keep"
        END AS exclude_desc
FROM dogs;

SELECT dog_guid, exclude, IF(exclude = 1, "exclude", "keep") AS exclude_desc
FROM dogs;

SELECT dog_guid, weight,
    CASE WHEN weight <= 10 THEN "very small"
        WHEN weight > 10 AND weight <= 30 THEN "small"
        WHEN weight > 30 AND weight <= 50 THEN "medium"
        WHEN weight > 50 AND weight <= 85 THEN "large"
        WHEN weight > 85 THEN "very large" 
        END AS weight_scale
FROM dogs;

SELECT COUNT(DISTINCT dog_guid), 
CASE WHEN breed_group = 'Sporting' OR breed_group = 'Herding' AND exclude != '1' THEN "group 1"
     ELSE "everything else"
     END AS groups
FROM dogs
GROUP BY groups;

SELECT COUNT(DISTINCT dog_guid), 
CASE WHEN exclude != '1' AND breed_group = 'Sporting' OR breed_group = 'Herding' THEN "group 1"
     ELSE "everything else"
     END AS group_name
FROM dogs
GROUP BY group_name;

SELECT COUNT(DISTINCT dog_guid), 
CASE WHEN exclude != '1' AND (breed_group = 'Sporting' OR breed_group = 'Herding') THEN "group 1"
     ELSE "everything else"
     END AS group_name
FROM dogs
GROUP BY group_name;

SELECT dogs.dog_guid, dogs.breed_type, 
    IF(breed_type = "Pure Breed", "Pure Breed", "Not_Pure_Breed") AS pure_breed,
    COUNT(complete_tests.created_at)
FROM dogs, complete_tests
WHERE dogs.dog_guid = complete_tests.dog_guid
GROUP BY dogs.dog_guid, dogs.breed_type, pure_breed；

SELECT CASE
WHEN (state="NY" OR state="NJ") THEN "Group 1" 
WHEN (state="NC" OR state="SC") THEN "Group 2" 
WHEN state="CA" THEN "Group 3"
ELSE "Group 4"
END AS state_group, COUNT(DISTINCT user_guid)
FROM users
WHERE country="US" AND state IS NOT NULL
GROUP BY state_group;

SELECT dna_tested, dimension, COUNT(DISTINCT dog_guid)
FROM dogs
WHERE dna_tested = 1 AND (dimension = "stargazer" OR dimension = "socialite");