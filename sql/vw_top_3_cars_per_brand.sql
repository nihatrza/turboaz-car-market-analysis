CREATE VIEW vw_top_3_cars_per_brand AS
WITH RankedCars AS (
    SELECT 
        marka,
        model,
        price,
        year,
        engine_volume,
        url,
        ROW_NUMBER() OVER (PARTITION BY marka ORDER BY price DESC) AS rn
    FROM turbo_cars
)
SELECT 
    marka,
    model,
    price,
    year,
    engine_volume,
    url
FROM RankedCars
WHERE rn <= 3;