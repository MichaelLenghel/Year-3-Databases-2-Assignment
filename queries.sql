--Each query should be tested to ensure that there is data there to satisfy it and to show that it works – i.e. a query that shows the 
--power of the technique being used (e.g. a left join that would return the same as an inner join will not get full marks). 
--You may create  views as required but show your code if you do.

--Selection.
Select * from Seller;
--Projection
Select * from buyer
Where maxPreferredPrice > 500000;
--Aggregation with filters on aggregates,
-- This query gets all agentIDs that has average buyers price greater than 10000
Select agentID, AVG(maxPreferredPrice - minPreferredPrice) As avgBuyingPricePerAgent
From Buyer
Group By agentID
Having  AVG(maxPreferredPrice - minPreferredPrice) > 10000;
--Union
 
--Minus, 
--Difference, 
--Inner Join, 
--Show all properties that for rent and their price
Select propertyID, price From Property
Inner Join ForRent using(propertyID);
--Outer Join,

--Semi-join, 
--Anti-join
--Correlated sub-query
