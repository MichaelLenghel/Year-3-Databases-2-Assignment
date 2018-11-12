--Selection query to get all properties
SELECT * FROM property;

-- Projection to select cheap properties, cost less than 100'000
SELECT * FROM property 
WHERE price < 100000;

-- Aggregation select, this shows how many properties have how many bedrooms
SELECT numBedrooms, COUNT(propertyID)
FROM property 
GROUP BY numBedrooms 
ORDER BY numBedrooms;



