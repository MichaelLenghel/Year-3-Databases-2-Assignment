-- EstateAgent PL/SQL
SET SERVEROUTPUT ON
DECLARE
    V_NO EstateAgent.agentID%TYPE:='&Agent_Number';
    V_NAME EstateAgent.agentName%TYPE;
    V_RENTABLE INTEGER;
    V_FORRENT ForRent.propertyID%TYPE:='&Rentable_Property';
BEGIN
    SELECT agentName INTO V_NAME FROM EstateAgent WHERE agentID = V_NO;
    SELECT ForRent.propertyID, COUNT(*) OVER() Count_All INTO V_FORRENT, V_RENTABLE FROM ForRent WHERE propertyid = V_FORRENT;

    IF (V_RENTABLE > 0) THEN
        DBMS_OUTPUT.PUT_LINE(V_RENTABLE || ' available properties for rent');
        INSERT INTO RentTransaction (rentTransID, companyID, propertyID, agentID, buyerID, sellerID)
            VALUES (4, 1, V_FORRENT, V_NO, 1, 5);
        DELETE FROM ForRent WHERE ForRent.propertyID = V_FORRENT;
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