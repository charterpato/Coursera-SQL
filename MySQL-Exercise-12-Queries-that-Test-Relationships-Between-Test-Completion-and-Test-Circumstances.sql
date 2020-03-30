SELECT created_at, DAYOFWEEK(created_at)
FROM complete_tests;

SELECT created_at, DAYOFWEEK(created_at),
    CASE DAYOFWEEK(created_at)
    WHEN 1 THEN "SUN"
    WHEN 2 THEN "MON"
    WHEN 3 THEN "TUE"
    WHEN 4 THEN "WED"
    WHEN 5 THEN "THU"
    WHEN 6 THEN "FRI"
    WHEN 7 THEN "SAT"
    END AS day_of_week
FROM complete_tests;

SELECT
    CASE DAYOFWEEK(created_at)
    WHEN 1 THEN "SUN"
    WHEN 2 THEN "MON"
    WHEN 3 THEN "TUE"
    WHEN 4 THEN "WED"
    WHEN 5 THEN "THU"
    WHEN 6 THEN "FRI"
    WHEN 7 THEN "SAT"
    END AS day_of_week, COUNT(created_at) AS testcount
FROM complete_tests
GROUP BY day_of_week
ORDER BY testcount DESC;

SELECT
    CASE DAYOFWEEK(c.created_at)
    WHEN 1 THEN "SUN"
    WHEN 2 THEN "MON"
    WHEN 3 THEN "TUE"
    WHEN 4 THEN "WED"
    WHEN 5 THEN "THU"
    WHEN 6 THEN "FRI"
    WHEN 7 THEN "SAT"
    END AS day_of_week, COUNT(c.created_at) AS testcount
FROM complete_tests c JOIN dogs d
    ON c.dog_guid = d.dog_guid
WHERE d.exclude = 0 OR d.exclude IS NULL
GROUP BY day_of_week
ORDER BY testcount DESC;

SELECT d.dog_guid
FROM dogs d JOIN users u
    ON d.user_guid = u.user_guid;

SELECT DISTINCT d.dog_guid
FROM dogs d JOIN users u
    ON d.user_guid = u.user_guid;

SELECT DISTINCT d.dog_guid
FROM dogs d JOIN users u
    ON d.user_guid = u.user_guid
WHERE (d.exclude = 0 OR d.exclude IS NULL) AND (u.exclude = 0 OR u.exclude IS NULL);

SELECT
    CASE DAYOFWEEK(c.created_at)
    WHEN 1 THEN "SUN"
    WHEN 2 THEN "MON"
    WHEN 3 THEN "TUE"
    WHEN 4 THEN "WED"
    WHEN 5 THEN "THU"
    WHEN 6 THEN "FRI"
    WHEN 7 THEN "SAT"
    END AS day_of_week, COUNT(c.created_at) AS testcount
FROM complete_tests c JOIN 
    (SELECT DISTINCT d.dog_guid
    FROM dogs d JOIN users u
        ON d.user_guid = u.user_guid
    WHERE (d.exclude = 0 OR d.exclude IS NULL) AND (u.exclude = 0 OR u.exclude IS NULL)) AS cleaned_dogid
    ON cleaned_dogid.dog_guid = c.dog_guid
GROUP BY day_of_week
ORDER BY testcount DESC;

SELECT YEAR(c.created_at) AS year_of_test,
    CASE DAYOFWEEK(c.created_at)
    WHEN 1 THEN "SUN"
    WHEN 2 THEN "MON"
    WHEN 3 THEN "TUE"
    WHEN 4 THEN "WED"
    WHEN 5 THEN "THU"
    WHEN 6 THEN "FRI"
    WHEN 7 THEN "SAT"
    END AS day_of_week, COUNT(c.created_at) AS testcount
FROM complete_tests c JOIN 
    (SELECT DISTINCT d.dog_guid
    FROM dogs d JOIN users u
        ON d.user_guid = u.user_guid
    WHERE (d.exclude = 0 OR d.exclude IS NULL) AND (u.exclude = 0 OR u.exclude IS NULL)) AS cleaned_dogid
    ON cleaned_dogid.dog_guid = c.dog_guid
GROUP BY year_of_test, day_of_week
ORDER BY year_of_test ASC, testcount DESC;

