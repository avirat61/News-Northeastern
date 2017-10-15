--Creating the Database
CREATE DATABASE "Group9"
GO

USE "Group9";

-- Creating Tables in the Database for News@Northeastern 
-- Data Defining Language

CREATE TABLE "PackagesPerks"
(
Package_ID SMALLINT NOT NULL PRIMARY KEY,
Salary INT NOT NULL,
Paid_leave SMALLINT NOT NULL,
Insurance VARCHAR(20) NOT NULL,
Travel_benefits VARCHAR(20),
Flex_Time TIME,
);

CREATE TABLE "Careers"
(
Careers_ID SMALLINT NOT NULL PRIMARY KEY,
Intern_position VARCHAR(20) NOT NULL,
Duration_Internship INT NOT NULL,
Department_name VARCHAR(20) NOT NULL,
Package_ID SMALLINT FOREIGN KEY REFERENCES PackagesPerks(Package_ID)
);

CREATE TABLE "Customer_Support"
(
Cust_Support_ID SMALLINT NOT NULL PRIMARY KEY,
Contact INT NOT NULL,
Service_Name VARCHAR(20)
);

CREATE TABLE "Subscriber"
(
Subscriber_ID SMALLINT NOT NULL PRIMARY KEY,
Subscriber_FName VARCHAR(20) NOT NULL,
Subscriber_LName VARCHAR(20) NOT NULL,
Subscription_period SMALLINT NOT NULL,
Payment_Method VARCHAR(10) NOT NULL,
Cust_Support_ID SMALLINT FOREIGN KEY REFERENCES Customer_Support(Cust_Support_ID)
);

CREATE TABLE "Offices"
(
OfficeID SMALLINT NOT NULL PRIMARY KEY,
Office_Address1 VARCHAR(20) NOT NULL,
City VARCHAR(10),
Zipcode SMALLINT,
Careers_ID SMALLINT FOREIGN KEY REFERENCES Careers(Careers_ID),
Subscriber_ID SMALLINT FOREIGN KEY REFERENCES Subscriber(Subscriber_ID)
);

CREATE TABLE "Employees"
(
Employee_ID SMALLINT NOT NULL PRIMARY KEY,
F_Name VARCHAR(20) NOT NULL,
L_Name VARCHAR(20) NOT NULL,
Date_of_Birth DATE,
Position VARCHAR(20) NOT NULL,
Package_ID SMALLINT FOREIGN KEY REFERENCES PackagesPerks(Package_ID),
EncF_Name VARBINARY(200),
EncL_Name VARBINARY(200),
);

CREATE TABLE "Show_Schedule"
(
Show_ID SMALLINT NOT NULL Identity(1,1) PRIMARY KEY,
Show_Name VARCHAR(20) NOT NULL,
Show_Time TIME,
Show_Day VARCHAR(10) NOT NULL
);

CREATE TABLE "Guest_Speaker"
(
Guest_ID  SMALLINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Guest_FName VARCHAR(20) NOT NULL,
Guest_LName VARCHAR(20) NOT NULL,
Area_of_Expertise VARCHAR(20) NOT NULL,
Phone_number INT NOT NULL,
Email_ID nvarchar(50), 
Show_ID SMALLINT FOREIGN KEY REFERENCES Show_Schedule(Show_ID)
);

CREATE TABLE "Delivery_M"
(
ID SMALLINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Delivery_mode VARCHAR(20) NOT NULL,
Delivery_Date DATE NOT NULL,
);

CREATE TABLE "Social_Media_Outreach"
(
Media_ID SMALLINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Media_type VARCHAR(20),
Media_Platform VARCHAR(20),
Media_Date DATE NOT NULL,
ID SMALLINT FOREIGN KEY REFERENCES Delivery_M(ID)
);

CREATE TABLE "Sponsor_Information"
(
Sponsor_ID SMALLINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Sponsor_FName VARCHAR(20) NOT NULL,
Sponsor_LName VARCHAR(20) NOT NULL,
Contact_Info INT NOT NULL,
Max_Amount INT NOT NULL 
);

--Associative Entities

CREATE TABLE "Employee_Office"
(
Employee_ID SMALLINT FOREIGN KEY REFERENCES Employees(Employee_ID),
OfficeID SMALLINT FOREIGN KEY REFERENCES Offices(OfficeID)
);

