-- Student Name: Michael Lenghel Student Number: C16434974
-- Student Name: Eamonn Keogh Student Number: C16757629
-- Student Name: Povilas Kubilius Student Number: c16370803

--Seller PL/SQL
SET SERVEROUTPUT ON
DECLARE
    --Increment propertyid and sellerid, rather than input
    v_sID Seller.sellerID%TYPE := '&sellers_id';
    v_pID Property.propertyID%TYPE := '&property_id';
    v_name Seller.sellerName%TYPE := '&sellers_name';
    v_email Seller.sellerEmail%TYPE := '&sellers_email';
    v_address Property.address%TYPE := '&property_address';
    v_phone Seller.sellerPhoneNum%TYPE := '&sellers_phone_number';
    v_numFloors Property.numFloors%TYPE := '&num_floors';
    v_numBedrooms Property.numBedrooms%TYPE := '&num_bedrooms';
    v_numToilets Property.numToilets%TYPE := '&num_toilets';
    v_price Property.price%TYPE := '&price';
    v_property_type Property.propertyType%TYPE := '&propertyType';
    v_hasGarden property.hasgarden%TYPE := '&hasGardene';
    v_hasBalcony property.hasbalcony%TYPE := '&hasBalcony';
    v_buyers Buyer.buyerName%TYPE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Potential Buyers within price range: ');
        -- SQL Query that will find all the buyers that can afford the sellers property.
        FOR buyer IN (SELECT Buyer.buyerName into v_buyers From Buyer
                    Where v_price < maxPreferredPrice)
        LOOP
            DBMS_OUTPUT.PUT_LINE('Buyers: ' || buyer.buyerName);
        End LOOP;
        -- Add a new seller
        INSERT INTO Seller VALUES
            (v_sID, v_name, v_phone, v_email);
        --Insert new property into the property table
        INSERT INTO Property VALUES
            (v_pID, v_address,  v_sID, v_numBedrooms, v_numFloors, v_numToilets, v_property_type,v_hasGarden,v_hasGarden, v_price);
        Commit;
    --Handle exceptions appropriately
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nothing found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Input data incorrect. ' || SQLCODE || ' ' || SQLERRM);
            DBMS_OUTPUT.PUT_LINE('Rolling back...');
            ROLLBACK;
    End;

--BUYER PL/SQL
SET SERVEROUTPUT ON
DECLARE
    maxPrice Property.price%TYPE :='&Max_Price';
    bedrooms Property.numBedrooms%TYPE :='&Number_of_bedrooms';
BEGIN
    FOR prop IN (SELECT address, price, numBedrooms, numToilets, hasBalcony, hasGarden
    FROM Property
    WHERE numBedrooms = bedrooms AND price <= maxPrice)
    LOOP
    dbms_output.put_line('Address: ' || prop.address); 
    dbms_output.put_line('Price: $' || prop.price);
    dbms_output.put_line('Number of Bedrooms: ' || prop.numBedrooms);
    dbms_output.put_line('Number of toilets' || prop.numToilets);
    dbms_output.put_line('Balcony: ' || prop.hasBalcony);
    dbms_output.put_line('Garden: ' || prop.hasGarden);
    dbms_output.put_line('');
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Nothing Found');
    WHEN OTHERS THEN
    dbms_output.put_line('Error');
END; 
