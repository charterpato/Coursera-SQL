HELP TABLE strinfo;

HELP COLUMN skstinfo.sku;

SELECT TOP 10 *
FROM strinfo;

SELECT TOP 10 *
FROM strinfo
ORDER BY city ASC;

SELECT *
FROM strinfo
SAMPLE 10;

SELECT *
FROM strinfo
SAMPLE .10;

SELECT *
FROM trnsact
WHERE amt <> sprice;

SELECT *
FROM trnsact
WHERE orgprice = 0;

SELECT *
FROM skstinfo
WHERE cost = 0 AND retail = 0;

SELECT STATE, COUNT(STORE)
FROM strinfo
GROUP BY STATE
ORDER BY COUNT(STORE) DESC;