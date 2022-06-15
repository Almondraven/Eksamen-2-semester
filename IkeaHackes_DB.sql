DROP DATABASE IF EXISTS ikea_hacks;
CREATE DATABASE ikea_hacks;
USE ikea_hacks;

CREATE TABLE `User` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Role` varchar(13) NOT NULL CHECK (`Role` IN ('contributor', 'admin')),
  `Firstname` varchar(20) NOT NULL,
  `Surname` varchar(40) NOT NULL,
  `Birthdate` Date DEFAULT NULL,
  `Email` varchar(40) NOT NULL,
  `NumberOfPosts` int DEFAULT NULL,
  PRIMARY KEY (`UserID`)
);

INSERT INTO `user` (`Username`, `Password`, `Role`, `Firstname`, `Surname`, `Birthdate`, `Email`, `NumberOfPosts`) VALUES
('lopo814','qYrCHw5b','admin','Loke','poulsen','1990-04-08','lopo814@Ikea.com',null),
('thehustlerrasp','fJGMKUT3','contributor','Lau','Hansen','2000-02-09','hustlerraspberry@gmail.com',3),
('gonegirlnova','N9gLNaeC','contributor','Kirstine','Olsen','1997-01-20','gonegirl@live.dk',2),
('samuraibeat','fMtU96F4','contributor','Kenneth','skovgaard','1993-12-20','samuraibeat@gmail.com',0),
('ratdeer','7TFWu2ZU','contributor','Mikkel','Thomsen','2003-08-17','deermikkel@outlook.com',0);

CREATE TABLE `ParentCategory` (
  `ParentCategoryID` int NOT NULL AUTO_INCREMENT,
  `ParentcategoryName` varchar(40),
  `NumberOfSubCategories` int DEFAULT NULL,
  PRIMARY KEY (`ParentCategoryID`)
);

INSERT INTO `ParentCategory` (`ParentcategoryName`, `NumberOfSubcategories`) VALUES
('Stole',4),
('Reoler og opbevaring',3),
('Skabe og Vitrineskabe',2),
('TV og Mediemøbler',2),
('Garderobeskabe',3);

CREATE TABLE `SubCategory` (
  `SubCategoryID` int NOT NULL AUTO_INCREMENT,
  `ParentCategoryID` int NOT NULL,
  `SubCategoryName` varchar(40),
  `NumberOfproducts` int Default NULL,
  PRIMARY KEY (`SubCategoryID`),
  FOREIGN KEY (`ParentCategoryID`) REFERENCES `ParentCategory`(`ParentCategoryID`)
);

INSERT INTO `SubCategory` (`ParentCategoryID`, `SubCategoryName`, `NumberOfproducts`) VALUES
(1,'Spisebordsstole',4),
(1,'Lænestole',3),
(1,'Kontorstole og Skrivebordsstole',2),
(1,'Barstole',2),
(2,'Væghylder',2),
(2,'Reolsystemer',2),
(2,'Køkkenreoler',1),
(3,'Opbeveringssystem til stue',2),
(3,'Vitrinskabe',2),
(4,'TV og medieopbevaring',1),
(4,'TV-borde',3),
(5,'Åbne garderobeskabe',2),
(5,'Walk-in closet',2),
(5,'Hjørnegarderober',2);

CREATE TABLE `product` (
  `productID` int NOT NULL AUTO_INCREMENT,
  `ParentCategoryID` int NOT NULL,
  `SubCategoryID` int NOT NULL,
  `productName` varchar(40),
  `Price` int NOT NULL,
  PRIMARY KEY (`productID`),
  FOREIGN KEY (`ParentCategoryID`) REFERENCES `ParentCategory`(`ParentCategoryID`),
  FOREIGN KEY (`SubCategoryID`) REFERENCES `SubCategory`(`SubCategoryID`)
);

INSERT INTO `product` (`ParentCategoryID`,`SubCategoryID`, `productName`, `Price`) VALUES
(1,1,'Stockholm',1495),
(1,1,'Bergmund',565),
(1,1,'Gunleif',895),
(1,1,'leifarne',345),
(1,2,'Strandmon',2299),
(1,2,'Poang',799),
(1,2,'Ekenaset',1699),
(1,3,'Markus',1299),
(1,3,'Flintan',449),
(1,4,'Stig',95),
(1,4,'Ingolf',495),
(2,5,'Væghylder',2),
(2,5,'Væghylder',2),
(2,6,'Hyllis',99),
(2,6,'Baggebo',159),
(2,7,'Hejne',198),
(3,8,'Bestå',2880),
(3,8,'Platsa',4049),
(3,9,'Rudsta',999),
(3,9,'Milsbo',1899),
(4,10,'Kallax',449),
(4,11,'Lack',99),
(4,11,'Brimnes',699),
(4,11,'Byås',1149),
(5,12,'Pax',5720),
(5,12,'Boaxel',1320),
(5,13,'Elvarli',5870),
(5,13,'Pax',3490),
(5,14,'Pax',7210),
(5,14,'Grimo',9350);

CREATE TABLE `Posts` (
  `PostID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `ParentCategoryID` int NOT NULL,
  `SubCategoryID` int NOT NULL,
  `productID` int NOT NULL,
  `titel` varchar(30),
  `CreationDateTime` datetime NOT NULL,
  `ReleaseDateTime` datetime DEFAULT NULL,
  `ArchiveDateTime` datetime DEFAULT NULL,
  `Article` text DEFAULT NULL,
  `AverageRating` double DEFAULT NULL,
  `RatingCount` int DEFAULT NULL,
  PRIMARY KEY (`PostID`),
  FOREIGN KEY (`ParentCategoryID`) REFERENCES `ParentCategory`(`ParentCategoryID`),
  FOREIGN KEY (`UserID`) REFERENCES `User`(`UserID`),
  FOREIGN KEY (`SubCategoryID`) REFERENCES `SubCategory`(`SubCategoryID`),
  FOREIGN KEY (`productID`) REFERENCES `product`(`productID`)
);

