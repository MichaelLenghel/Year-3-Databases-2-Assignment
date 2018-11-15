-- Student Name: Michael Lenghel Student Number: C16434974
-- Student Name: Eamonn Keogh Student Number: C16757629
-- Student Name: Povilas Kubilius Student Number: c16370803


DROP TABLE RentTransaction CASCADE CONSTRAINTS PURGE;
DROP TABLE BuyTransaction CASCADE CONSTRAINTS PURGE;
DROP TABLE Seller CASCADE CONSTRAINTS PURGE;
DROP TABLE Buyer CASCADE CONSTRAINTS PURGE;
DROP TABLE Property CASCADE CONSTRAINTS PURGE;
DROP TABLE ForRent CASCADE CONSTRAINTS PURGE;
DROP TABLE ForSale CASCADE CONSTRAINTS PURGE;
DROP TABLE EstateAgent CASCADE CONSTRAINTS PURGE;
DROP TABLE Company CASCADE CONSTRAINTS PURGE;

CREATE TABLE Company (
    companyID NUMBER(5) NOT NULL,
    companyName VARCHAR2(50) NOT NULL,
    CONSTRAINT company_pk PRIMARY KEY(companyID)
);

-- eamonn pl-sql for this 
-- updates for sale for rent table and puts in into transaction
CREATE TABLE EstateAgent (
    agentID NUMBER(5) NOT NULL,
    agentName VARCHAR2(50) NOT NULL,
    agentPhoneNum VARCHAR2(13) NOT NULL,
    agentEmail VARCHAR2(50) NOT NULL,
    startDate DATE,
    companyID NUMBER(6) NULL,
    CONSTRAINT agent_pk PRIMARY KEY(agentID),
    CONSTRAINT company_agent_fk FOREIGN KEY (companyID) REFERENCES Company (companyID)
);

CREATE TABLE Seller (
    sellerID NUMBER(5) NOT NULL,
    sellerName VARCHAR2(50) NOT NULL,
    sellerPhoneNum VARCHAR2(13) NOT NULL,
    sellerEmail VARCHAR2(50) NOT NULL,
    CONSTRAINT seller_pk PRIMARY KEY (sellerID)
);

CREATE TABLE Property (
    propertyID NUMBER(5) NOT NULL,
    address VARCHAR2(50) NOT NULL,
    sellerID NUMBER(5) NOT NULL,
    numBedrooms NUMBER(2) NOT NULL,
    numFloors NUMBER(2) NOT NULL,
    numToilets NUMBER(2) NOT NULL,
    -- type denotes house, apartment, bungalow, etc.
    propertyType VARCHAR2(50) NOT NULL,
    -- Y / N
    hasBalcony CHAR(1) DEFAULT 'N',
    hasGarden CHAR(1) DEFAULT 'N',
    price NUMBER(10) NULL,
    CONSTRAINT property_pk PRIMARY KEY (propertyID),
    CONSTRAINT seller_ID_property_fk FOREIGN KEY (sellerID) REFERENCES Seller (sellerID)
);

CREATE TABLE ForRent (
    rentID NUMBER(5) NOT NULL,
    monthlyRent NUMBER(10) NOT NULL,
    propertyID NUMBER(5) NULL,
    CONSTRAINT for_rent_pk PRIMARY KEY (rentID),
    CONSTRAINT property_forSale_fk FOREIGN KEY (propertyID) REFERENCES Property (propertyID) 
);

CREATE TABLE ForSale (
    saleID NUMBER(5) NOT NULL,
    askingPrice NUMBER(10) NOT NULL,
    propertyID NUMBER(5) NULL,
    CONSTRAINT for_sale_pk PRIMARY KEY (saleID),
    CONSTRAINT property_forSale FOREIGN KEY (propertyID) REFERENCES Property (propertyID) 
);

CREATE TABLE Buyer (
    buyerID NUMBER(5) NOT NULL,
    buyerName VARCHAR2(50) NOT NULL,
    buyerPhoneNum VARCHAR2(13) NOT NULL,
    buyerEmail VARCHAR2(50) NOT NULL,
    minPreferredPrice NUMBER(9) NOT NULL,
    maxPreferredPrice NUMBER(9) NOT NULL,
    bedrooms NUMBER(2) NOT NULL,
    bathrooms NUMBER(2) NOT NULL,
    agentID NUMBER(5) NULL,
    companyID NUMBER(5) NULL,
    CONSTRAINT buyer_pk PRIMARY KEY (buyerID),
    CONSTRAINT agent_ID_buyer_fk FOREIGN KEY (agentID) REFERENCES EstateAgent (agentID),
    CONSTRAINT companyID_buyTrans_fk FOREIGN KEY (companyID) REFERENCES Company (companyID)
);

