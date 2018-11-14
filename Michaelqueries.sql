--Student Number: C16434974

--Selection--
Select * from Seller;

--Projection--
Select * from buyer
Where maxPreferredPrice > 500000;

--Aggregation with filters on aggregates,--
-- This query gets all agentIDs that has average buyers price greater than 10000
Select agentID, AVG(maxPreferredPrice - minPreferredPrice) As avgBuyingPricePerAgent
From Buyer
Group By agentID
Having  AVG(maxPreferredPrice - minPreferredPrice) > 10000;

--Union--
--Get all the properties that are for sale and for rent. (Excludes all properties that have been sold or currently rented).
Select propertyID, askingPrice As totalCost From ForSale
Union
Select propertyID, monthlyRent As totalCost From ForRent;

--Minus--
--Get all properties that have been sold or are currently being rented.
Select propertyID From Property
Minus
Select propertyID From ForRent
Minus
Select propertyID From ForSale;


--Difference NOT IN--
-- Find all estate agents that have not made any sales.
Select * From EstateAgent
Where agentID NOT IN (
    Select agentID From BuyTransaction
)
ORDER BY agentID ASC;

--Inner Join--
--Show all properties that for rent and their price
Select propertyID, price From Property
Inner Join ForRent using(propertyID);


--Outer Join--
--Show all estate agents and the buy they have
Select buyerName, agentName From EstateAgent,
Outer Join Buyer using (agentID);

--Semi-join--
--Gets all properties that are for sale that have more than 3 bedrooms
Select * From ForSale
Where exists (
    Select * From Property
    Where numBedrooms > 3 and ForSale.propertyid = Property.propertyid
)
Order By askingPrice ASC;

--Anti-join--
<<<<<<< HEAD
--Select all agents that have not made a sale
Select * From EstateAgent
Where agentID NOT IN (
    Select agentID From BuyTransaction
)
ORDER BY agentID ASC;
=======
--Find all houses not put up for rent
Select propertyID, address, price From Property
Left Join forSale using(propertyID)
Where propertyType = 'House';
>>>>>>> 9933c933f46152d115f2139c6b4971d78fbbc86c

--Correlated sub-query--
--Find all the properties that a particular seller has put on the market
Select * From Property
Where Property.sellerID IN (
    Select sellerID From Seller
    Where Seller.sellerName = 'Micycle Menghel'
);