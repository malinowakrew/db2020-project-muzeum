-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 02 Cze 2020, 19:55
-- Wersja serwera: 10.4.11-MariaDB
-- Wersja PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `muezum_t`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `autor`
--

CREATE TABLE `autor` (
  `autorID` int(6) UNSIGNED NOT NULL,
  `imie` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `nazwisko` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `pseudonim` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bilet`
--

CREATE TABLE `bilet` (
  `biletID` int(6) UNSIGNED NOT NULL,
  `cena` float NOT NULL,
  `data_zakupu` date NOT NULL,
  `wystawaID` int(6) UNSIGNED DEFAULT NULL,
  `nazwa_uzytkownika` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `bilet`
--

INSERT INTO `bilet` (`biletID`, `cena`, `data_zakupu`, `wystawaID`, `nazwa_uzytkownika`) VALUES
(1, 12, '2020-05-14', 3, 'przyklad'),
(2, 12, '2020-05-13', 4, 'agatka23'),
(3, 12, '2020-05-04', 4, 'przyklad'),
(4, 40, '2019-03-05', 2, 'agatka23'),
(5, 40, '2019-03-05', 2, 'agatka23'),
(6, 34, '2020-05-30', 5, 'ed'),
(7, 50, '2020-05-30', 5, 'ed'),
(10, 50, '2020-06-02', 3, 'ed');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `budynek`
--

CREATE TABLE `budynek` (
  `budynekID` int(6) UNSIGNED NOT NULL,
  `nazwa` varchar(100) DEFAULT NULL,
  `adres` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `budynek`
--

INSERT INTO `budynek` (`budynekID`, `nazwa`, `adres`) VALUES
(1, 'Gmach główny', 'ul. Muzealna 17'),
(2, 'Biały Dworek', 'ul. Dworska 12');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cena`
--

CREATE TABLE `cena` (
  `cenaID` int(6) UNSIGNED NOT NULL,
  `typ` varchar(255) CHARACTER SET utf8 NOT NULL,
  `koszt` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `cena`
--

INSERT INTO `cena` (`cenaID`, `typ`, `koszt`) VALUES
(1, 'ulgowy', 12),
(2, 'normalny', 34),
(3, 'ulgowy - VIP', 50),
(4, 'normalny - VIP', 100);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cena_wystawa`
--

CREATE TABLE `cena_wystawa` (
  `cenaID` int(6) UNSIGNED DEFAULT NULL,
  `wystawaID` int(6) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `cena_wystawa`
--

INSERT INTO `cena_wystawa` (`cenaID`, `wystawaID`) VALUES
(3, 3),
(1, 3),
(2, 4),
(1, 4),
(3, 3),
(1, 3),
(2, 4),
(1, 4),
(1, 5),
(2, 5),
(3, 5),
(1, 30),
(3, 30),
(1, 31),
(2, 31),
(3, 31),
(4, 31),
(1, 32),
(2, 32);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `eksponat`
--

CREATE TABLE `eksponat` (
  `tytul` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `rok_powstania` date DEFAULT NULL,
  `eksponatID` int(6) UNSIGNED NOT NULL,
  `stylID` int(6) UNSIGNED DEFAULT NULL,
  `typID` int(6) UNSIGNED DEFAULT NULL,
  `wlascicielID` int(6) UNSIGNED DEFAULT NULL,
  `wystawaID` int(6) UNSIGNED DEFAULT NULL,
  `opis` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `eksponat`
--

INSERT INTO `eksponat` (`tytul`, `rok_powstania`, `eksponatID`, `stylID`, `typID`, `wlascicielID`, `wystawaID`, `opis`) VALUES
('Nie ma tytuły - jest biblioteka', '0000-00-00', 1, 5, NULL, NULL, 7, NULL),
('Żden', '2020-05-07', 2, 5, NULL, NULL, 6, NULL),
('nazwa', '1999-01-01', 3, NULL, NULL, NULL, NULL, 0x6e6965206d6fc5bc6e6120777972617a69c487207465676f2073c5826f77616d69),
('nazwa', '0001-01-01', 4, NULL, NULL, NULL, NULL, 0x31),
('muzeum', '0001-01-01', 5, NULL, NULL, NULL, NULL, 0x31),
('{nazwa}', '0000-00-00', 6, NULL, NULL, NULL, 6, 0x7b6f7069737d),
('4', '0004-04-04', 7, NULL, NULL, NULL, 6, 0x3434),
('4', '0004-04-04', 8, NULL, NULL, NULL, 6, 0x34),
('4', '0004-04-04', 9, NULL, NULL, NULL, 6, 0x34),
('3', '0003-03-03', 10, NULL, NULL, NULL, 3, 0x33);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `eksponat_autor`
--

CREATE TABLE `eksponat_autor` (
  `eksponatID` int(6) UNSIGNED DEFAULT NULL,
  `autorID` int(6) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownik`
--

CREATE TABLE `pracownik` (
  `pracownikID` int(6) UNSIGNED NOT NULL,
  `imie` varchar(20) CHARACTER SET utf8 NOT NULL,
  `nazwisko` varchar(20) CHARACTER SET utf8 NOT NULL,
  `nazwa` varchar(100) NOT NULL,
  `budynekID` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `pracownik`
--

INSERT INTO `pracownik` (`pracownikID`, `imie`, `nazwisko`, `nazwa`, `budynekID`) VALUES
(1, 'Jan', 'Żurek', 'przyklad', 2),
(2, 'Jan', 'Kamień', 'ed', 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `sala`
--

CREATE TABLE `sala` (
  `salaID` int(6) UNSIGNED NOT NULL,
  `numer` int(5) NOT NULL,
  `wielkosc` int(10) DEFAULT NULL,
  `budynekID` int(6) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `sala`
--

INSERT INTO `sala` (`salaID`, `numer`, `wielkosc`, `budynekID`) VALUES
(1, 1, 13, 2),
(2, 2, 5, 2),
(3, 1, 50, 1),
(4, 2, 8, 1),
(5, 3, 15, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownik`
--

CREATE TABLE `uzytkownik` (
  `nazwa` varchar(100) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 NOT NULL,
  `haslo` varchar(15) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `uzytkownik`
--

INSERT INTO `uzytkownik` (`nazwa`, `email`, `haslo`) VALUES
('agatka23', 'agatka23@gmail.com', 'brak123'),
('ed', 'zal', '123'),
('przyklad', 'nic@gmail.com', 'nic');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wystawa`
--

CREATE TABLE `wystawa` (
  `wystawaID` int(6) UNSIGNED NOT NULL,
  `nazwa` varchar(100) CHARACTER SET utf8 NOT NULL,
  `poczatek` date NOT NULL,
  `koniec` date NOT NULL,
  `pracownikID` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `wystawa`
--

INSERT INTO `wystawa` (`wystawaID`, `nazwa`, `poczatek`, `koniec`, `pracownikID`) VALUES
(2, 'Wojna', '2018-01-01', '2019-01-01', 1),
(3, 'Bal u Wyspiańskiego', '2020-01-01', '2020-12-01', 1),
(4, 'Impresjonizm realny', '2020-01-01', '2020-07-01', 1),
(5, 'Czarna dama', '2020-03-13', '2020-09-12', 1),
(6, 'czara owca', '1998-01-01', '1999-01-01', 1),
(7, 'misie', '1999-01-01', '1999-02-02', 1),
(8, '1', '0001-01-01', '0002-02-02', 1),
(9, 'ładne rzeczy ', '1999-01-01', '1999-12-12', 2),
(11, '199', '2011-11-11', '2012-12-12', 2),
(18, 'nazwa', '1999-01-01', '1999-12-12', 2),
(19, 'nazwa', '1999-01-01', '1999-12-12', 2),
(20, '12', '0009-09-09', '0010-09-09', 2),
(21, 'wystawa super jest ', '1970-01-01', '1971-01-01', 2),
(22, 'lol', '1200-12-12', '1201-12-12', 2),
(23, '1', '0001-01-01', '0001-01-01', 1),
(30, 'hehe', '0213-03-02', '0433-02-03', 2),
(31, 'best', '0055-03-04', '0066-01-03', 2),
(32, 'cyrk', '0001-01-01', '0002-02-02', 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wystawa_sala`
--

CREATE TABLE `wystawa_sala` (
  `salaID` int(6) UNSIGNED NOT NULL,
  `wystawaID` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `wystawa_sala`
--

INSERT INTO `wystawa_sala` (`salaID`, `wystawaID`) VALUES
(2, 3),
(1, 3),
(5, 3),
(2, 4),
(1, 18),
(1, 18),
(1, 20),
(2, 21),
(1, 22),
(1, 8),
(1, 30),
(2, 31),
(2, 32);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`autorID`);

--
-- Indeksy dla tabeli `bilet`
--
ALTER TABLE `bilet`
  ADD PRIMARY KEY (`biletID`),
  ADD KEY `bilet_wystawa` (`wystawaID`),
  ADD KEY `bilet_uzytkownik` (`nazwa_uzytkownika`);

--
-- Indeksy dla tabeli `budynek`
--
ALTER TABLE `budynek`
  ADD PRIMARY KEY (`budynekID`);

--
-- Indeksy dla tabeli `cena`
--
ALTER TABLE `cena`
  ADD PRIMARY KEY (`cenaID`);

--
-- Indeksy dla tabeli `cena_wystawa`
--
ALTER TABLE `cena_wystawa`
  ADD KEY `cena_wystawa` (`cenaID`),
  ADD KEY `wystawa_cena` (`wystawaID`);

--
-- Indeksy dla tabeli `eksponat`
--
ALTER TABLE `eksponat`
  ADD PRIMARY KEY (`eksponatID`),
  ADD KEY `styl` (`stylID`),
  ADD KEY `typ` (`typID`),
  ADD KEY `wlasciciel` (`wlascicielID`),
  ADD KEY `wystawa` (`wystawaID`);

--
-- Indeksy dla tabeli `eksponat_autor`
--
ALTER TABLE `eksponat_autor`
  ADD KEY `eksponat_autor` (`eksponatID`),
  ADD KEY `autor_eksponat` (`autorID`);

--
-- Indeksy dla tabeli `pracownik`
--
ALTER TABLE `pracownik`
  ADD PRIMARY KEY (`pracownikID`),
  ADD UNIQUE KEY `nazwa` (`nazwa`),
  ADD KEY `pracownik_budynek` (`budynekID`);

--
-- Indeksy dla tabeli `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`salaID`),
  ADD KEY `budynek_sala` (`budynekID`);

--
-- Indeksy dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD UNIQUE KEY `nazwa` (`nazwa`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indeksy dla tabeli `wystawa`
--
ALTER TABLE `wystawa`
  ADD PRIMARY KEY (`wystawaID`),
  ADD KEY `indeks` (`pracownikID`);

--
-- Indeksy dla tabeli `wystawa_sala`
--
ALTER TABLE `wystawa_sala`
  ADD KEY `wystawa_sala_1` (`wystawaID`),
  ADD KEY `sala_wystawa_1` (`salaID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `autor`
--
ALTER TABLE `autor`
  MODIFY `autorID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `bilet`
--
ALTER TABLE `bilet`
  MODIFY `biletID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT dla tabeli `budynek`
--
ALTER TABLE `budynek`
  MODIFY `budynekID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `cena`
--
ALTER TABLE `cena`
  MODIFY `cenaID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `eksponat`
--
ALTER TABLE `eksponat`
  MODIFY `eksponatID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT dla tabeli `pracownik`
--
ALTER TABLE `pracownik`
  MODIFY `pracownikID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `sala`
--
ALTER TABLE `sala`
  MODIFY `salaID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `wystawa`
--
ALTER TABLE `wystawa`
  MODIFY `wystawaID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `bilet`
--
ALTER TABLE `bilet`
  ADD CONSTRAINT `bilet_uzytkownik` FOREIGN KEY (`nazwa_uzytkownika`) REFERENCES `uzytkownik` (`nazwa`),
  ADD CONSTRAINT `bilet_wystawa` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`);

--
-- Ograniczenia dla tabeli `cena_wystawa`
--
ALTER TABLE `cena_wystawa`
  ADD CONSTRAINT `cena_wystawa` FOREIGN KEY (`cenaID`) REFERENCES `cena` (`cenaID`),
  ADD CONSTRAINT `wystawa_cena` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`);

--
-- Ograniczenia dla tabeli `eksponat`
--
ALTER TABLE `eksponat`
  ADD CONSTRAINT `wystawa` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`);

--
-- Ograniczenia dla tabeli `eksponat_autor`
--
ALTER TABLE `eksponat_autor`
  ADD CONSTRAINT `autor_eksponat` FOREIGN KEY (`autorID`) REFERENCES `autor` (`autorID`),
  ADD CONSTRAINT `eksponat_autor` FOREIGN KEY (`eksponatID`) REFERENCES `eksponat` (`eksponatID`);

--
-- Ograniczenia dla tabeli `pracownik`
--
ALTER TABLE `pracownik`
  ADD CONSTRAINT `pracownik_budynek` FOREIGN KEY (`budynekID`) REFERENCES `budynek` (`budynekID`),
  ADD CONSTRAINT `pracownik_uzytkownik` FOREIGN KEY (`nazwa`) REFERENCES `uzytkownik` (`nazwa`);

--
-- Ograniczenia dla tabeli `sala`
--
ALTER TABLE `sala`
  ADD CONSTRAINT `budynek_sala` FOREIGN KEY (`budynekID`) REFERENCES `budynek` (`budynekID`);

--
-- Ograniczenia dla tabeli `wystawa`
--
ALTER TABLE `wystawa`
  ADD CONSTRAINT `wystawa_pracownik` FOREIGN KEY (`pracownikID`) REFERENCES `pracownik` (`pracownikID`);

--
-- Ograniczenia dla tabeli `wystawa_sala`
--
ALTER TABLE `wystawa_sala`
  ADD CONSTRAINT `sala_wystawa_1` FOREIGN KEY (`salaID`) REFERENCES `sala` (`salaID`),
  ADD CONSTRAINT `wystawa_sala_1` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
