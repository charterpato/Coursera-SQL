SELECT saledate, SUM(amt)
FROM trnsact
WHERE stype = 'P'
GROUP BY saledate
ORDER BY SUM(amt) DESC;

SELECT deptinfo.dept, deptinfo.deptdesc, COUNT(skuinfo.sku)
FROM skuinfo LEFT JOIN deptinfo
    ON skuinfo.dept = deptinfo.dept
GROUP BY deptinfo.dept, deptinfo.deptdesc
ORDER BY COUNT(skuinfo.sku) DESC;

SELECT COUNT(DISTINCT sku)
FROM skstinfo;

SELECT COUNT(DISTINCT sku)
FROM trnsact;

SELECT COUNT(DISTINCT sku)
FROM skuinfo;

SELECT COUNT(*)
FROM skstinfo LEFT JOIN skuinfo
    ON skstinfo.sku = skuinfo.sku
WHERE skuinfo.sku IS NULL;

SELECT SUM(trnsact.amt - trnsact.quantity * skstinfo.cost) / COUNT(DISTINCT trnsact.saledate)
FROM trnsact LEFT JOIN skstinfo
    ON trnsact.sku = skstinfo.sku AND trnsact.store = skstinfo.store
WHERE trnsact.stype = 'P';

SELECT COUNT(msa)
FROM store_msa
WHERE state = 'NC';

SELECT MIN(msa_pop)
FROM store_msa
WHERE state = 'NC';

SELECT MAX(msa_income)
FROM store_msa
WHERE state = 'NC';

SELECT skuinfo.dept, deptinfo.deptdesc, skuinfo.brand, skuinfo.style, skuinfo.color, SUM(trnsact.amt)
FROM skuinfo LEFT JOIN trnsact
    ON skuinfo.sku = trnsact.sku
    LEFT JOIN deptinfo
    ON skuinfo.dept = deptinfo.dept
GROUP BY skuinfo.dept, deptinfo.deptdesc, skuinfo.brand, skuinfo.style, skuinfo.color
ORDER BY SUM(trnsact.amt) DESC;

SELECT store, COUNT(DISTINCT sku)
FROM skstinfo
GROUP BY store
HAVING COUNT(DISTINCT sku) > 180000;

SELECT *
FROM skuinfo LEFT JOIN deptinfo
    ON skuinfo.dept = deptinfo.dept
WHERE deptinfo.deptdesc = 'cop' AND brand = 'federal' AND color = 'rinse wash';

SELECT COUNT(*)
FROM skuinfo LEFT JOIN skstinfo
    ON skstinfo.sku = skuinfo.sku
WHERE skstinfo.sku IS NULL;

SELECT strinfo.store, strinfo.state, strinfo.city, SUM(trnsact.amt)
FROM trnsact LEFT JOIN strinfo
    ON trnsact.store = strinfo.store
WHERE trnsact.stype = 'P'
GROUP BY strinfo.store, strinfo.state, strinfo.city
ORDER BY SUM(trnsact.amt) DESC;

SELECT state, COUNT(store)
FROM strinfo
GROUP BY state
HAVING COUNT(store) > 10;

SELECT *
FROM skuinfo LEFT JOIN deptinfo
    ON skuinfo.dept = deptinfo.dept
    LEFT JOIN trnsact
    ON skuinfo.sku = trnsact.sku
WHERE deptinfo.deptdesc = 'reebook' AND brand = 'skechers' AND color = 'wht/saphire';