CREATE VIEW vw_yoy_price_trends AS
WITH YearlyStats AS (
    SELECT 
        year,
        COUNT(*) AS total_cars,
        ROUND(AVG(price)::numeric, 2) AS avg_price
    FROM turbo_cars
    GROUP BY year
)
SELECT 
    year,
    total_cars,
    avg_price,
    LAG(avg_price) OVER (ORDER BY year) AS prev_year_avg_price,
    ROUND((((avg_price - LAG(avg_price) OVER (ORDER BY year)) / LAG(avg_price) OVER (ORDER BY year)) * 100)::numeric, 2) AS yoy_price_change_pct
FROM YearlyStats
ORDER BY year;