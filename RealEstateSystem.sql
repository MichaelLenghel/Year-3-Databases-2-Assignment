DROP TABLE RentTransaction CASCADE CONSTRAINTS PURGE;
DROP TABLE BuyTransaction CASCADE CONSTRAINTS PURGE;
DROP TABLE Seller CASCADE CONSTRAINTS PURGE;
DROP TABLE Buyer CASCADE CONSTRAINTS PURGE;
DROP TABLE House CASCADE CONSTRAINTS PURGE;
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
    askingPrice NUMBER(5) NOT NULL,
    CONSTRAINT sale_pk PRIMARY KEY (saleID)
);

CREATE TABLE ForRent (
    rentID NUMBER(5) NOT NULL,
    monthlyRent NUMBER(5) NOT NULL,
    CONSTRAINT rent_pk PRIMARY KEY (rentID)
);

CREATE TABLE Property (
    propertyID NUMBER(5) NOT NULL,
    numToilets NUMBER(3) NOT NULL,
    numFloors NUMBER(3) NOT NULL,
    address VARCHAR2(50) NOT NULL,
    owner VARCHAR2(50) NULL,
    numBedrooms VARCHAR2(50) NOT NULL,
    # i.e. House, apartment, bungalow
    houseType VARCHAR2(50) NOT NULL,
    # 'Y' / 'N' for all have variables
    haveBalacony VARCHAR2(50) NOT NULL,
    haveGarden VARCHAR2(50) NOT NULL,
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
    agentID NUMBER(6) NULL,
    companyID NUMBER(6) NULL,
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
    agentID NUMBER(5) NOT NULL,
    propertyID NUMBER(5) NOT NULL,
    buyerID NUMBER(5) NOT NULL,
    sellerID NUMBER(5) NOT NULL,
    CONSTRAINT buyTrans_pk PRIMARY KEY(buyTransID),
    CONSTRAINT company_buyTrans_fk FOREIGN KEY (companyID) REFERENCES Company (companyID),
    CONSTRAINT agentID_buyTrans_fk FOREIGN KEY (agentID) REFERENCES EstateAgent (agentID),
    CONSTRAINT propertyID_buyTrans_fk FOREIGN KEY (propertyID) REFERENCES Property (propertyID),
    CONSTRAINT BuyerID_buyTrans_fk FOREIGN KEY (buyerID) REFERENCES Buyer (buyerID),
    CONSTRAINT sellerID_buyTrans_fk FOREIGN KEY (sellerID) REFERENCES seller (sellerID)
);

CREATE TABLE RentTransaction (
    rentTransID NUMBER(5) NOT NULL,
    companyID NUMBER(5) NULL,
    CONSTRAINT rentTrans_pk PRIMARY KEY(rentTransID),
    CONSTRAINT company_rentTrans_fk FOREIGN KEY (companyID) REFERENCES Company (companyID)
);

INSERT INTO Company(1, 'E-State Properties');

INSERT INTO Property VALUES(1, '2350 Gibson Road', 'John Smith', 235000);
INSERT INTO Property VALUES(2, '197 Watson Street', 'Raymond Chou', 789000);
INSERT INTO Property VALUES(3, '2525 Pottsdamer Street', 'Jim Lee', 100500);
INSERT INTO Property VALUES(4, '193 Love BLVD', 'Kim Abudal', 930000);
INSERT INTO Property VALUES(5, '647 Maston Road', 'Robert Clue', 135000);
INSERT INTO Property VALUES(6, '1350 Navada Street', 'Jack Green', 674090);
INSERT INTO Property VALUES(7, '256 Florida Street', 'Michael Kohen', 179280);
INSERT INTO Property VALUES(8, '1717 Kansas Street', 'Leah Mars', 345000);
INSERT INTO Property VALUES(9, '2613 Academic Way', 'Marry Song', 997050);
INSERT INTO Property VALUES(10, '179 Tinker Road', 'Leon Kant', 90000);

INSERT INTO EstateAgent VALUES(1, 'Leet Kim', '135145636', 'leetkim@es.ie', '2012/01/23', 1);
INSERT INTO EstateAgent VALUES(2, 'Jim Alpha', '171135636', 'alphadog@es.ie', '2012/03/26', 1);
INSERT INTO EstateAgent VALUES(3, 'George Grey', '176321636', 'grey@es.ie', '2015/02/23', 1);
INSERT INTO EstateAgent VALUES(4, 'Sarah Core', '135145909', 'sarahc@es.ie', '2016/07/03', 1);
INSERT INTO EstateAgent VALUES(5, 'Livia Watson', '137145638', 'lwatson@es.ie', '2014/01/17', 1);
INSERT INTO EstateAgent VALUES(6, 'Nik Ray', '135873630', 'rayray@es.ie', '2014/01/28', 1);
INSERT INTO EstateAgent VALUES(7, 'Cris Paul', '136141236', 'paulcris@es.ie', '2016/05/23', 1);
INSERT INTO EstateAgent VALUES(8, 'Lena Clay', '137145123', 'clena@es.ie', '2014/08/19', 1);
INSERT INTO EstateAgent VALUES(9, 'Kevin Nil', '190145636', 'kevinnil@es.ie', '2011/07/20', 1);
INSERT INTO EstateAgent VALUES(10, 'Hugh Grant', '132145639', 'hughgrant@es.ie', '2012/12/31', 1);