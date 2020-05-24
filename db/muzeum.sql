-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 24 Maj 2020, 21:05
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

--
-- Zrzut danych tabeli `bilet`
--

INSERT INTO `bilet` (`biletID`, `cena`, `data_zakupu`, `zakupiony`, `wystawaID`, `nazwa_uzytkownika`) VALUES
(1, 12, '2020-05-14', b'1', 3, 'przyklad'),
(2, 12, '2020-05-13', b'1', 4, 'agatka23'),
(3, 12, '2020-05-04', b'1', 4, 'przyklad'),
(4, 40, '2019-03-05', b'1', 2, 'agatka23'),
(5, 40, '2019-03-05', b'1', 2, 'agatka23');

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
(2, 'normalny - wystawy stałe', 34),
(3, 'normalny -wystawy czasowe', 50);

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
(1, 4);

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
(1, 'Jan', 'Żurek', 'przyklad', 2);

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

--
-- Zrzut danych tabeli `sala`
--

INSERT INTO `sala` (`salaID`, `numer`, `wielkosc`, `wystawaID`, `budynekID`) VALUES
(1, 1, 13, NULL, 2),
(2, 2, 5, NULL, 2),
(3, 1, 50, NULL, 1),
(4, 2, 8, NULL, 1),
(5, 3, 15, NULL, 1);

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

--
-- Zrzut danych tabeli `uzytkownik`
--

INSERT INTO `uzytkownik` (`nazwa`, `email`, `haslo`) VALUES
('agatka23', 'agatka23@gmail.com', 'brak123'),
('przyklad', 'nic@gmail.com', 'nic');

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
(8, '1', '0001-01-01', '0002-02-02', 1);

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
  ADD PRIMARY KEY (`wystawaID`),
  ADD KEY `indeks` (`pracownikID`);

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
  MODIFY `biletID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `budynek`
--
ALTER TABLE `budynek`
  MODIFY `budynekID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `cena`
--
ALTER TABLE `cena`
  MODIFY `cenaID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `eksponat`
--
ALTER TABLE `eksponat`
  MODIFY `eksponatID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `pracownik`
--
ALTER TABLE `pracownik`
  MODIFY `pracownikID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `sala`
--
ALTER TABLE `sala`
  MODIFY `salaID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `wystawaID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
-- Ograniczenia dla tabeli `pracownik`
--
ALTER TABLE `pracownik`
  ADD CONSTRAINT `pracownik_budynek` FOREIGN KEY (`budynekID`) REFERENCES `budynek` (`budynekID`),
  ADD CONSTRAINT `pracownik_uzytkownik` FOREIGN KEY (`nazwa`) REFERENCES `uzytkownik` (`nazwa`);

--
-- Ograniczenia dla tabeli `sala`
--
ALTER TABLE `sala`
  ADD CONSTRAINT `budynek_sala` FOREIGN KEY (`budynekID`) REFERENCES `budynek` (`budynekID`),
  ADD CONSTRAINT `wystawa_sala` FOREIGN KEY (`wystawaID`) REFERENCES `wystawa` (`wystawaID`);

--
-- Ograniczenia dla tabeli `wystawa`
--
ALTER TABLE `wystawa`
  ADD CONSTRAINT `wystawa_pracownik` FOREIGN KEY (`pracownikID`) REFERENCES `pracownik` (`pracownikID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
