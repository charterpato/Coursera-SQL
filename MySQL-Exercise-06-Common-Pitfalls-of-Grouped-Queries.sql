SELECT test_name, MONTH(created_at) AS month, COUNT(created_at) AS num_completed_tests
FROM complete_tests
GROUP BY test_name
ORDER BY test_name ASC, month ASC;