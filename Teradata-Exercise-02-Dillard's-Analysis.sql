SELECT sku, store, COUNT(*)
FROM skstinfo
GROUP BY sku, store
ORDER BY COUNT(*);

SELECT COUNT(DISTINCT store)
FROM strinfo;

SELECT COUNT(DISTINCT a.store)
FROM strinfo a
    LEFT JOIN store_msa b
        ON a.store = b.store
    LEFT JOIN  trnsact c
        ON a.store = c.store
    LEFT JOIN  skstinfo d
        ON a.store = d.store
WHERE a.store IS NOT NULL


SELECT strinfo.store, store_msa.store, trnsact.store, skstinfo.store
FROM strinfo
    LEFT JOIN store_msa
        ON strinfo.store = store_msa.store
    LEFT JOIN trnsact
        ON strinfo.store = trnsact.store
    LEFT JOIN  skstinfo
        ON strinfo.store = skstinfo.store

SELECT TOP 10 *
FROM trnsact LEFT JOIN skstinfo
    ON trnsact.store = skstinfo.store AND trnsact.sku = skstinfo.sku
WHERE skstinfo.sku IS NULL

SELECT trnsact.register, 
SUM(trnsact.amt - trnsact.quantity * skstinfo.cost) / COUNT(DISTINCT trnsact.saledate)
FROM trnsact LEFT JOIN skstinfo
    ON trnsact.store = skstinfo.store AND trnsact.sku = skstinfo.sku
WHERE trnsact.stype = 'P'
GROUP BY trnsact.register;

SELECT saledate, SUM(amt)
FROM trnsact
WHERE stype = 'R'
GROUP BY saledate
ORDER BY SUM(amt) DESC;

SELECT saledate, SUM(quantity)
FROM trnsact
WHERE stype = 'R'
GROUP BY saledate
ORDER BY SUM(quantity) DESC;

SELECT orgprice
FROM trnsact
WHERE stype = 'P'
ORDER BY orgprice;

SELECT MAX(orgprice), MAX(sprice)
FROM trnsact
WHERE stype = 'P';

SELECT MIN(orgprice), MIN(sprice)
FROM trnsact
WHERE stype = 'P';

SELECT MIN(orgprice), MIN(sprice)
FROM trnsact
WHERE stype = 'P';

SELECT deptinfo.dept, COUNT(skuinfo.brand)
FROM deptinfo LEFT JOIN skuinfo
    ON deptinfo.dept = skuinfo.dept
ORDER BY deptinfo.dept
HAVING COUNT(skuinfo.brand) > 100;

SELECT skuinfo.dept, deptinfo.deptdesc, COUNT(DISTINCT skuinfo.brand)
FROM skuinfo LEFT JOIN deptinfo
   ON skuinfo.dept = deptinfo.dept
GROUP BY skuinfo.dept, deptinfo.deptdesc
HAVING COUNT(DISTINCT skuinfo.brand) > 100;

SELECT DISTINCT skstinfo.sku, deptinfo.dept
FROM skstinfo LEFT JOIN skuinfo
    ON skstinfo.sku = skuinfo.sku
    LEFT JOIN deptinfo
    ON skuinfo.dept = deptinfo.dept;

SELECT skuinfo.dept, skuinfo.brand, skuinfo.style, skuinfo.color, deptinfo.deptdesc, SUM(trnsact.amt)
FROM skuinfo LEFT JOIN trnsact
    ON skuinfo.sku = trnsact.sku
    LEFT JOIN deptinfo
    ON  skuinfo.dept = deptinfo.dept
WHERE trnsact.stype = 'R'
GROUP BY skuinfo.dept, skuinfo.brand, skuinfo.style, skuinfo.color, deptinfo.deptdesc
ORDER BY SUM(trnsact.amt) DESC;

SELECT strinfo.store, strinfo.state, strinfo.zip, SUM(trnsact.amt)
FROM strinfo LEFT JOIN trnsact
    ON strinfo.store = trnsact.store
GROUP BY store, state, zip

SELECT TOP 10 strinfo.store, strinfo.state, strinfo.zip, SUM(trnsact.amt)
FROM strinfo LEFT JOIN trnsact
    ON strinfo.store = trnsact.store
WHERE trnsact.stype = 'p'
GROUP BY strinfo.store, strinfo.state, strinfo.zip
ORDER BY SUM(trnsact.amt) DESC;