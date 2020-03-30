HELP TABLE strinfo;

SELECT *
FROM strinfo
WHERE zip is NULL;

SELECT sku, orgprice
FROM trnsact
WHERE sku = 3631365
ORDER BY orgprice DESC;

SELECT color, brand, sku
FROM skuinfo
WHERE brand = 'LIZ CLAI'
ORDER BY sku DESC;

SELECT TOP 10 sku, orgprice
FROM trnsact
ORDER BY orgprice DESC;

SELECT DISTINCT state
FROM strinfo;

SELECT deptdesc
FROM deptinfo
WHERE deptdesc LIKE 'e%';

SELECT TOP 10 saledate, orgprice - sprice AS margin
FROM trnsact
WHERE orgprice <> sprice
ORDER BY saledate ASC, margin DESC

SELECT TOP 10 register
FROM trnsact
WHERE saledate BETWEEN '2004-08-01' AND '2004-08-10'
ORDER BY orgprice DESC, sprice DESC;

SELECT store
FROM store_MSA
WHERE city IN ('little rock', 'memphis', 'tulsa')
ORDER BY store ASC;