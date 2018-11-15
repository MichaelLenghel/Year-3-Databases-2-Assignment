--Selection,
SELECT * FROM EstateAgent;

--Projection, find all employees with es.ie email 
SELECT agentName, agentEmail, startDate FROM EstateAgent
WHERE agentEmail LIKE '%es.ie';

--Aggregation with filters on aggregates, count how many of each type of property are for sale with AVG price
CREATE OR REPLACE VIEW PropertyTypes AS
SELECT 
    COUNT(propertyID) AS Available, 
    propertyType AS Property,
    CAST(AVG(price) AS DECIMAL(10,2)) AS Average_Price
FROM Property
GROUP BY propertyType
ORDER BY Available DESC;

SELECT * FROM PropertyTypes;

--Union, get all the clients that the company has dealt with i.e. buyers and sellers
CREATE OR REPLACE VIEW ClientList AS
SELECT DISTINCT
    buyerName AS Name,
    buyerPhoneNum AS Phone_Number,
    buyerEmail AS Email
FROM Buyer
UNION
SELECT DISTINCT  
    sellerName, 
    sellerPhoneNum,
    sellerEmail
FROM Seller
ORDER BY Name DESC;

SELECT * FROM ClientList;

--Minus, find properties that havent been sold or rented
CREATE OR REPLACE VIEW AvailableProperties AS
SELECT propertyID, address, price FROM Property 
MINUS ( 
    SELECT BuyTransaction.propertyID, Property.address, BuyTransaction.price FROM BuyTransaction
    JOIN Property ON BuyTransaction.propertyID = Property.propertyID
    UNION
    SELECT RentTransaction.propertyID, Property.address, RentTransaction.price FROM RentTransaction
    JOIN Property ON RentTransaction.propertyID = Property.propertyID
)
ORDER BY propertyID;

SELECT * FROM AvailableProperties;

--Difference, find properties that arent in the jungle or haunted by evil spirits
CREATE OR REPLACE VIEW LiveableProperties AS
SELECT address, price, propertyType FROM Property
WHERE address NOT IN (
    SELECT address FROM Property 
    WHERE LOWER(address) LIKE LOWER('%jungle%') OR LOWER(address) LIKE LOWER('%haunted%')
)
ORDER BY price ASC;

SELECT * FROM LiveableProperties;

--Inner Join, gets the amount a buyer saved based upon their maximum allocated price
CREATE OR REPLACE VIEW BuyerSaved AS 
SELECT 
    buyerName,
    Buyer.maxPreferredPrice AS Max,
    Buyer.minPreferredPrice AS Min,
    BuyTransaction.price AS Price,
    Buyer.maxPreferredPrice - BuyTransaction.price AS Saved
FROM Buyer
INNER JOIN BuyTransaction ON buytransaction.buyerid = buyer.buyerid
WHERE buytransaction.price > (buytransaction.price - buyer.maxpreferredprice);

SELECT * FROM BuyerSaved;

-- Outer Join, Scoreboard of the number of properties sold/rented by each estate agent
CREATE OR REPLACE VIEW EmployeeRanking AS
SELECT 
    EstateAgent.agentID,
    EstateAgent.agentName,
    COUNT(RentTransaction.agentID) + COUNT(BuyTransaction.agentID) AS Sold
FROM EstateAgent
FULL OUTER JOIN 
    RentTransaction ON EstateAgent.agentID = RentTransaction.agentID
FULL OUTER JOIN 
    BuyTransaction ON EstateAgent.agentID = BuyTransaction.agentID 
GROUP BY 
    EstateAgent.agentID, 
    EstateAgent.agentName
ORDER BY Sold DESC;

SELECT * FROM EmployeeRanking;

--Semi-join, 
SELECT buyerID, buyerName, buyerPhoneNum, buyerEmail FROM Buyer
WHERE agentID IN (
    SELECT agentID FROM EstateAgent
    )
ORDER BY agentID DESC;


--Anti-join, get properties with no balcony or garden
SELECT * FROM Property
WHERE propertyID IN (
        SELECT propertyID FROM RentTransaction
        UNION
        SELECT propertyID from BuyTransaction
        WHERE Property.hasBalcony = 'N' AND Property.hasGarden = 'N'
    )
ORDER BY sellerID ASC;


--Correlated sub-query that finds what transactions, X AgentName is reponsible for
SELECT BuyTransaction.agentID, BuyTransaction.sellerID, BuyTransaction.propertyID FROM BuyTransaction
WHERE BuyTransaction.agentID = (
    SELECT EstateAgent.agentID FROM EstateAgent 
    WHERE EstateAgent.agentName = 'Livia Watson'
);