INSERT INTO Employee_Office
SELECT Employee_ID, OfficeID
FROM Employees
FULL JOIN Offices
ON Employees.Employee_ID = Offices.OfficeID 

SELECT * FROM Employee_Office;
 
CREATE TABLE "Subscriber_Delivery"
(
ID SMALLINT FOREIGN KEY REFERENCES Delivery_M(ID),
Subscriber_ID SMALLINT FOREIGN KEY REFERENCES Subscriber(Subscriber_ID)
);

INSERT INTO Subscriber_Delivery
SELECT ID, Subscriber_ID
FROM Delivery_M
FULL JOIN Subscriber
ON Delivery_M.ID = Subscriber.Subscriber_ID

SELECT * FROM Subscriber_Delivery;
 
CREATE TABLE "Offc_Shows"
(
OfficeID SMALLINT FOREIGN KEY REFERENCES Offices(OfficeID),
Show_ID SMALLINT FOREIGN KEY REFERENCES Show_Schedule(Show_ID)
);

INSERT INTO Offc_Shows
SELECT OfficeID, Show_ID
FROM Offices
FULL JOIN Show_Schedule
ON Offices.OfficeID = Show_Schedule.Show_ID

SELECT * FROM Offc_Shows;

CREATE TABLE "Show_Sponsor"
(
Sponsor_ID SMALLINT FOREIGN KEY REFERENCES Sponsor_Information(Sponsor_ID),
Show_ID SMALLINT FOREIGN KEY REFERENCES Show_Schedule(Show_ID)
);

INSERT INTO Show_Sponsor
SELECT Sponsor_ID, Show_ID
FROM Sponsor_Information
FULL JOIN Show_Schedule
ON Sponsor_Information.Sponsor_ID = Show_Schedule.Show_ID

SELECT * FROM Show_Sponsor;

CREATE TABLE "Off_Subscriber"
(
OfficeID SMALLINT FOREIGN KEY REFERENCES Offices(OfficeID),
Subscriber_ID SMALLINT FOREIGN KEY REFERENCES Subscriber(Subscriber_ID)
);

INSERT INTO Off_Subscriber
SELECT OfficeID, Subscriber.Subscriber_ID
FROM Offices
FULL JOIN Subscriber
ON Offices.OfficeID = Subscriber.Subscriber_ID

SELECT * FROM Off_Subscriber;

--Inserting values into the tables created above
--Data Manipulation Language

INSERT INTO PackagesPerks (Package_ID, Salary, Paid_Leave, Insurance, Travel_benefits, Flex_Time)
VALUES (1,298766,30,'ISO','NO','1:00:00'),
(2,433423,30,'ISO','NO','2:00:00'),
(3,568080,30,'ISO','NO','2:00:00'),
(4,17357,20,'Blue','NO','2:00:00'),
(5,93631,30,'NEU', 'NO', '3:00:00'),
(6,231766,30,'NYState','NO','4:00:00'),
(7,48736,60,'ISO','NO','5:00:00'),
(8,349426,40,'ISO','NO','5:00:00'),
(9,654382,40,'Blue','NO','5:00:00'),
(10,93631,30,'NEU', 'NO', '3:00:00');

SELECT * FROM PackagesPerks;

INSERT INTO Careers (Careers_ID, Intern_position, Duration_Internship, Department_name, Package_ID)
VALUES (1,'Sales Manager',6,'Sales Team',1),
(2,'Marketing Head',10,'Payment',2),(3,'Software Developer',3,'Rates',3),
(4,'Cinematographer',4,'Media',4),(5,'Project Development',9,'Media',5),
(6,'Supplychain Engineer',12,'Logistics',6),(7,'Software Services',6,'Engineering',7),
(8,'HR',4,'Event',8),(9,'Data Analyst',6,'Engineering',9),
(10,'Devops',10,'Payment',10);

SELECT * FROM Careers;

INSERT INTO Customer_Support(Cust_Support_ID, Contact, Service_Name )
VALUES (1, 61737341, 'Husky Card Services'),
(2, 617373658,'ResNet'),
(3,617373689,'ITS'),
(4,617373462,'ResNet'),
(5,617837208,'ITS'),
(6,617379726,'Husky Card Services'),
(7,617338642,'ResNet'),
(8,617027263,'ITS'),
(9,613730987,'ResNet'),
(10,17294924,'ResNet');

