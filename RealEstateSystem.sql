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
--This is a comment
-- this is a another test comment
-- This is a test of a tester comment 

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

CREATE TABLE ForSale (
    saleID NUMBER(5) NOT NULL,
    askingPrice NUMBER(8) NOT NULL,
    CONSTRAINT for_sale_pk PRIMARY KEY (saleID)
);

CREATE TABLE ForRent (
    rentID NUMBER(5) NOT NULL,
    monthlyRent NUMBER(8) NOT NULL,
    CONSTRAINT for_rent_pk PRIMARY KEY (rentID)
);

CREATE TABLE Property (
    propertyID NUMBER(5) NOT NULL,
    address VARCHAR2(50) NOT NULL,
    owner VARCHAR2(50) NULL,
    numBedrooms NUMBER(2) NOT NULL,
    numFloors NUMBER(2) NOT NULL,
    numToilets NUMBER(2) NOT NULL,
    -- type denotes house, apartment, bungalow, etc.
    type VARCHAR2(50) NOT NULL,
    -- Y / N
    hasBalcony CHAR(1) DEFAULT 'N',
    hasGarden CHAR(1) DEFAULT 'N',
    price NUMBER(6) NULL,
    CONSTRAINT property_pk PRIMARY KEY (propertyID)
);

CREATE TABLE Buyer (
    buyerID NUMBER(5) NOT NULL,
    buyerName VARCHAR2(50) NOT NULL,
    buyerPhoneNum VARCHAR2(13) NOT NULL,
    buyerEmail VARCHAR2(50) NOT NULL,
    minPreferredPrice NUMBER(6) NOT NULL,
    maxPreferredPrice NUMBER(6) NOT NULL,
    bedrooms NUMBER(2) NOT NULL,
    bathrooms NUMBER(2) NOT NULL,
    agentID NUMBER(5) NULL,
    companyID NUMBER(5) NULL,
    CONSTRAINT buyer_pk PRIMARY KEY (buyerID, agentID, companyID)
);

CREATE TABLE Seller (
    sellerID NUMBER(5) NOT NULL,
    sellerName VARCHAR2(50) NOT NULL,
    sellerPhoneNum VARCHAR2(13) NOT NULL,
    sellerEmail VARCHAR2(50) NOT NULL,
    CONSTRAINT seller_pk PRIMARY KEY (sellerID)
);

CREATE TABLE BuyTransaction (
    buyTransID NUMBER(5) NOT NULL,
    companyID NUMBER(5) NULL,
    agentID NUMBER(5) NULL,
    propertyID NUMBER(5) NULL,
    buyerID NUMBER(5) NULL,
    sellerID NUMBER(5) NULL,
    CONSTRAINT buyTrans_pk PRIMARY KEY(buyTransID),
    CONSTRAINT company_buyTrans_fk FOREIGN KEY (companyID) REFERENCES EstateAgent(companyID),
    CONSTRAINT agentID_buyTrans_fk FOREIGN KEY (agentID) REFERENCES Company (agentID),
    CONSTRAINT propertyID_buyTrans_fk FOREIGN KEY (propertyID) REFERENCES Property (propertyID),
    CONSTRAINT buyerID_buyTrans_fk FOREIGN KEY (buyerID) REFERENCES Buyer (buyerID),
    CONSTRAINT sellerID_buyTrans_fk FOREIGN KEY (sellerID) REFERENCES Seller (sellerID)
);

CREATE TABLE RentTransaction (
    rentTransID NUMBER(5) NOT NULL,
    companyID NUMBER(5) NULL,
    CONSTRAINT rentTrans_pk PRIMARY KEY(rentTransID),
    CONSTRAINT company_rentTrans_fk FOREIGN KEY (companyID) REFERENCES Company (companyID)
);

INSERT INTO Company VALUES(1, 'E-State Properties');

INSERT INTO Property (propertyID, address, owner, numBedrooms, numFloors, numToilets, type, hasGarden, price)
    VALUES(1, '2350 Gibson Road', 'John Smith', 4, 1, 2, 'Bungalow', 'Y', 235000);
INSERT INTO Property (propertyID, address, owner, numBedrooms, numFloors, numToilets, type, hasBalcony, price) 
    VALUES(2, '197 Watson Street', 'Raymond Chou', 3, 1, 2, 'Apartment', 'Y', 789000);
INSERT INTO Property (propertyID, address, owner, numBedrooms, numFloors, numToilets, type, price)
    VALUES(3, '2525 Pottsdamer Street', 'Jim Lee', 1, 1, 1, 'Apartment', 100500);
INSERT INTO Property (propertyID, address, owner, numBedrooms, numFloors, numToilets, type, hasBalcony, hasGarden, price)
    VALUES(4, '193 Love BLVD', 'Kim Abudal', 6, 3, 6, 'House', 'Y', 'Y', 930000);
INSERT INTO Property (propertyID, address, owner, numBedrooms, numFloors, numToilets, type, price)
    VALUES(5, '647 Maston Road', 'Robert Clue', 2, 1, 1, 'Apartment', 135000);
INSERT INTO Property (propertyID, address, owner, numBedrooms, numFloors, numToilets, type, hasGarden, price)
    VALUES(6, '1350 Navada Street', 'Jack Green', 4, 2, 2, 'House', 'Y', 674090);
INSERT INTO Property (propertyID, address, owner, numBedrooms, numFloors, numToilets, type, price)
    VALUES(7, '256 Florida Street', 'Michael Kohen', 5, 2, 2, 'House', 179280);
INSERT INTO Property (propertyID, address, owner, numBedrooms, numFloors, numToilets, type, hasGarden, price)
    VALUES(8, '1717 Kansas Street', 'Leah Mars',3, 2, 1, 'Semi-detached', 'Y', 345000);
INSERT INTO Property (propertyID, address, owner, numBedrooms, numFloors, numToilets, type, hasBalcony, hasGarden, price)
    VALUES(9, '2613 Academic Way', 'Marry Song', 8, 3, 3, 'Mansion', 'Y', 'Y', 997050);
INSERT INTO Property (propertyID, address, owner, numBedrooms, numFloors, numToilets, type, price)
    VALUES(10, '179 Tinker Road', 'Leon Kant', 1, 1, 1, 'Apartment', 90000);

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

INSERT INTO ForSale (saleID, askingPrice) VALUES (1, 100000);
INSERT INTO ForSale(saleID, askingPrice) VALUES(2, 550000);
    
INSERT INTO ForRent(rentID, monthlyRent) VALUES(1, 660);
INSERT INTO ForRent(rentID, monthlyRent) VALUES(2, 1100);

INSERT INTO Seller (sellerID, sellerName, sellerPhoneNum, sellerEmail)
    VALUES(1, 'Bob Walsh', '123400121', 'bwalsh@seller.ie');

INSERT INTO RentTransaction (rentTransID, companyID) VALUES (1, 1);
INSERT INTO RentTransaction (rentTransID, companyID) VALUES (2, 1);



