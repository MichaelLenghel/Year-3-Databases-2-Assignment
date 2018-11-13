--Each query should be tested to ensure that there is data there to satisfy it and to show that it works – i.e. a query that shows the 
--power of the technique being used (e.g. a left join that would return the same as an inner join will not get full marks). 
--You may create  views as required but show your code if you do.

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

--Difference,--

--Inner Join--
--Show all properties that for rent and their price
Select propertyID, price From Property
Inner Join ForRent using(propertyID);

--Outer Join--
Select * From ForRent
FULL outer Join ForSale using(propertyID);

--Semi-join--
--Gets all properties that are for sale that have more than 3 bedrooms
Select * From ForSale
Where exists (
    Select * From Property
    Where numBedrooms > 3 and ForSale.propertyid = Property.propertyid
)
Order By askingPrice ASC;

--Anti-join--
--Select all agents that have not made a sale
Select * From EstateAgent
Where agentID NOT IN (
    Select agentID From BuyTransaction
)
ORDER BY agentID ASC;
--Correlated sub-query--
--Find all the properties that a particular seller has put on the market
Select * From Property
Where Property.sellerID IN (
    Select sellerID From Seller
    Where Seller.sellerName = 'Micycle Menghel'
);