UPDATE Customer_Support
SET Contact = 617826398
WHERE Cust_Support_ID = 1;

UPDATE Customer_Support
SET Contact = 617876398
WHERE Cust_Support_ID = 10;

INSERT INTO Subscriber (Subscriber_ID, Subscriber_FName, Subscriber_LName, Subscription_period,Payment_Method, Cust_Support_ID)
VALUES (1,'John','Lese',365,'Debit',1),
(2,'Bravo','Meng',265,'Discover',2),(3,'Sonia','Thakur',165,'Discover',3),
(4,'Camila','Lucia',265,'MasterCard',3),(5,'Nitin','Mathe',365,'Visa',4),
(6,'Pete','Deve',365,'Visa',5),(7,'Laksh','Yang',165,'MasterCard',6),
(8,'Jack','Webe',165,'MasterCard',6),(9,'Lee','Yen',365,'Visa',9),
(10,'Tina','Yini',265,'Discover',10);

SELECT * FROM Subscriber;

INSERT INTO Offices (OfficeID, Office_Address1, City, Zipcode,Careers_ID, Subscriber_ID)
VALUES (1,'1344 Huntington','Boston',02120,1,1),
(2,'420 ADM Drive','Waltham',02100,1,2),(3,'120 Lake Drive','Cambridge',02460,3,2),
(4,'20 Layman Drive','Natick',02340,4,5),(5,'100 Winter street','Burlington',02830,1,3),
(6,'520 Lexington street','Salem',02110,2,4),(7,'600 Wayman street','LOwell',02580,3,7),
(8,'75 Parker Drive','Newton',02320,8,9),(9,'502 Lyman street','Quincy',02410,6,10),
(10,'60 Dunkin street','Brookline',02590,5,8);

SELECT * FROM Offices

INSERT INTO Employees (Employee_ID, F_Name, L_Name, Date_of_Birth,Position,Package_ID)
VALUES (1,'Johnny','easse','03/20/1995','Sales Representative',1),
(2,'Brad','Megamind','07/07/1899','Customer Relations',2),(3,'Sonakshi','Thakur','7/15/1991','Operations Manager',5),
(4,'Cam','Radnor','12/12/1975','Director',8),(5,'Nick','Mathers','04/16/1982',' Social Manager',4),
(6,'Patrick','Dave','08/13/1984','Hiring Manager',3),(7,'Christy','Ying','04/12/1988','Database Developer',6),
(8,'Jack','Webber','09/19/1993','Student Intern',2),(9,'Jackie','Chan','05/30/1990','Customer Service',7),
(10,'Harshitha','Gowda','08/25/1994','President',10);

SELECT * FROM Employees;

INSERT INTO Show_Schedule(Show_Name, Show_Time, Show_Day)
VALUES ('INFO6210','12:00:00', 'MONDAY'),
('INFO6120','13:00:00','MONDAY'),
('INFO738','14:00:00','MONDAY'),
('INFO468','15:00:00','MONDAY'),
('INFO8731','16:00:00','MONDAY'),
('WorldNews','17:00:00','MONDAY'),
('Finance','18:00:00','MONDAY'),
('NortheasternEvents','19:00:00','MONDAY'),
('Sports','20:00:00','MONDAY'),
('Music','11:00:00','MONDAY');

SELECT * FROM Show_Schedule
ORDER BY Show_Time;

INSERT INTO Guest_Speaker(Guest_FName, Guest_LName,Area_of_Expertise,Phone_number,Email_ID, Show_ID)
VALUES ('Ken','DHers','Software',61737341,'ken@news.com',2),
('Terri','Sánchez','Marketing',617373658,'terrik@news.com',1),
('Roberto','Duffy','SupplyChain',617373689,'rob@news.com',4),
('Rob','Tamburello','Software',617373462,'rob@news.com',5),
('Gail','Walters','Media',617837208,'gail@news.com',9),
('Jossef','Erickson','Media',617379726,'joss@news.com',10),
('Dylan','Goldberg','Software',617338641,'ylan@news.com',6),
('Diane','Miller','Media',617338642,'diane@news.com',3),
('Gigi','Margheim','SupplyChain',617027263,'gigi@news.com',7),
('Michael','Matthew','Marketing',617027266,'mick@news.com',8);

