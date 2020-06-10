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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (3,'Krzystof','Musial',''),(4,'Wladyslaw','Skoczylas',''),(5,'Oskar','Hansen',''),(6,'Rejmund','Ziemski',''),(7,'Wanda','Paklikowska-Winnicka',''),(8,'Jan','Berdyszak','Berdu'),(9,'Hartmut','Bonk',''),(10,'Jolanta','Marcinkowska',''),(11,'Mieczyslaw','Wasilewski','Wasyl'),(12,'Krzysztof','Tracz','Asor'),(13,'Magdalena','Walulik',''),(14,'Edward','Karczmarski',''),(15,'Krzysztof','Musial',''),(16,'Jan','Berdyszak',''),(17,'Harmut','Bonk','');
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bilet`
--

LOCK TABLES `bilet` WRITE;
/*!40000 ALTER TABLE `bilet` DISABLE KEYS */;
INSERT INTO `bilet` VALUES (11,12,'2020-06-10',33,'bloondi'),(12,12,'2020-06-10',33,'bloondi'),(13,12,'2020-06-10',33,'bloondi'),(14,12,'2020-06-10',33,'bloondi'),(15,34,'2020-06-10',40,'damian'),(16,12,'2020-06-10',40,'damian'),(17,50,'2020-06-10',38,'T0m3k'),(18,12,'2020-06-10',35,'T0m3k'),(19,12,'2020-06-10',40,'T0m3k'),(20,50,'2020-06-10',33,'T0m3k'),(21,100,'2020-06-10',38,'Jano'),(22,34,'2020-06-10',40,'Jano'),(23,100,'2020-06-10',38,'Jano'),(24,50,'2020-06-10',38,'Jano'),(25,34,'2020-06-10',35,'Karolina'),(26,100,'2020-06-10',33,'Karolina'),(27,100,'2020-06-10',33,'Katja'),(28,100,'2020-06-10',33,'Katja'),(29,34,'2020-06-10',35,'Katja'),(30,34,'2020-06-10',35,'Katja'),(31,34,'2020-06-10',40,'Katja'),(32,12,'2020-06-10',40,'Mateusz'),(34,12,'2020-03-03',46,'bloondi'),(35,12,'2020-03-03',46,'bloondi'),(36,34,'2018-12-13',45,'Hugon'),(37,34,'2018-12-13',45,'Hugon'),(38,34,'2014-06-11',39,'Ewa'),(39,34,'2014-06-11',39,'Ewa'),(40,12,'2014-06-11',39,'Ewa'),(41,12,'2015-05-01',34,'Karolina'),(42,12,'2015-05-01',34,'Karolina'),(43,12,'2014-06-11',39,'Ewa'),(44,12,'2014-06-11',39,'Ewa'),(45,12,'2014-06-11',39,'Ewa'),(46,34,'2014-06-11',39,'Ewa'),(47,34,'2008-09-30',41,'Jano'),(48,34,'2008-09-30',41,'Jano'),(49,12,'1988-12-06',43,'damian'),(50,12,'1988-12-06',43,'damian'),(51,12,'1988-12-06',43,'damian'),(52,12,'1988-12-06',43,'damian'),(53,34,'1988-07-11',43,'t0m3k'),(54,34,'1988-07-11',43,'t0m3k'),(55,34,'1988-07-11',43,'t0m3k'),(56,34,'1988-07-11',43,'t0m3k'),(57,12,'1988-04-21',43,'Katja'),(58,12,'1988-04-21',43,'Katja'),(59,12,'1988-04-21',43,'Katja'),(60,34,'1988-04-21',43,'Katja');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budynek`
--

