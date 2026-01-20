
--KPI's
--Total Orders
SELECT COUNT(*) AS total_orders
FROM fact_swiggy_orders;

--Total Revenue
SELECT 
    FORMAT(SUM(CONVERT(FLOAT, price_inr)) / 1000000.0, 'N2') 
    + ' INR Million' AS total_revenue_million
FROM fact_swiggy_orders;

--Average Dish Price
SELECT 
    FORMAT(AVG(CONVERT(FLOAT, price_inr)), 'N2') 
    + ' INR' AS avg_price_inr
FROM fact_swiggy_orders;

--Average Rating
SELECT AVG(rating) AS avg_rating
FROM fact_swiggy_orders;