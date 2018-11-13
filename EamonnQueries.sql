--Selection,
SELECT * FROM EstateAgent;

--Projection, find all employees with es.ie email 
SELECT agentName, agentEmail, startDate FROM EstateAgent
WHERE agentEmail LIKE '%es.ie';

--Aggregation with filters on aggregates, count how many of each type of property are for sale with AVG price
SELECT 
    COUNT(propertyID) AS Available, 
    propertyType AS Property,
    CAST(AVG(price) AS DECIMAL(10,2)) AS Average_Price
FROM Property
GROUP BY propertyType
ORDER BY Available DESC;

--Union, get all the clients that the company has dealt with buyers and sellers
SELECT DISTINCT buyerName FROM Buyer
UNION
SELECT DISTINCT sellerName FROM Seller;

--Minus, find properties that havent been sold or rented
SELECT propertyID FROM Property
MINUS
SELECT propertyID FROM RentTransaction
INTERSECT
SELECT propertyID FROM Property
MINUS
SELECT propertyID FROM BuyTransaction;
--Difference, 


--Inner Join, 
SELECT 
    buyerName,
    Buyer.maxPreferredPrice AS Max,
    Buyer.minPreferredPrice AS Min,
    BuyTransaction.price AS Price,
    Buyer.maxPreferredPrice - BuyTransaction.price AS Saved
FROM Buyer
INNER JOIN BuyTransaction ON buytransaction.buyerid = buyer.buyerid
WHERE buytransaction.price > (buytransaction.price - buyer.maxpreferredprice);

--Outer Join, 
SELECT 
    buyerName,
    Buyer.maxPreferredPrice AS Max,
    Buyer.minPreferredPrice AS Min,
    BuyTransaction.price AS Price,
    Buyer.maxPreferredPrice - BuyTransaction.price AS Saved
FROM Buyer
FULL OUTER JOIN BuyTransaction ON buytransaction.buyerid = buyer.buyerid
WHERE buytransaction.price > (buytransaction.price - buyer.maxpreferredprice);

--Semi-join, 
SELECT * FROM BuyTransaction
WHERE EXISTS (
    SELECT * FROM EstateAgent
        WHERE BuyTransaction.agentID = EstateAgent.agentID
    )
ORDER BY agentID DESC;

--Anti-join
SELECT * FROM Property
WHERE propertyID NOT IN (
        SELECT propertyID FROM RentTransaction
        WHERE Property.hasBalcony = 'N' AND Property.hasGarden = 'N'
--        UNION ALL
--        SELECT propertyID from BuyTransaction
--        WHERE Property.hasBalcony = 'N' OR Property.hasGarden = 'N'
    )
ORDER BY price ASC;


--Correlated sub-query that finds what transactions, X AgentName is reponsible for
SELECT BuyTransaction.agentID, BuyTransaction.sellerID, BuyTransaction.propertyID FROM BuyTransaction
WHERE BuyTransaction.agentID = (
    SELECT EstateAgent.agentID FROM EstateAgent 
    WHERE EstateAgent.agentName = 'Livia Watson'
);