DELETE FROM Guest_Speaker
WHERE Guest_ID>10;
SELECT * FROM Sponsor_Information;
	
SELECT * FROM Guest_Speaker;

INSERT INTO Delivery_M(Delivery_mode, Delivery_Date)
VALUES ('Paper', '1/2/2017'),
('Flyer', '1/3/2017'),
('NewsPaper', '1/2/2017'),
('Booklet', '1/3/2017'),
('Social Media', '2/2/2017'),
('Flyer','3/6/2017'),
('Online webpage','3/6/2017'),
('Newspaper','4/7/2017'),
('NU Website','4/6/2017'),
('BostonGlobe','7/4/2017');

SELECT * FROM Delivery_M;

INSERT INTO Social_Media_Outreach(Media_type, Media_Platform,Media_Date,ID)
VALUES ('Youtube','Internet','1/2/2017',5),
('Twitter','Internet','1/3/2017',5),
('Facebook','Internet','2/2/2017',5),
('Facebook','Internet','7/4/2017',7),
('Twitter','Internet','7/2/2017',10),
('Youtube','Internet','12/4/2017',5),
('FM','Internet','2/4/2017',10),
('Twitter','Internet','7/8/2017',10),
('Facebook','Internet','7/6/2017',7),
('Youtube','Internet','6/4/2017',5);

SELECT * FROM Social_Media_Outreach;

INSERT INTO Sponsor_Information(Sponsor_FName, Sponsor_LName,Contact_Info,Max_Amount)
VALUES ('Kens','DHerss',61747341,50000),
('Terris','Sánchezs',617374658,60000),
('Robertso','Duffys',617378689,10000),
('Robs','Tamburellos',617353462,60000),
('Gails','Walterss',617837204,55000),
('Jossesf','Ericksons',617378726,30000),
('Dylans','Goldbersg',617338641,15000),
('Dianes','Millesr',617338602,25000),
('Gigis','Margheims',617027663,80000),
('Michael','Matthews',617027366,30000);

DELETE FROM Sponsor_Information
WHERE Sponsor_ID>10;
SELECT * FROM Sponsor_Information;

--Function
--Creating a function with check constraint to check if no employee has salary <10,000

CREATE FUNCTION ChKSalary
(
@Package_ID INT
)
RETURNS INT

AS 
BEGIN

DECLARE @Salary INT = 0;
SELECT @Salary = PackagesPerks.Salary
FROM PackagesPerks
WHERE @Package_ID= PackagesPerks.Package_ID
AND Salary<10000;

RETURN @Salary
END

-- Add table-level CHECK constraint based on the new function for the PackagesPerks table
ALTER TABLE PackagesPerks ADD CONSTRAINT LessThan10000 CHECK (dbo.ChKSalary(Package_ID) = 0);

--Allow new entry above 10,000
INSERT INTO PackagesPerks (Package_ID, Salary, Paid_Leave, Insurance, Travel_benefits, Flex_Time)
VALUES (11,28760,10,'Northeastern','NO','16:00:00')

--Ban Entry below 10,000
INSERT INTO PackagesPerks (Package_ID, Salary, Paid_Leave, Insurance, Travel_benefits, Flex_Time)
VALUES (12,3870,12,'GEICO','NO','11:00:00')

DROP FUNCTION ChKSalary;

--SQL Procedure
/*Procedure to identify the Name of the show to which the Guest is invited by providing
First Name of the Guest*/

CREATE PROCEDURE AOE_media  
(
 @Guest_Fname VARCHAR(20) --Input Parameter
) 
 AS 
 BEGIN 
 
 SELECT sh.Guest_ID,sh.Guest_FName,sh.Guest_LName,sh.Area_of_Expertise,sc.Show_Name
 FROM Guest_Speaker sh 
 INNER JOIN Show_Schedule sc
 ON sh.Show_ID = sc.Show_ID
 WHERE Area_of_Expertise = 'Media'
 
END

EXEC AOE_media @Guest_Fname = 'Gail';
DROP PROCEDURE AOE_Media