CREATE TABLE BuyTransaction (
    buyTransID NUMBER(5) NOT NULL,
    companyID NUMBER(5) NOT NULL,
    agentID NUMBER(5) NOT NULL,
    propertyID NUMBER(5) NOT NULL,
    buyerID NUMBER(5) NOT NULL,
    sellerID NUMBER(5) NOT NULL,
    price NUMBER(10) NOT NULL,
    CONSTRAINT buyTrans_pk PRIMARY KEY(buyTransID),
    CONSTRAINT company_buyTrans_fk FOREIGN KEY (companyID) REFERENCES Company(companyID),
    CONSTRAINT agentID_buyTrans_fk FOREIGN KEY (agentID) REFERENCES EstateAgent (agentID),
    CONSTRAINT propertyID_buyTrans_fk FOREIGN KEY (propertyID) REFERENCES Property (propertyID),
    CONSTRAINT buyerID_buyTrans_fk FOREIGN KEY (buyerID) REFERENCES Buyer (buyerID),
    CONSTRAINT sellerID_buyTrans_fk FOREIGN KEY (sellerID) REFERENCES Seller (sellerID)
);

CREATE TABLE RentTransaction (
    rentTransID NUMBER(5) NOT NULL,
    companyID NUMBER(5) NULL,
    propertyID NUMBER(5) NULL,
    agentID NUMBER(5) NOT NULL,
    buyerID NUMBER(5) NOT NULL,
    sellerID NUMBER(5) NOT NULL,
    price NUMBER(10) NOT NULL,
    CONSTRAINT rentTrans_pk PRIMARY KEY(rentTransID),
    CONSTRAINT company_rentTrans_fk FOREIGN KEY (companyID) REFERENCES Company (companyID),
    CONSTRAINT propertyID_rentTrans_fk FOREIGN KEY (propertyID) REFERENCES Property (propertyID),
    CONSTRAINT agentID_rentTrans_fk FOREIGN KEY (agentID) REFERENCES EstateAgent (agentID),
    CONSTRAINT buyerID_rentTrans_fk FOREIGN KEY (buyerID) REFERENCES Buyer (buyerID),
    CONSTRAINT sellerID_rentTrans_fk FOREIGN KEY (sellerID) REFERENCES Seller (sellerID)
);

INSERT INTO Company VALUES(1, 'E-State Properties');
INSERT INTO Company VALUES(2, 'Hello bichael');


INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(1, 'Bob Walsh', '123400121', 'bwalsh@seller.ie');
INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(2, 'Michael Lenghel', '123400122', 'michael@seller.ie');
INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(3, 'jim Walsh', '123400123', 'jim@seller.ie');
INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(4, 'timmy Walsh', '123400124', 'timmy@seller.ie');
INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(5, 'lacoste Walsh', '123400125', 'lacoste@seller.ie');
INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(6, 'John Walsh', '123400126', 'John@seller.ie');
INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(7, 'ran Walsh', '123400127', 'ran@seller.ie');
INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(8, 'Albert Hoffman', '123400128', 'albert@seller.ie');
INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(9, 'Micycle Menghel', '123400129', 'micycle@seller.ie');
INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(10, 'David D. Larsen', '123400130', 'david@seller.ie');

INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, hasGarden, price)
    VALUES(1, '2350 Gibson Road', 1, 4, 1, 2, 'Bungalow', 'Y', 235000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, hasBalcony, price) 
    VALUES(2, '197 Watson Street', 2, 3, 1, 2, 'Apartment', 'Y', 789000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, price)
    VALUES(3, '2525 Pottsdamer Street', 3, 1, 1, 1, 'Apartment', 100500);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, hasBalcony, hasGarden, price)
    VALUES(4, '193 Love BLVD', 4, 6, 3, 6, 'House', 'Y', 'Y', 930000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, price)
    VALUES(5, '647 Maston Road', 5, 2, 1, 1, 'Apartment', 135000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, hasGarden, price)
    VALUES(6, '1350 Navada Street', 6, 4, 2, 2, 'House', 'Y', 674090);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, price)
    VALUES(7, '256 Florida Street', 7, 5, 2, 2, 'House', 179280);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, hasGarden, price)
    VALUES(8, '1717 Kansas Street', 2 ,3, 2, 1, 'Semi-Detached', 'Y', 345000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, hasBalcony, hasGarden, price)
    VALUES(9, '2613 Academic Way', 5, 8, 3, 3, 'Mansion', 'Y', 'Y', 997050);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, price)
    VALUES(10, '179 Tinker Road', 5, 1, 1, 1, 'Apartment', 90000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, price)
    VALUES(11, '179 Lysergic Road', 8, 3, 2, 3, 'House', 125000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, price)
    VALUES(12, '179 Endensummer Street', 9, 1, 1, 2, 'Bungalow', 75000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, price)
    VALUES(13, '3721 White Avenue', 10, 2, 10, 2, 'House', 85000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, price)
    VALUES(14, '19 Strawberry Street', 8, 4, 2, 3, 'House', 95000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, price)
    VALUES(15, '88 Jungle Road', 7, 2, 12, 1, 'Apartment', 60000);
