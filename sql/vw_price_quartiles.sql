CREATE VIEW vw_price_quartiles AS
WITH QuartiledCars AS (
    SELECT 
        price,
        year,
        mileage, -- cədvəlinizdə walking/mileage/yürüş sütununun adı
        NTILE(4) OVER (ORDER BY price) AS quartile
    FROM turbo_cars
)
SELECT 
    quartile,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    ROUND(AVG(price)::numeric, 2) AS avg_price,
    ROUND(AVG(2026 - year)::numeric, 1) AS avg_car_age,
    ROUND(AVG(mileage)::numeric, 0) AS avg_mileage_km
FROM QuartiledCars
GROUP BY quartile
ORDER BY quartile;