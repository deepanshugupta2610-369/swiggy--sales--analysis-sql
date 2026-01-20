--GRANULAR REQUIREMENTS

--Top 10 Cities by Orders
SELECT 
    l.city,
    COUNT(*) AS total_orders
FROM fact_swiggy_orders f
JOIN dim_location l ON f.location_id = l.location_id
GROUP BY l.city
ORDER BY total_orders DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


--Top 10 Restaurants by Orders
SELECT 
    r.restaurant_name,
    COUNT(*) AS total_orders
FROM fact_swiggy_orders f
JOIN dim_restaurant r ON f.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY total_orders DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


--Top Categories by Order Volume
SELECT 
    c.category,
    COUNT(*) AS total_orders
FROM fact_swiggy_orders f
JOIN dim_category c ON f.category_id = c.category_id
GROUP BY c.category
ORDER BY total_orders DESC;


--Most Ordered Dishes
SELECT 
    d.dish_name,
    COUNT(*) AS order_count
FROM fact_swiggy_orders f
JOIN dim_dish d ON f.dish_id = d.dish_id
GROUP BY d.dish_name
ORDER BY order_count DESC;


--Total Revenue by State
SELECT 
    l.state,
    SUM(CONVERT(FLOAT, f.price_inr)) AS total_revenue_inr
FROM fact_swiggy_orders f
JOIN dim_location l ON f.location_id = l.location_id
GROUP BY l.state
ORDER BY total_revenue_inr DESC;


--Total Orders by Price Range
SELECT
    CASE 
        WHEN CONVERT(FLOAT, price_inr) < 100 THEN 'Under 100'
        WHEN CONVERT(FLOAT, price_inr) BETWEEN 100 AND 199 THEN '100 - 199'
        WHEN CONVERT(FLOAT, price_inr) BETWEEN 200 AND 299 THEN '200 - 299'
        WHEN CONVERT(FLOAT, price_inr) BETWEEN 300 AND 499 THEN '300 - 499'
        ELSE '500+'
    END AS price_range,
    COUNT(*) AS total_orders
FROM fact_swiggy_orders
GROUP BY 
    CASE 
        WHEN CONVERT(FLOAT, price_inr) < 100 THEN 'Under 100'
        WHEN CONVERT(FLOAT, price_inr) BETWEEN 100 AND 199 THEN '100 - 199'
        WHEN CONVERT(FLOAT, price_inr) BETWEEN 200 AND 299 THEN '200 - 299'
        WHEN CONVERT(FLOAT, price_inr) BETWEEN 300 AND 499 THEN '300 - 499'
        ELSE '500+'
    END
ORDER BY total_orders DESC;



--Rating Count Distribution (1–5)
SELECT 
    rating,
    COUNT(*) AS rating_count
FROM fact_swiggy_orders
GROUP BY rating
ORDER BY rating;


--Cuisine Performance (Orders + Avg Rating)
SELECT 
    c.category,
    COUNT(*) AS total_orders,
    AVG(CONVERT(FLOAT, f.rating)) AS avg_rating
FROM fact_swiggy_orders f
JOIN dim_category c ON f.category_id = c.category_id
GROUP BY c.category
ORDER BY total_orders DESC;
