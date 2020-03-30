SELECT DISTINCT dimension
FROM dogs;

SELECT dogs.dog_guid, dogs.dimension, COUNT(complete_tests.created_at)
FROM complete_tests, dogs
WHERE complete_tests.dog_guid = dogs.dog_guid
GROUP BY dogs.dog_guid;

SELECT dogs.dog_guid, dogs.dimension, COUNT(complete_tests.created_at)
FROM complete_tests JOIN dogs
    ON complete_tests.dog_guid = dogs.dog_guid
GROUP BY dogs.dog_guid;

SELECT dog_dimesion_createdat.dimension, AVG(dog_dimesion_createdat.tests_count)
FROM(SELECT DISTINCT dogs.dog_guid, dogs.dimension, COUNT(complete_tests.created_at) AS tests_count
    FROM complete_tests JOIN dogs
        ON complete_tests.dog_guid = dogs.dog_guid
    GROUP BY dogs.dog_guid, dogs.dimension) AS dog_dimesion_createdat
GROUP BY dog_dimesion_createdat.dimension;

SELECT dimension, COUNT(dog_guid)
FROM(SELECT dogs.dog_guid, dogs.dimension
    FROM complete_tests JOIN dogs
    ON complete_tests.dog_guid = dogs.dog_guid
     WHERE dogs.dimension IS NULL OR dogs.dimension=''
    GROUP BY dogs.dog_guid) AS dog_dimesion_createdat
GROUP BY dimension;

SELECT d.dog_guid, d.breed, d.weight, d.exclude, MIN(c.created_at) AS mintest, MAX(c.created_at) AS maxtest, COUNT(c.created_at) AS counttest
FROM complete_tests c JOIN dogs d
ON c.dog_guid = d.dog_guid
WHERE d.dimension IS NOT NULL AND d.dimension != ''
GROUP BY d.dog_guid;

SELECT dimension, AVG(tests_count), COUNT(tests_count)
FROM(SELECT DISTINCT dogs.dog_guid, dogs.dimension, COUNT(complete_tests.created_at) AS tests_count
    FROM complete_tests JOIN dogs
            ON complete_tests.dog_guid = dogs.dog_guid
    WHERE dogs.dimension != "" AND dogs.dimension IS NOT NULL AND (dogs.exclude = 0 OR dogs.exclude IS NULL)
    GROUP BY dogs.dog_guid, dogs.dimension) AS dog_dimesion_createdat
GROUP BY dimension;

SELECT DISTINCT breed_group
FROM dogs;

SELECT d.dog_guid, d.breed, d.weight, d.exclude, MIN(c.created_at), MAX(c.created_at), COUNT(c.created_at)
FROM dogs d JOIN complete_tests c
    ON d.dog_guid = c.dog_guid
WHERE d.breed_group IS NULL
GROUP BY d.dog_guid;

SELECT breed_group, AVG(tests_count), COUNT(tests_count)
FROM(SELECT dogs.dog_guid, dogs.breed_group, COUNT(complete_tests.created_at) AS tests_count
    FROM complete_tests JOIN dogs
            ON complete_tests.dog_guid = dogs.dog_guid
    WHERE dogs.exclude = 0 OR dogs.exclude IS NULL
    GROUP BY dogs.dog_guid, dogs.breed_group) AS dog_dimesion_createdat
GROUP BY breed_group;

SELECT breed_group, AVG(tests_count), COUNT(tests_count)
FROM(SELECT dogs.dog_guid, dogs.breed_group, COUNT(complete_tests.created_at) AS tests_count
    FROM complete_tests JOIN dogs
            ON complete_tests.dog_guid = dogs.dog_guid
    WHERE (dogs.exclude = 0 OR dogs.exclude IS NULL) AND (dogs.breed_group IN ("Sporting", "Hound", "Herding", "Working"))
    GROUP BY dogs.dog_guid, dogs.breed_group) AS dog_dimesion_createdat
GROUP BY breed_group;

SELECT DISTINCT breed_type
FROM dogs;

SELECT d.dog_guid, d.breed_type,
    CASE d.breed_type
    WHEN "Pure Breed" THEN "Pure_Breed"
    ELSE "Not_Pure_Breed"
    END AS pure_breed, COUNT(c.created_at)
FROM complete_tests c JOIN dogs d
    ON c.dog_guid = d.dog_guid
GROUP BY d.dog_guid;

SELECT pure_breed, AVG(testsum), COUNT(testsum)
FROM(SELECT d.dog_guid, d.breed_type,
        CASE d.breed_type
        WHEN "Pure Breed" THEN "Pure_Breed"
        ELSE "Not_Pure_Breed"
        END AS pure_breed, COUNT(c.created_at) AS testsum
    FROM complete_tests c JOIN dogs d
        ON c.dog_guid = d.dog_guid
    WHERE d.exclude IS NULL OR d.exclude = 0
    GROUP BY d.dog_guid) AS dog_breed_test
GROUP BY pure_breed;

SELECT pure_breed, dog_fixed, AVG(testsum), COUNT(testsum)
FROM(SELECT d.dog_guid, d.breed_type, d.dog_fixed,
        CASE d.breed_type
        WHEN "Pure Breed" THEN "Pure_Breed"
        ELSE "Not_Pure_Breed"
        END AS pure_breed, COUNT(c.created_at) AS testsum
    FROM complete_tests c JOIN dogs d
        ON c.dog_guid = d.dog_guid
    WHERE d.exclude IS NULL OR d.exclude = 0
    GROUP BY d.dog_guid, pure_breed, d.dog_fixed) AS dog_breed_test
GROUP BY pure_breed, dog_fixed;

SELECT dimension, AVG(tests_count), COUNT(tests_count), STDDEV(tests_count)
FROM(SELECT dogs.dog_guid, dogs.dimension, COUNT(complete_tests.created_at) AS tests_count
    FROM complete_tests JOIN dogs
            ON complete_tests.dog_guid = dogs.dog_guid
    WHERE dogs.dimension != "" AND dogs.dimension IS NOT NULL AND (dogs.exclude = 0 OR dogs.exclude IS NULL)
    GROUP BY dogs.dog_guid, dogs.dimension) AS dog_dimesion_createdat
GROUP BY dimension;

SELECT d.breed_type, AVG(TIMESTAMPDIFF(MINUTE, e.start_time, e.end_time)) AS avg_duration,
        STDDEV(TIMESTAMPDIFF(MINUTE, e.start_time, e.end_time)) AS studev_duration
FROM dogs d JOIN exam_answers e
        ON d.dog_guid = e.dog_guid
WHERE TIMESTAMPDIFF(MINUTE, e.start_time, e.end_time) > 0
GROUP BY breed_type;

