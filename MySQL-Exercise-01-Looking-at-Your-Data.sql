SELECT breed
FROM dogs;

SELECT breed
FROM dogs LIMIT 10;

SELECT breed
FROM dogs LIMIT 5, 10;

SELECT breed, breed_type
FROM dogs LIMIT 5, 10;

SELECT *
FROM dogs LIMIT 5, 10;

SELECT median_iti_minutes / 60, median_iti_minutes
FROM dogs LIMIT 5, 10;

SELECT dog_guid, subcategory_name, test_name
FROM reviews LIMIT 15;

SELECT activity_type, created_at, updated_at
FROM site_activities LIMIT 49, 10;

SELECT *
FROM users LIMIT 1999, 20;