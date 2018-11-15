-- EstateAgent PL/SQL
SET SERVEROUTPUT ON
DECLARE
    V_TID RentTransaction.rentTransID%TYPE:='&Transaction_Number'; -- 4
    V_NO EstateAgent.agentID%TYPE:='&Agent_Number'; -- 1
    V_NAME EstateAgent.agentName%TYPE;
    V_RENTABLE INTEGER;
    V_FORRENT ForRent.propertyID%TYPE:='&Rentable_Property'; -- 1
    V_PRICE forrent.monthlyrent%TYPE;
    V_BUYER Buyer.buyerID%TYPE:='&Buyer_ID'; -- 1
    V_SELLER Seller.sellerID%TYPE:='&Seller_ID'; -- 5
BEGIN
    SELECT agentName INTO V_NAME FROM EstateAgent WHERE agentID = V_NO;
    SELECT ForRent.propertyID, COUNT(*) OVER() Count_All, ForRent.monthlyRent INTO V_FORRENT, V_RENTABLE, V_PRICE FROM ForRent WHERE propertyid = V_FORRENT;
    
    IF (V_RENTABLE > 0) THEN
        DBMS_OUTPUT.PUT_LINE('Updating...');
        INSERT INTO RentTransaction (rentTransID, propertyID, agentID, buyerID, sellerID, price)
            VALUES (V_TID, V_FORRENT, V_NO, V_BUYER, V_SELLER, V_PRICE);
        DELETE FROM ForRent WHERE ForRent.propertyID = V_FORRENT;
        DBMS_OUTPUT.PUT_LINE('Transaction successfully completed');
        COMMIT;
    ELSE 
        DBMS_OUTPUT.PUT_LINE(V_RENTABLE || ' properties on market for rent. Transaction cancelled');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such data found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Rolling back');
    ROLLBACK;
END;
