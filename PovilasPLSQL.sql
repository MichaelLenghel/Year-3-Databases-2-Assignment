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
