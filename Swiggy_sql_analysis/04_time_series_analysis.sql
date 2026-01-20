
--Time-series trends (Monthly / Quarterly / Yearly)

--Monthly Orders (YYYY-MM)
SELECT 
    d.year,
    d.month,
    d.month_name,
    COUNT(*) AS total_orders
FROM fact_swiggy_orders f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;


--Quarterly Orders (Q1, Q2, Q3, Q4)
SELECT 
    d.year,
    d.quarter,
    COUNT(*) AS total_orders
FROM fact_swiggy_orders f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.quarter
ORDER BY d.year, d.quarter;


--Yearly Orders
SELECT 
    d.year,
    COUNT(*) AS total_orders
FROM fact_swiggy_orders f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year
ORDER BY d.year;


--Orders by Day of Week (Mon–Sun)
SELECT 
    DATENAME(WEEKDAY, d.full_date) AS day_name,
    COUNT(*) AS total_orders
FROM fact_swiggy_orders f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY DATENAME(WEEKDAY, d.full_date), DATEPART(WEEKDAY, d.full_date)
ORDER BY DATEPART(WEEKDAY, d.full_date);
