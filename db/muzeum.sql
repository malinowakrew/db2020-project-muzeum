-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 17 Maj 2020, 17:24
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
-- Baza danych: `muzeum`
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
  `zakupiony` bit(1) NOT NULL,
  `wystawaID` int(6) UNSIGNED DEFAULT NULL,
  `nazwa_uzytkownika` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `budynek`
--

CREATE TABLE `budynek` (
  `budynekID` int(6) UNSIGNED NOT NULL,
  `nazwa` varchar(100) DEFAULT NULL,
  `adres` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cena`
--

CREATE TABLE `cena` (
  `cenaID` int(6) UNSIGNED NOT NULL,
  `typ` varchar(255) CHARACTER SET utf8 NOT NULL,
  `koszt` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cena_wystawa`
--

CREATE TABLE `cena_wystawa` (
  `cenaID` int(6) UNSIGNED DEFAULT NULL,
  `wystawaID` int(6) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Struktura tabeli dla tabeli `sala`
--

CREATE TABLE `sala` (
  `salaID` int(6) UNSIGNED NOT NULL,
  `numer` int(5) NOT NULL,
  `wielkosc` int(10) DEFAULT NULL,
  `wystawaID` int(6) UNSIGNED DEFAULT NULL,
  `budynekID` int(6) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `styl`
--

CREATE TABLE `styl` (
  `stylID` int(6) UNSIGNED NOT NULL,
  `nazwa_stylu` varchar(50) CHARACTER SET utf8 NOT NULL,
  `opis` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `styl`
--

INSERT INTO `styl` (`stylID`, `nazwa_stylu`, `opis`) VALUES
(4, 'nic', 0x6e6963),
(5, 'nic', 0x6e6963),
(6, 'nic', 0x6e6963),
(7, 'nic', 0x6e6963),
(8, 'nic', 0x6e6963);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `typ`
--

CREATE TABLE `typ` (
  `typID` int(6) UNSIGNED NOT NULL,
  `nazwa_typu` varchar(50) CHARACTER SET utf8 NOT NULL,
  `opis` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownik`
--

CREATE TABLE `uzytkownik` (
  `nazwa` varchar(100) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 NOT NULL,
  `haslo` varchar(15) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wlasciciel`
--

CREATE TABLE `wlasciciel` (
  `wlascicielID` int(6) UNSIGNED NOT NULL,
  `kontakt` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `nazwa` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `anonimowy` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wystawa`
--

CREATE TABLE `wystawa` (
  `wystawaID` int(6) UNSIGNED NOT NULL,
  `nazwa` varchar(100) CHARACTER SET utf8 NOT NULL,
  `poczatek` date NOT NULL,
  `koniec` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Indeksy dla tabeli `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`salaID`),
  ADD KEY `budynek_sala` (`budynekID`),
  ADD KEY `wystawa_sala` (`wystawaID`);

--
-- Indeksy dla tabeli `styl`
--
ALTER TABLE `styl`
  ADD PRIMARY KEY (`stylID`);

--
-- Indeksy dla tabeli `typ`
--
ALTER TABLE `typ`
  ADD PRIMARY KEY (`typID`);

--
-- Indeksy dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD UNIQUE KEY `nazwa` (`nazwa`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indeksy dla tabeli `wlasciciel`
--
ALTER TABLE `wlasciciel`
  ADD PRIMARY KEY (`wlascicielID`);

--
-- Indeksy dla tabeli `wystawa`
--
ALTER TABLE `wystawa`
  ADD PRIMARY KEY (`wystawaID`);

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
  MODIFY `biletID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `budynek`
--
ALTER TABLE `budynek`
  MODIFY `budynekID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `cena`
--
ALTER TABLE `cena`
  MODIFY `cenaID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `eksponat`
--
ALTER TABLE `eksponat`
  MODIFY `eksponatID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `sala`
--
ALTER TABLE `sala`
  MODIFY `salaID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `styl`
--
ALTER TABLE `styl`
  MODIFY `stylID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `typ`
--
ALTER TABLE `typ`
  MODIFY `typID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `wlasciciel`
--
ALTER TABLE `wlasciciel`
  MODIFY `wlascicielID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `wystawa`
--
ALTER TABLE `wystawa`
  MODIFY `wystawaID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `styl` FOREIGN KEY (`stylID`) REFERENCES `styl` (`stylID`),
  ADD CONSTRAINT `typ` FOREIGN KEY (`typID`) REFERENCES `typ` (`typID`),
  ADD CONSTRAINT `wlasciciel` FOREIGN KEY (`wlascicielID`) REFERENCES `wlasciciel` (`wlascicielID`),
  ADD CONSTRAINT `wystawa` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`);

--
-- Ograniczenia dla tabeli `eksponat_autor`
--
ALTER TABLE `eksponat_autor`
  ADD CONSTRAINT `autor_eksponat` FOREIGN KEY (`autorID`) REFERENCES `autor` (`autorID`),
  ADD CONSTRAINT `eksponat_autor` FOREIGN KEY (`eksponatID`) REFERENCES `eksponat` (`eksponatID`);

--
-- Ograniczenia dla tabeli `sala`
--
ALTER TABLE `sala`
  ADD CONSTRAINT `budynek_sala` FOREIGN KEY (`budynekID`) REFERENCES `budynek` (`budynekID`),
  ADD CONSTRAINT `wystawa_sala` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