INSERT INTO `Posts` (`UserID`, `ParentCategoryID`, `SubCategoryID`, `productID`, `Titel`, `CreationDateTime`, `ReleaseDateTime`, `ArchiveDateTime`, `Article`, `AverageRating`, `RatingCount`) VALUES
('2','2','5','12','Væghylde til stol','2022-04-08 20:13:53','2022-04-09 15:21:01',null,'ContentLink1 eller fuld tekst til article inddelt i steps', 3.7, 18),
('2','3','8','18','Stuemøbel til stol','2022-05-03 10:14:22','2022-05-10 19:11:21','2022-05-29 12:11:11','ContentLink2 eller fuld tekst til article inddelt i steps', 1.3, 6),
('3','4','10','21','Smukt bord Ikeahack','2022-05-07 21:43:43','2022-05-21 12:19:47',null,'ContentLink3 eller fuld tekst til article inddelt i steps', 4.7, 42),
('2','5','12','25','Garderobeskab til stol','2022-04-08 20:13:53',null,null,'ContentLink4 eller fuld tekst til article inddelt i steps', null, null),
('3','5','14','30','Praktisk bænk Ikeahack','2022-06-07 20:13:53','2022-06-09 15:21:01',null,'ContentLink5 eller fuld tekst til article inddelt i steps', 5, 11);

CREATE VIEW `parent- and subcategories` AS
SELECT Parentcategory.ParentCategoryName, SubCategory.SubCategoryName
From Parentcategory
INNER JOIN SubCategory On Parentcategory.ParentCategoryID = SubCategory.ParentcategoryID;

CREATE VIEW `Parentcategories with number of subcategories` AS
SELECT Parentcategory.ParentCategoryName, COUNT(SubCategory.ParentCategoryID) AS NumberOfSubcategories
FROM ParentCategory
INNER JOIN SubCategory On Parentcategory.ParentCategoryID = SubCategory.ParentcategoryID
GROUP BY ParentCategoryName;

CREATE VIEW `Parentcategories with number of subcategories visible` AS
SELECT Parentcategory.ParentCategoryName, COUNT(SubCategory.ParentCategoryID) AS NumberOfSubcategories
FROM Posts
INNER JOIN SubCategory On Posts.SubCategoryID = SubCategory.SubcategoryID
INNER JOIN ParentCategory On Posts.ParentCategoryID = ParentCategory.ParentcategoryID
GROUP BY ParentCategoryName;

CREATE VIEW `Subcategories and number of Posts` AS
SELECT SubCategory.SubCategoryName, COUNT(posts.SubCategoryID) AS NumberOfPosts
FROM SubCategory
INNER JOIN Posts On SubCategory.SubCategoryID = posts.SubCategoryID
GROUP BY SubCategoryName;

CREATE VIEW `Search post by productname Example search "V"` AS
SELECT posts.titel, product.Productname
FROM Posts
INNER JOIN product On product.productID = posts.productID
WHERE product.productName like '%v%';

CREATE VIEW `Admin Information` AS
SELECT * FROM user
WHERE User.role = 'Admin';

CREATE VIEW `Contributor Information` AS
SELECT * FROM user
WHERE User.role = 'contributor';

CREATE VIEW `Posts and their contributors` AS
SELECT user.Firstname, user.Surname, user.Birthdate, user.Email, posts.titel, Parentcategory.ParentCategoryName AS parentcategory, SubCategory.SubcategoryName AS SubCategory, product.productName AS product, posts.CreationDatetime AS Creation, posts.ReleaseDateTime AS 'Release', posts.ArchiveDateTime as Archived, Posts.AverageRating, Posts.RatingCount
FROM Posts
INNER JOIN user ON user.UserID = Posts.UserID
INNER JOIN Parentcategory ON Parentcategory.ParentCategoryID = Posts.ParentcategoryID
INNER JOIN Subcategory ON Subcategory.SubCategoryID = Posts.SubCategoryID
INNER JOIN product ON product.productID = Posts.productID;

CREATE VIEW `A contributor and their posts` AS
SELECT user.Email, posts.titel, Parentcategory.ParentCategoryName AS parentcategory, SubCategory.SubcategoryName AS SubCategory, product.productName AS product, posts.CreationDatetime AS Creation, posts.ReleaseDateTime AS 'Release', posts.ArchiveDateTime as Archived, Posts.AverageRating, Posts.RatingCount
FROM Posts
INNER JOIN user ON user.UserID = Posts.UserID
INNER JOIN Parentcategory ON Parentcategory.ParentCategoryID = Posts.ParentcategoryID
INNER JOIN Subcategory ON Subcategory.SubCategoryID = Posts.SubCategoryID
INNER JOIN product ON product.productID = Posts.productID
WHERE user.Firstname = 'Lau';

DELIMITER $$
CREATE PROCEDURE `Search post by productname`(
in SearchValue varchar(40)
)
BEGIN
SELECT posts.titel, product.productname
FROM Posts
INNER JOIN product On product.productID = posts.productID
WHERE lower(product.prodcutName) like Searchvalue;
END$$

DELIMITER ;
;