LOCK TABLES `budynek` WRITE;
/*!40000 ALTER TABLE `budynek` DISABLE KEYS */;
INSERT INTO `budynek` VALUES (1,'Muzeum Narodowe','Krakowskie Sr?dmiescie 5'),(2,'Dom Wyspianskiego','ul. Bronowicka 91'),(3,'Biblioteka Gl?wna','Krakowskie Sr?dmiescie 9');
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
INSERT INTO `cena_wystawa` VALUES (1,33),(2,33),(3,33),(4,33),(1,34),(2,34),(1,35),(2,35),(1,36),(2,36),(3,36),(4,36),(1,37),(2,37),(3,37),(4,37),(1,38),(2,38),(3,38),(4,38),(1,39),(2,39),(1,40),(2,40),(1,41),(2,41),(3,41),(4,41),(1,42),(2,42),(3,42),(4,42),(1,43),(2,43),(3,43),(4,43),(1,44),(2,44),(3,44),(4,44),(1,45),(2,45),(1,46),(2,46),(3,46),(4,46);
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eksponat`
--

LOCK TABLES `eksponat` WRITE;
/*!40000 ALTER TABLE `eksponat` DISABLE KEYS */;
INSERT INTO `eksponat` VALUES ('Boska Claudia','1983-05-03',11,33,'Obraz ukazujacy namietnosc'),('Rajski Ptak','1976-05-06',12,34,'Obraz ukazujący węża.'),('Lost in space','2007-01-01',13,38,'Obraz abstrakcyjny'),('Modern Landscape','2009-05-31',15,46,'Obraz przedstawia panorame.'),('Powiśle Warszawa','1999-03-24',16,35,'Obraz przedstawia budynek'),('Obraz czerwony abstrakt','2020-08-06',17,36,'Obraz przedstawia abstrakcję'),('Baletnica','2005-05-09',18,37,'Obraz przedstawia siedzącą baletnice'),('Odrodzenie','1979-10-04',19,39,'Obraz przedstawia abstrakcje'),('Różowe okulary','2000-10-01',20,40,'Obraz przedstawia kobiete'),('Myśli splątane','2003-07-23',22,41,'Obraz przedstawia abstrakcje'),('Drzewa piniowe II','1965-12-10',23,42,'Obraz przedstawia nature.'),('Osty II','1894-07-30',24,43,'Obraz przedstawia nature'),('Utkane z traw XVI','1977-09-20',25,44,'Obraz przedstawia abstrakcje'),('Alieny 1','2001-04-12',26,45,'Obraz przedstawia abstrakcje'),('Błękitna trawa, różowe gałęzie','1994-03-07',27,33,'Obraz przedstawia naturę'),('Ludzie i ich czas wolny','2005-04-05',28,35,'Obraz przedstawia naturę'),('A kuku','1976-09-09',29,36,'Portret'),('Wiosenna burza','1997-03-05',30,37,'Obraz przedstawia abstrakcje'),('flame4','2009-03-07',32,38,'Obraz przedstawia abstrakcje'),('Pejzaż miejski 8','2020-03-06',33,39,'Obraz przedstawia panorame'),('Eon','2014-03-19',34,40,'Obraz przedstawia abstrakcje'),('Staw w parku','2016-03-09',36,41,'Obraz przedstawia nature'),('Pejzaż samotna palma','1945-09-30',37,42,'Obraz przedstawia nature'),('Międzyplanetarny','2015-03-31',38,43,'Portret'),('Lady in red','1978-07-08',39,44,'Obraz przedstawia kobiete'),('Zalotna','1989-09-30',40,45,'Obraz przedstawia zwierze'),('Karii yook I','1980-09-08',41,46,'Obraz przedstawia abstrakcje'),('Utkane z traw XIX','1979-05-03',42,34,'Obraz przedstawia nature'),('Ponte du Corton','1976-05-05',43,35,'Portret'),('Pies','1996-04-03',44,33,'Obraz przedstawia zwierze');
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
INSERT INTO `eksponat_autor` VALUES (15,4),(11,5),(12,14),(13,3),(16,6),(17,7),(18,8),(19,9),(20,10),(22,10),(23,11),(24,12),(25,13),(26,14),(27,15),(28,4),(29,5),(30,15),(32,6),(33,15),(34,16),(36,17),(37,9),(38,10),(39,5),(40,6),(41,4),(42,10),(43,6),(44,15);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pracownik`
--

LOCK TABLES `pracownik` WRITE;
/*!40000 ALTER TABLE `pracownik` DISABLE KEYS */;
INSERT INTO `pracownik` VALUES (1,'Ewa','Chmura','Ewa',1),(2,'Karolina','Seler','Karolina',1),(3,'Hugon','Komorowski','Hugon',2),(4,'Mateusz','Bialy','Mateusz',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala`
--

LOCK TABLES `sala` WRITE;
/*!40000 ALTER TABLE `sala` DISABLE KEYS */;
INSERT INTO `sala` VALUES (1,1,45,1),(2,2,5,1),(3,3,100,1),(4,4,80,1),(5,1,30,2),(6,2,30,2),(7,1,90,3);
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
INSERT INTO `uzytkownik` VALUES ('bloondi','kamila86@onet.pl','bloondi'),('damian','dkwiatkowski@hotmail.co.uk','qwerty'),('Ewa','kochana@o2.pl','12345'),('Hugon','hug00@gmail.com','asdf'),('Jano','jankowal@gmail.com','s3r422'),('Karolina','karo@yahoo.com','zxcv'),('Katja','katiiiia@gmail.com','urururu'),('Mateusz','mmBon@gmail.com','koloru'),('T0m3k','tomasz@gmail.com','3333');
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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wystawa`
--

LOCK TABLES `wystawa` WRITE;
/*!40000 ALTER TABLE `wystawa` DISABLE KEYS */;
INSERT INTO `wystawa` VALUES (33,'Spotkanie pokoleń','2020-03-21','2020-07-11',1),(34,'Salon Akademii','2015-04-07','2015-09-12',1),(35,'Muzeum na strychu','2019-08-16','2021-01-31',2),(36,'Rysunek studentów','1993-12-05','2000-03-01',2),(37,'Inne  przestrzenie','2014-03-01','2017-05-05',1),(38,'Wystawa grafiki 4 artystów z Lahti','2018-06-01','2021-07-30',3),(39,'Komputerowe obrazy','2014-02-12','2015-03-21',3),(40,'W kręgu formy otwartej','2020-05-08','2020-12-06',3),(41,'W pracownika Jarnuszkiewicza','2007-11-04','2009-03-01',3),(42,'Współczesna rycina japoońska','1999-03-24','2001-12-11',3),(43,'Współczesna serigrafia włoska','1987-01-03','1989-03-01',4),(44,'Współczesny rysunek belgijski','2016-07-03','2017-06-05',4),(45,'Projekcje','2018-12-03','2019-04-06',4),(46,'Amsterdam tu!','2020-01-01','2020-05-01',4);
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
INSERT INTO `wystawa_sala` VALUES (1,33),(3,33),(4,34),(4,35),(2,36),(3,36),(1,37),(2,37),(3,37),(4,37),(6,38),(5,39),(6,39),(5,40),(6,41),(5,42),(7,43),(7,44),(7,45),(7,46);
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

-- Dump completed on 2020-06-10 18:00:55