--After Insert Trigger
--Creating Audit Table for After Insert Trigger
CREATE TABLE "Employees_Test_Audit"
(
Employee_ID SMALLINT NOT NULL PRIMARY KEY,
F_Name VARCHAR(20) NOT NULL,
L_Name VARCHAR(20) NOT NULL,
Date_of_Birth DATE,
Position VARCHAR(20) NOT NULL,
Package_ID INT,
audit_action VARCHAR(100),
audit_Timestamp DATETIME
);

--Create After Insert Trigger which will display the new entries in the Audit Table along with the Time Stamp
CREATE TRIGGER Tgr ON Employees 
AFTER INSERT 

AS 
BEGIN

SET NOCOUNT ON;
DECLARE @Employee_ID INT; DECLARE @F_Name VARCHAR(20); DECLARE @L_Name VARCHAR(20);
DECLARE @Date_of_Birth DATE; DECLARE @Position VARCHAR(20); DECLARE @Package_ID INT;
DECLARE @audit_action varchar(100);

SELECT @Employee_ID=i.Employee_ID from inserted i;	SELECT @F_Name=i.F_Name from inserted i;	
SELECT @L_Name=i.L_Name from inserted i; SELECT @Date_of_Birth=i.Date_of_Birth from inserted i;	
SELECT @Position=i.Position from inserted i; SELECT @Package_ID=i.Package_ID from inserted i;	
SET @audit_action='Inserted Record -- After Insert Trigger.';

INSERT INTO Employees_Test_Audit
 (Employee_ID, F_Name, L_Name, Date_of_Birth, Position, Package_ID, audit_action, Audit_Timestamp )
 VALUES(@Employee_ID, @F_Name, @L_Name, @Date_of_Birth, @Position, @Package_ID,@audit_action, getdate());
PRINT 'AFTER INSERT Trigger fired.'
END

GO

INSERT INTO Employees(Employee_ID, F_Name, L_Name, Date_of_Birth,Position,Package_ID)
VALUES(13,'Avirat','Gaikwad','03/20/1995','CFO',9)

SELECT * FROM Employees_Test_Audit;

DROP TRIGGER Tgr;

--SQL Views
--This view displays the details such as Insurance, Salary etc. for specific positions 

CREATE VIEW [Packages_Insurance] AS
SELECT Insurance, Salary, Flex_Time, Intern_position, Department_Name
FROM [PackagesPerks]
LEFT JOIN Careers
ON Careers.Package_ID = PackagesPerks.Package_ID;

SELECT * FROM Packages_Insurance;

DROP VIEW Packages_Insurance;

--View displays the Name of the service(In this case-ITS) for Subscribers

CREATE VIEW [ITS Customer_Support] AS
SELECT Subscriber_FName, Subscription_period, Service_Name
FROM Customer_Support
LEFT JOIN Subscriber
ON Subscriber.Cust_Support_ID = Customer_Support.Cust_Support_ID
WHERE Service_Name = 'ITS';

SELECT * FROM [ITS Customer_Support];

DROP VIEW [ITS Customer_Support];

--Basic view depicting the Subscriber Information
CREATE VIEW [SubscriberName] AS
SELECT Subscriber_FName, Subscriber_LName, Payment_Method
FROM [Subscriber];

SELECT * FROM [SubscriberName]
DROP VIEW SubscriberName;

--Query for Column Encryption

-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Test_P@sswOrd';

-- Create certificate to protect symmetric key
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'AdventureWorks Test Certificate',
EXPIRY_DATE = '2026-10-31';

-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;

-- Open symmetric key
OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;

GO

UPDATE Employees
SET EncF_Name = EncryptByKey(Key_GUID(N'TestSymmetricKey'), F_Name);

UPDATE Employees
SET EncL_Name = EncryptByKey(Key_GUID(N'TestSymmetricKey'), L_Name);

-- Show the results
SELECT * FROM Employees;

-- Close the symmetric key
CLOSE SYMMETRIC KEY TestSymmetricKey;

-- Drop the symmetric key
DROP SYMMETRIC KEY TestSymmetricKey;

-- Drop the certificate
DROP CERTIFICATE TestCertificate;

--Drop the DMK
DROP MASTER KEY;

DROP DATABASE Group9;