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

-- UNION select to display all the money buy from rent and sold houses
SELECT propertyID, price FROM BuyTransaction
UNION 
SELECT propertyID, price FROM RentTransaction;

-- Minus select to select all estate agents who currently aren't dealing with buyers
SELECT agentID, agentName, agentPhoneNum FROM EstateAgent
MINUS
SELECT agentID, agentName, agentPhoneNum FROM EstateAgent
JOIN Buyer USING (agentID);

-- Difference to select all agents that have not rented out a property.
SELECT agentID, agentName, agentPhoneNum FROM EstateAgent
WHERE agentID NOT IN 
    (SELECT agentID FROM RentTransaction);

-- Inner Join, this shows the buyers and who is estate agent consulting them
SELECT buyerName, agentName FROM Buyer
INNER JOIN EstateAgent USING(agentID);

-- Outter Join to show the seller detials and the how the property they are selling
SELECT sellerName, sellerPhoneNum, address, numBedrooms FROM Seller
OUTER JOIN Property USING (SellerID);

--Semi Join to select property details on properties that have been rented out
SELECT propertyID, address, propertyType FROM Property
WHERE propertyID IN 
    (SELECT propertyID FROM rentTransaction);


-- Anti Join, to find all Apartments that are not put up for Sale currently.
SELECT propertyID, address, propertyType FROM Property
LEFT JOIN ForSale USING (propertyID)
WHERE propertyType = 'Apartment';
 
-- Correlated sub-query to select information about the agents who sold properties
SELECT agentID, agentName, agentPhoneNum, agentEmail 
FROM EstateAgent outer
WHERE agentID =
    (SELECT agentID FROM BuyTransaction
     WHERE agentID = outer.agentID);