SELECT YEAR(c.created_at) AS year_of_test,
    CASE DAYOFWEEK(c.created_at)
    WHEN 1 THEN "SUN"
    WHEN 2 THEN "MON"
    WHEN 3 THEN "TUE"
    WHEN 4 THEN "WED"
    WHEN 5 THEN "THU"
    WHEN 6 THEN "FRI"
    WHEN 7 THEN "SAT"
    END AS day_of_week, COUNT(c.created_at) AS testcount
FROM complete_tests c JOIN 
    (SELECT DISTINCT d.dog_guid
    FROM dogs d JOIN users u
        ON d.user_guid = u.user_guid
    WHERE (d.exclude = 0 OR d.exclude IS NULL) AND (u.exclude = 0 OR u.exclude IS NULL)
    AND u.country = "US" AND u.state != "HI" AND u.state != "AK") AS cleaned_dogid
    ON cleaned_dogid.dog_guid = c.dog_guid
GROUP BY year_of_test, day_of_week
ORDER BY year_of_test ASC, testcount DESC;

SELECT created_at, DATE_SUB(created_at, interval 6 hour) AS corrected_time 
FROM complete_tests;

SELECT YEAR(DATE_SUB(c.created_at, interval 6 hour)) AS year_of_test,
    CASE DAYOFWEEK(DATE_SUB(c.created_at, interval 6 hour))
    WHEN 1 THEN "SUN"
    WHEN 2 THEN "MON"
    WHEN 3 THEN "TUE"
    WHEN 4 THEN "WED"
    WHEN 5 THEN "THU"
    WHEN 6 THEN "FRI"
    WHEN 7 THEN "SAT"
    END AS day_of_week, COUNT(c.created_at) AS testcount
FROM complete_tests c JOIN 
    (SELECT DISTINCT d.dog_guid
    FROM dogs d JOIN users u
        ON d.user_guid = u.user_guid
    WHERE (d.exclude = 0 OR d.exclude IS NULL) AND (u.exclude = 0 OR u.exclude IS NULL)
    AND u.country = "US" AND u.state != "HI" AND u.state != "AK") AS cleaned_dogid
    ON cleaned_dogid.dog_guid = c.dog_guid
GROUP BY year_of_test, day_of_week
ORDER BY year_of_test ASC, testcount DESC;

SELECT YEAR(DATE_SUB(c.created_at, interval 6 hour)) AS year_of_test,
    CASE DAYOFWEEK(DATE_SUB(c.created_at, interval 6 hour))
    WHEN 1 THEN "SUN"
    WHEN 2 THEN "MON"
    WHEN 3 THEN "TUE"
    WHEN 4 THEN "WED"
    WHEN 5 THEN "THU"
    WHEN 6 THEN "FRI"
    WHEN 7 THEN "SAT"
    END AS day_of_week, COUNT(c.created_at) AS testcount
FROM complete_tests c JOIN 
    (SELECT DISTINCT d.dog_guid
    FROM dogs d JOIN users u
        ON d.user_guid = u.user_guid
    WHERE (d.exclude = 0 OR d.exclude IS NULL) AND (u.exclude = 0 OR u.exclude IS NULL)
    AND u.country = "US" AND u.state != "HI" AND u.state != "AK") AS cleaned_dogid
    ON cleaned_dogid.dog_guid = c.dog_guid
GROUP BY year_of_test, day_of_week
ORDER BY year_of_test ASC, FIELD(day_of_week, "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN")

SELECT state, COUNT(DISTINCT user_guid)
FROM(SELECT DISTINCT u.user_guid, u.state
    FROM dogs d JOIN users u
        ON d.user_guid = u.user_guid
    WHERE (d.exclude = 0 OR d.exclude IS NULL) AND (u.exclude = 0 OR u.exclude IS NULL)
    AND u.country = "US") AS cleaned_userid
GROUP BY state
ORDER BY COUNT(DISTINCT user_guid) DESC;

SELECT country, COUNT(DISTINCT user_guid)
FROM(SELECT DISTINCT u.user_guid, u.country
    FROM dogs d JOIN users u
        ON d.user_guid = u.user_guid
    WHERE (d.exclude = 0 OR d.exclude IS NULL) AND (u.exclude = 0 OR u.exclude IS NULL)) AS cleaned_userid
GROUP BY country
ORDER BY COUNT(DISTINCT user_guid) DESC;