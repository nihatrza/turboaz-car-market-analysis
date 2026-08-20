CREATE VIEW vw_brand_price_deviation AS
SELECT 
    marka,
    model,
    year,
    price,
    ROUND((AVG(price) OVER (PARTITION BY marka))::numeric, 2) AS brand_avg_price,
    ROUND((((price - AVG(price) OVER (PARTITION BY marka)) / AVG(price) OVER (PARTITION BY marka)) * 100)::numeric, 2) AS diff_percentage,
    url
FROM turbo_cars;