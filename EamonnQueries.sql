--Selection,
SELECT * FROM EstateAgent;

--Projection, 
SELECT agentName, agentEmail, startDate FROM EstateAgent
WHERE agentName LIKE 'L%';

--Aggregation with filters on aggregates, 
-- find all properties that have balcony that are sold by a certain seller
SELECT sellerID, SUM(price) AS "Total" FROM Property
GROUP BY sellerID
HAVING SUM(price) > 1000000;

--Union, 
--SELECT address FROM Property
--INNER JOIN (
--    )
--Minus, 
--Difference, 
--Inner Join, 
--Outer Join, 
--Semi-join, 
--Anti-join 
--Correlated sub-query that finds what agent is responsible for a transaction
SELECT BuyTransaction.agentID, BuyTransaction.sellerID, BuyTransaction.propertyID FROM BuyTransaction
WHERE BuyTransaction.agentID = (
    SELECT EstateAgent.agentID FROM EstateAgent 
    WHERE EstateAgent.agentName = 'Livia Watson'
);