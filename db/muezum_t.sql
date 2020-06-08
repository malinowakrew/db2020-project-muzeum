-- MariaDB dump 10.17  Distrib 10.4.11-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: muzeum
-- ------------------------------------------------------
-- Server version	10.4.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autor` (
  `autorID` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `imie` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `nazwisko` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `pseudonim` varchar(100) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`autorID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'tycjan','woronko','tyci'),(2,'edyta','mroz','');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bilet`
--

DROP TABLE IF EXISTS `bilet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bilet` (
  `biletID` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `cena` float NOT NULL,
  `data_zakupu` date NOT NULL,
  `wystawaID` int(6) unsigned DEFAULT NULL,
  `nazwa_uzytkownika` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`biletID`),
  KEY `bilet_wystawa` (`wystawaID`),
  KEY `bilet_uzytkownik` (`nazwa_uzytkownika`),
  CONSTRAINT `bilet_uzytkownik` FOREIGN KEY (`nazwa_uzytkownika`) REFERENCES `uzytkownik` (`nazwa`),
  CONSTRAINT `bilet_wystawa` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bilet`
--

LOCK TABLES `bilet` WRITE;
/*!40000 ALTER TABLE `bilet` DISABLE KEYS */;
INSERT INTO `bilet` VALUES (1,12,'2020-05-14',3,'przyklad'),(2,12,'2020-05-13',4,'agatka23'),(3,12,'2020-05-04',4,'przyklad'),(4,40,'2019-03-05',2,'agatka23'),(5,40,'2019-03-05',2,'agatka23'),(6,34,'2020-05-30',5,'ed'),(7,50,'2020-05-30',5,'ed'),(10,50,'2020-06-02',3,'ed');
/*!40000 ALTER TABLE `bilet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `budynek`
--

DROP TABLE IF EXISTS `budynek`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `budynek` (
  `budynekID` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(100) DEFAULT NULL,
  `adres` varchar(255) NOT NULL,
  PRIMARY KEY (`budynekID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budynek`
--

LOCK TABLES `budynek` WRITE;
/*!40000 ALTER TABLE `budynek` DISABLE KEYS */;
INSERT INTO `budynek` VALUES (1,'Gmach główny','ul. Muzealna 17'),(2,'Biały Dworek','ul. Dworska 12');
/*!40000 ALTER TABLE `budynek` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cena`
--

DROP TABLE IF EXISTS `cena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cena` (
  `cenaID` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `typ` varchar(255) CHARACTER SET utf8 NOT NULL,
  `koszt` float NOT NULL,
  PRIMARY KEY (`cenaID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cena`
--

LOCK TABLES `cena` WRITE;
/*!40000 ALTER TABLE `cena` DISABLE KEYS */;
INSERT INTO `cena` VALUES (1,'ulgowy',12),(2,'normalny',34),(3,'ulgowy - VIP',50),(4,'normalny - VIP',100);
/*!40000 ALTER TABLE `cena` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cena_wystawa`
--

DROP TABLE IF EXISTS `cena_wystawa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cena_wystawa` (
  `cenaID` int(6) unsigned DEFAULT NULL,
  `wystawaID` int(6) unsigned DEFAULT NULL,
  KEY `cena_wystawa` (`cenaID`),
  KEY `wystawa_cena` (`wystawaID`),
  CONSTRAINT `cena_wystawa` FOREIGN KEY (`cenaID`) REFERENCES `cena` (`cenaID`),
  CONSTRAINT `wystawa_cena` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cena_wystawa`
--

LOCK TABLES `cena_wystawa` WRITE;
/*!40000 ALTER TABLE `cena_wystawa` DISABLE KEYS */;
INSERT INTO `cena_wystawa` VALUES (3,3),(1,3),(2,4),(1,4),(3,3),(1,3),(2,4),(1,4),(1,5),(2,5),(3,5),(1,30),(3,30),(1,31),(2,31),(3,31),(4,31),(1,32),(2,32);
/*!40000 ALTER TABLE `cena_wystawa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eksponat`
--

DROP TABLE IF EXISTS `eksponat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eksponat` (
  `tytul` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `rok_powstania` date DEFAULT NULL,
  `eksponatID` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `wystawaID` int(6) unsigned DEFAULT NULL,
  `opis` blob DEFAULT NULL,
  PRIMARY KEY (`eksponatID`),
  KEY `wystawa` (`wystawaID`),
  CONSTRAINT `wystawa` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eksponat`
--

LOCK TABLES `eksponat` WRITE;
/*!40000 ALTER TABLE `eksponat` DISABLE KEYS */;
INSERT INTO `eksponat` VALUES ('Nie ma tytuły - jest biblioteka','0000-00-00',1,7,NULL),('Żden','2020-05-07',2,6,NULL),('nazwa','1999-01-01',3,NULL,'nie można wyrazić tego słowami'),('nazwa','0001-01-01',4,NULL,'1'),('muzeum','0001-01-01',5,NULL,'1'),('{nazwa}','0000-00-00',6,6,'{opis}'),('4','0004-04-04',7,6,'44'),('4','0004-04-04',8,6,'4'),('4','0004-04-04',9,6,'4'),('3','0003-03-03',10,3,'3');
/*!40000 ALTER TABLE `eksponat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eksponat_autor`
--

DROP TABLE IF EXISTS `eksponat_autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eksponat_autor` (
  `eksponatID` int(6) unsigned DEFAULT NULL,
  `autorID` int(6) unsigned DEFAULT NULL,
  KEY `eksponat_autor` (`eksponatID`),
  KEY `autor_eksponat` (`autorID`),
  CONSTRAINT `autor_eksponat` FOREIGN KEY (`autorID`) REFERENCES `autor` (`autorID`),
  CONSTRAINT `eksponat_autor` FOREIGN KEY (`eksponatID`) REFERENCES `eksponat` (`eksponatID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eksponat_autor`
--

LOCK TABLES `eksponat_autor` WRITE;
/*!40000 ALTER TABLE `eksponat_autor` DISABLE KEYS */;
INSERT INTO `eksponat_autor` VALUES (1,1),(2,1),(10,1),(4,1),(7,1),(3,2),(5,2);
/*!40000 ALTER TABLE `eksponat_autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pracownik`
--

DROP TABLE IF EXISTS `pracownik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pracownik` (
  `pracownikID` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `imie` varchar(20) CHARACTER SET utf8 NOT NULL,
  `nazwisko` varchar(20) CHARACTER SET utf8 NOT NULL,
  `nazwa` varchar(100) NOT NULL,
  `budynekID` int(6) unsigned NOT NULL,
  PRIMARY KEY (`pracownikID`),
  UNIQUE KEY `nazwa` (`nazwa`),
  KEY `pracownik_budynek` (`budynekID`),
  CONSTRAINT `pracownik_budynek` FOREIGN KEY (`budynekID`) REFERENCES `budynek` (`budynekID`),
  CONSTRAINT `pracownik_uzytkownik` FOREIGN KEY (`nazwa`) REFERENCES `uzytkownik` (`nazwa`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pracownik`
--

LOCK TABLES `pracownik` WRITE;
/*!40000 ALTER TABLE `pracownik` DISABLE KEYS */;
INSERT INTO `pracownik` VALUES (1,'Jan','Żurek','przyklad',2),(2,'Jan','Kamień','ed',2);
/*!40000 ALTER TABLE `pracownik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sala`
--

DROP TABLE IF EXISTS `sala`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sala` (
  `salaID` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `numer` int(5) NOT NULL,
  `wielkosc` int(10) DEFAULT NULL,
  `budynekID` int(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`salaID`),
  KEY `budynek_sala` (`budynekID`),
  CONSTRAINT `budynek_sala` FOREIGN KEY (`budynekID`) REFERENCES `budynek` (`budynekID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala`
--

LOCK TABLES `sala` WRITE;
/*!40000 ALTER TABLE `sala` DISABLE KEYS */;
INSERT INTO `sala` VALUES (1,1,13,2),(2,2,5,2),(3,1,50,1),(4,2,8,1),(5,3,15,1);
/*!40000 ALTER TABLE `sala` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uzytkownik`
--

DROP TABLE IF EXISTS `uzytkownik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uzytkownik` (
  `nazwa` varchar(100) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 NOT NULL,
  `haslo` varchar(15) CHARACTER SET utf8 NOT NULL,
  UNIQUE KEY `nazwa` (`nazwa`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uzytkownik`
--

LOCK TABLES `uzytkownik` WRITE;
/*!40000 ALTER TABLE `uzytkownik` DISABLE KEYS */;
INSERT INTO `uzytkownik` VALUES ('agatka23','agatka23@gmail.com','brak123'),('ed','zal','123'),('przyklad','nic@gmail.com','nic');
/*!40000 ALTER TABLE `uzytkownik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wystawa`
--

DROP TABLE IF EXISTS `wystawa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wystawa` (
  `wystawaID` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(100) CHARACTER SET utf8 NOT NULL,
  `poczatek` date NOT NULL,
  `koniec` date NOT NULL,
  `pracownikID` int(6) unsigned NOT NULL,
  PRIMARY KEY (`wystawaID`),
  KEY `indeks` (`pracownikID`),
  CONSTRAINT `wystawa_pracownik` FOREIGN KEY (`pracownikID`) REFERENCES `pracownik` (`pracownikID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wystawa`
--

LOCK TABLES `wystawa` WRITE;
/*!40000 ALTER TABLE `wystawa` DISABLE KEYS */;
INSERT INTO `wystawa` VALUES (2,'Wojna','2018-01-01','2019-01-01',1),(3,'Bal u Wyspiańskiego','2020-01-01','2020-12-01',1),(4,'Impresjonizm realny','2020-01-01','2020-07-01',1),(5,'Czarna dama','2020-03-13','2020-09-12',1),(6,'czara owca','1998-01-01','1999-01-01',1),(7,'misie','1999-01-01','1999-02-02',1),(8,'1','0001-01-01','0002-02-02',1),(9,'ładne rzeczy ','1999-01-01','1999-12-12',2),(11,'199','2011-11-11','2012-12-12',2),(18,'nazwa','1999-01-01','1999-12-12',2),(19,'nazwa','1999-01-01','1999-12-12',2),(20,'12','0009-09-09','0010-09-09',2),(21,'wystawa super jest ','1970-01-01','1971-01-01',2),(22,'lol','1200-12-12','1201-12-12',2),(23,'1','0001-01-01','0001-01-01',1),(30,'hehe','0213-03-02','0433-02-03',2),(31,'best','0055-03-04','0066-01-03',2),(32,'cyrk','0001-01-01','0002-02-02',2);
/*!40000 ALTER TABLE `wystawa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wystawa_sala`
--

DROP TABLE IF EXISTS `wystawa_sala`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wystawa_sala` (
  `salaID` int(6) unsigned NOT NULL,
  `wystawaID` int(6) unsigned NOT NULL,
  KEY `wystawa_sala_1` (`wystawaID`),
  KEY `sala_wystawa_1` (`salaID`),
  CONSTRAINT `sala_wystawa_1` FOREIGN KEY (`salaID`) REFERENCES `sala` (`salaID`),
  CONSTRAINT `wystawa_sala_1` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wystawa_sala`
--

LOCK TABLES `wystawa_sala` WRITE;
/*!40000 ALTER TABLE `wystawa_sala` DISABLE KEYS */;
INSERT INTO `wystawa_sala` VALUES (2,3),(1,3),(5,3),(2,4),(1,18),(1,18),(1,20),(2,21),(1,22),(1,8),(1,30),(2,31),(2,32);
/*!40000 ALTER TABLE `wystawa_sala` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-08 16:59:31