INSERT INTO Property (propertyID, address, sellerID, numBedrooms, numFloors, numToilets, propertyType, price)
    VALUES(16, 'Haunted Street', 6, 4, 13, 1, 'Bungalow', 70000);

INSERT INTO EstateAgent (agentID, agentName, agentPhoneNum, agentEmail, startDate, companyID) 
    VALUES(1, 'Leet Kim', '135145636', 'leetkim@es.ie', TO_TIMESTAMP('2012-01-23','YYYY-MM-DD'), 1);
INSERT INTO EstateAgent (agentID, agentName, agentPhoneNum, agentEmail, startDate, companyID) 
    VALUES(2, 'Jim Alpha', '171135636', 'alphadog@es.ie', TO_TIMESTAMP('2012-03-26', 'YYYY-MM-DD'), 1);
INSERT INTO EstateAgent (agentID, agentName, agentPhoneNum, agentEmail, startDate, companyID) 
    VALUES(3, 'George Grey', '176321636', 'grey@es.ie', TO_TIMESTAMP('2015-02-23', 'YYYY-MM-DD'), 1);
INSERT INTO EstateAgent (agentID, agentName, agentPhoneNum, agentEmail, startDate, companyID) 
    VALUES(4, 'Sarah Core', '135145909', 'sarahc@es.ie', TO_TIMESTAMP('2016-07-03', 'YYYY-MM-DD'), 1);
INSERT INTO EstateAgent (agentID, agentName, agentPhoneNum, agentEmail, startDate, companyID) 
    VALUES(5, 'Livia Watson', '137145638', 'lwatson@es.ie', TO_TIMESTAMP('2014-01-17', 'YYYY-MM-DD'), 1);
INSERT INTO EstateAgent (agentID, agentName, agentPhoneNum, agentEmail, startDate, companyID) 
    VALUES(6, 'Nik Ray', '135873630', 'rayray@es.ie', TO_TIMESTAMP('2014-01-28', 'YYYY-MM-DD'), 1);
INSERT INTO EstateAgent (agentID, agentName, agentPhoneNum, agentEmail, startDate, companyID) 
    VALUES(7, 'Cris Paul', '136141236', 'paulcris@es.ie', TO_TIMESTAMP('2016-05-23', 'YYYY-MM-DD'), 1);
INSERT INTO EstateAgent (agentID, agentName, agentPhoneNum, agentEmail, startDate, companyID) 
    VALUES(8, 'Lena Clay', '137145123', 'clena@es.ie', TO_TIMESTAMP('2014-08-19', 'YYYY-MM-DD'), 1);
INSERT INTO EstateAgent (agentID, agentName, agentPhoneNum, agentEmail, startDate, companyID) 
    VALUES(9, 'Kevin Nil', '190145636', 'kevinnil@es.ie', TO_TIMESTAMP('2011-07-20', 'YYYY-MM-DD'), 1);
INSERT INTO EstateAgent (agentID, agentName, agentPhoneNum, agentEmail, startDate, companyID) 
    VALUES(10, 'Hugh Grant', '132145639', 'hughgrant@es.ie', TO_TIMESTAMP('2012-12-31', 'YYYY--MM-DD'), 1);

INSERT INTO Buyer (buyerID, buyerName, buyerPhoneNum, buyerEmail, minPreferredPrice, maxPreferredPrice, bedrooms, bathrooms, agentID, companyID) 
    VALUES(1, 'John Nay', '125345790', 'johnnay@mail.ie', 250000, 275000, 4, 2, 1, 1);
INSERT INTO Buyer (buyerID, buyerName, buyerPhoneNum, buyerEmail, minPreferredPrice, maxPreferredPrice, bedrooms, bathrooms, agentID, companyID) 
    VALUES(2, 'Retina Grey', '146345790', 'tinag@mail.ie', 90000, 100000, 1, 1, 1, 1);
