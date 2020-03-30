SELECT EXTRACT(YEAR from saledate) AS year_saledate, EXTRACT(MONTH from saledate) AS month_saledate, COUNT(DISTINCT saledate)
FROM trnsact
GROUP BY year_saledate, month_saledate
ORDER BY year_saledate ASC, month_saledate ASC;

SELECT sku, SUM(amt)
FROM trnsact
WHERE stype = 'P' AND (EXTRACT(MONTH from saledate) = 6 OR EXTRACT(MONTH from saledate) = 7 OR EXTRACT(MONTH from saledate) = 8)
GROUP BY sku
ORDER BY SUM(amt) DESC;

SELECT sku, SUM(amt)
FROM(SELECT sku, amt, saledate, CASE EXTRACT(MONTH from saledate)
WHEN 6 THEN 'summer month'
WHEN 7 THEN 'summer month'
WHEN 8 THEN 'summer month'
ELSE 'non-summer month'
END AS summer_month
FROM trnsact
WHERE stype = 'P') AS summer_month_filter
WHERE summer_month = 'summer month'
GROUP BY sku
ORDER BY SUM(amt) DESC;

SELECT EXTRACT(YEAR from saledate) AS year_saledate, EXTRACT(MONTH from saledate) AS month_saledate, store, COUNT(DISTINCT saledate)
FROM trnsact
GROUP BY year_saledate, month_saledate, store
ORDER BY COUNT(DISTINCT saledate) ASC;

SELECT store, EXTRACT(YEAR from saledate) AS year_saledate, EXTRACT(MONTH from saledate) AS month_saledate, 
        COUNT(DISTINCT saledate) AS num_dates, SUM(amt) AS total_revenue, num_dates/total_revenue AS daily_revenue
FROM trnsact
WHERE stype = 'P' AND (year_saledate <> 2005 OR month_saledate <> 8)
GROUP BY store, year_saledate, month_saledate
HAVING num_dates >= 20;

SELECT 
(CASE
WHEN s.msa_high >= 50 AND s.msa_high < 60 THEN 'low'
WHEN s.msa_high >= 60 AND s.msa_high < 70 THEN 'med'
WHEN s.msa_high >= 70 THEN 'high'
END) AS education_level, SUM(daily_revenue_info.total_revenue)/SUM(daily_revenue_info.num_dates) AS daily_revenue_education
FROM store_msa s  
    JOIN(SELECT store, EXTRACT(YEAR from saledate) AS year_saledate, EXTRACT(MONTH from saledate) AS month_saledate, 
                COUNT(DISTINCT saledate) AS num_dates, SUM(amt) AS total_revenue
        FROM trnsact
        WHERE stype = 'P' AND (year_saledate <> 2005 OR month_saledate <> 8)
        GROUP BY store, month_saledate, year_saledate
        HAVING num_dates >= 20) AS daily_revenue_info
    ON s.store = daily_revenue_info.store
GROUP BY education_level;

SELECT s.city, s.state, SUM(daily_revenue_info.total_revenue)/SUM(daily_revenue_info.num_dates) AS daily_revenue_education
FROM store_msa s  
    JOIN(SELECT store, EXTRACT(YEAR from saledate) AS year_saledate, EXTRACT(MONTH from saledate) AS month_saledate, 
                COUNT(DISTINCT saledate) AS num_dates, SUM(amt) AS total_revenue
        FROM trnsact
        WHERE stype = 'P' AND (year_saledate <> 2005 OR month_saledate <> 8)
        GROUP BY store, month_saledate, year_saledate
        HAVING num_dates >= 20) AS daily_revenue_info
    ON s.store = daily_revenue_info.store
GROUP BY s.city, s.state;

SELECT DISTINCT t.sku AS item, s.brand AS brand, STDDEV_SAMP(t.sprice) AS dev_price,
    COUNT(DISTINCT(t.SEQ||t.STORE||t.REGISTER||t.TRANNUM||t.SALEDATE)) AS distinct_transactions
FROM TRNSACT t
	JOIN SKUINFO s
		ON t.sku = s.sku
WHERE t.stype = 'p'
GROUP BY item, brand
HAVING distinct_transactions > 100
ORDER BY dev_price DESC;

SELECT DISTINCT(s.sku) AS item, s.brand, AVG(t.sprice) AS avg_price, STDDEV_SAMP(t.sprice) AS variation_price, 
        avg(t.orgprice)-avg(t.sprice) AS sale_price_diff, COUNT(distinct(t.trannum)) AS distinct_transactions
FROM skuinfo s 
    JOIN trnsact t
        ON s.sku = t.sku
WHERE t.stype='p'
GROUP BY items, s.brand
HAVING distinct_transactions > 100
ORDER BY variation_price DESC;

SELECT 
    (CASE month_saledate
        WHEN 1 THEN 'Jan'
        WHEN 2 THEN 'Feb'
        WHEN 3 THEN 'Mar'
        WHEN 4 THEN 'Apr'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'Jun'
        WHEN 7 THEN 'Jul'
        WHEN 8 THEN 'Aug'
        WHEN 9 THEN 'Sep'
        WHEN 10 THEN 'Oct'
        WHEN 11 THEN 'Nov'
        WHEN 12 THEN 'Dec'
        END) as month_name, 
    SUM(total_revenue)/SUM(num_dates) AS avg_monthly_revenue
FROM (SELECT store, EXTRACT(YEAR from saledate) AS year_saledate, EXTRACT(MONTH from saledate) AS month_saledate, 
            COUNT(DISTINCT saledate) AS num_dates, SUM(amt) AS total_revenue
        FROM trnsact
        WHERE stype = 'P' AND (year_saledate <> 2005 OR month_saledate <> 8)
        GROUP BY store, month_saledate, year_saledate
        HAVING num_dates >= 20) AS daily_revenue_info
GROUP BY month_name
ORDER BY avg_monthly_revenue DESC; 