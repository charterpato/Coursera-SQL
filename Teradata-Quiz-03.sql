SELECT COUNT(DISTINCT sku)
FROM skuinfo
WHERE brand = 'Polo fas' AND (size = 'XXL' OR color = 'black');

SELECT store, EXTRACT(YEAR from saledate) AS year_saledate, EXTRACT(MONTH from saledate) AS month_saledate, 
        COUNT(DISTINCT saledate) AS num_dates
FROM trnsact
WHERE stype = 'P' AND (year_saledate <> 2005 OR month_saledate <> 8)
GROUP BY store, year_saledate, month_saledate
HAVING num_dates = 11;

SELECT state, city, store
FROM strinfo
WHERE store = 6402;

SELECT vendor, COUNT(DISTINCT trnsact.sku)
FROM trnsact 
JOIN skstinfo
ON trnsact.sku = skstinfo.sku AND trnsact.store = skstinfo.store
JOIN skuinfo
ON trnsact.sku = skuinfo.sku
GROUP BY vendor
ORDER BY COUNT(DISTINCT trnsact.sku) DESC;

sku, brand, STAD(sprice)