INSERT INTO Buyer (buyerID, buyerName, buyerPhoneNum, buyerEmail, minPreferredPrice, maxPreferredPrice, bedrooms, bathrooms, agentID, companyID) 
    VALUES(3, 'Renata Coolier', '146345791', 'renata@mail.ie', 95000, 150000, 3, 3, 10, 1);
INSERT INTO Buyer (buyerID, buyerName, buyerPhoneNum, buyerEmail, minPreferredPrice, maxPreferredPrice, bedrooms, bathrooms, agentID, companyID) 
    VALUES(4, 'Bichael Benghel', '146345792', 'bichael@mail.ie', 60000, 80000, 2, 2, 5, 1);
INSERT INTO Buyer (buyerID, buyerName, buyerPhoneNum, buyerEmail, minPreferredPrice, maxPreferredPrice, bedrooms, bathrooms, agentID, companyID) 
    VALUES(5, 'Christopher B. Garner', '146345793', 'chris@mail.ie', 80000, 90000, 2, 2, 7, 1);
INSERT INTO Buyer (buyerID, buyerName, buyerPhoneNum, buyerEmail, minPreferredPrice, maxPreferredPrice, bedrooms, bathrooms, agentID, companyID) 
    VALUES (6, 'Eamonn Keogh', '4146345791', 'eamonn@buyer.ie', 100000, 500000, 1, 1, 6, 1);    
INSERT INTO Buyer (buyerID, buyerName, buyerPhoneNum, buyerEmail, minPreferredPrice, maxPreferredPrice, bedrooms, bathrooms, agentID, companyID) 
    VALUES (7, 'Adam Smith', '4146345291', 'adam@buyer.ie', 400000, 900000, 2, 3, 3, 1);
INSERT INTO Buyer (buyerID, buyerName, buyerPhoneNum, buyerEmail, minPreferredPrice, maxPreferredPrice, bedrooms, bathrooms, agentID, companyID) 
    VALUES (8, 'Paul Kubulius', '4146345391', 'paul@buyer.ie', 200000, 400000, 1, 1, 8, 1);
INSERT INTO Buyer (buyerID, buyerName, buyerPhoneNum, buyerEmail, minPreferredPrice, maxPreferredPrice, bedrooms, bathrooms, agentID, companyID) 
    VALUES (9, 'Michael Lenghel', '4946345791', 'michael@buyer.ie', 500000, 950000, 3, 4, 7, 1);
    
INSERT INTO ForSale (saleID, askingPrice, propertyID) VALUES (1, 100000, 6);
INSERT INTO ForSale (saleID, askingPrice, propertyID) VALUES(2, 550000, 3);
    
INSERT INTO ForRent (rentID, monthlyRent, propertyID) VALUES(1, 660, 1);
INSERT INTO ForRent (rentID, monthlyRent, propertyID) VALUES(2, 1100, 5);

INSERT INTO RentTransaction (rentTransID, companyID, propertyID, agentID, buyerID, sellerID, price) 
    VALUES (1, 1, 14, 10, 7, 8, 95000);
INSERT INTO RentTransaction (rentTransID, companyID, propertyID, agentID, buyerID, sellerID, price) 
    VALUES (2, 1, 15, 5, 8, 1, 60000);
INSERT INTO RentTransaction (rentTransID, companyID, propertyID, agentID, buyerID, sellerID, price) 
    VALUES (3, 1, 16, 7, 9, 2, 70000);

INSERT INTO BuyTransaction (buyTransID, companyID, agentID, propertyID, buyerID, sellerID, price)
    VALUES(1, 1, 10, 11, 3, 8, 125000);
INSERT INTO BuyTransaction (buyTransID, companyID, agentID, propertyID, buyerID, sellerID, price)
    VALUES(2, 1, 5, 12, 4, 9, 75000);
INSERT INTO BuyTransaction (buyTransID, companyID, agentID, propertyID, buyerID, sellerID, price)
    VALUES(3, 1, 7, 13, 5, 10, 85000);
    
GRANT SELECT ON Company TO MLENGHEL;
REVOKE SELECT ON Company FROM MLENGHEL;
GRANT
    SELECT,
    INSERT,
    UPDATE,
    DELETE
ON
    SCHEMA.dt2283group_h
TO
    MLENGHEL,
    PKUBILIUS;
COMMIT;


INSERT INTO Company VALUES (4, 'UwU');

SELECT * FROM MLENGHEL.Company;
