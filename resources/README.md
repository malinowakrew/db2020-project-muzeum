# Muzeum 

| Nazwisko i imię | Wydział | Kierunek | Semestr | Grupa | Rok akademicki |
|:---------------:|:-------:|:--------:|:-------:|:-----:|:--------------:|
| Tycjan Woronko  |  WIMiIP |    IS    |    4    |   4   |    2019/2020   |
|  Edyta Mróz     |  WIMiIP |    IS    |    4    |   3   |    2019/2020   |

### Spis treści

[Projekt bazy danych](#projekt-bazy-danych)

[Implementacja zapytań sql](#implementacja-zapytań-sql)

[Aplikacja](#aplikacja)

[Dodatkowe uwagi](#dodatkowe-uwagi)

## Projekt bazy danych

### Schemat ERD

![baza](https://github.com/phajder-databases/db2020-project-muzeum/blob/readme/resources/muzeum_schemat_projektu.svg)

### Zapytania DDL

Dodawanie eksponatów
```sql
INSERT INTO eksponat (tytul, rok_powstania, opis, wystawaID) VALUES('{nazwa}', '{poczatek}', '{opis}',
(SELECT wystawa.wystawaID FROM wystawa WHERE wystawa.nazwa = '{wystawa_nazwa}'));
```

Dodawanie autora
```sql
INSERT INTO autor(imie, nazwisko, pseudonim) VALUES('{imie}', '{nazwisko}', '{pseudonim}');
```

Dodawanie użytkownika
```sql
INSERT INTO uzytkownik VALUES('{nazwa}', '{email}' ,'{haslo}');
```

Dodawanie sali
```sql
INSERT INTO wystawa_sala(salaID, wystawaID) VALUES ({sala}, {wystawa});
```

Dodawanie biletu 
```sql
INSERT INTO bilet (cena, data_zakupu, wystawaID, nazwa_uzytkownika) 
VALUES({cena}, '{data}' , (SELECT wystawaID FROM wystawa WHERE nazwa = '{wystawa}') , '{nazwa}' );
```

Usuwanie biletu 
```sql
DELETE bilet FROM bilet INNER JOIN wystawa on wystawa.wystawaID=bilet.wystawaID
WHERE bilet.data_zakupu='{data}' AND wystawa.nazwa='{nazwa}' AND nazwa_uzytkownika='{uzytkownik}';
```

Dodawanie wystawy
```sql
INSERT INTO wystawa (nazwa, poczatek, koniec, pracownikID) 
VALUES('{nazwa}', '{poczatek}' ,'{zakonczenie}', {pracownik});
```
```sql
INSERT INTO wystawa_sala(salaID, wystawaID) VALUES ({salaID}, {result});
```


## Implementacja zapytań SQL

### Użytkownik
1. Zalogowanie
```sql
SELECT uzytkownik.nazwa, uzytkownik.email 
FROM uzytkownik 
WHERE uzytkownik.nazwa = '{login}' AND uzytkownik.haslo = '{haslo}';
```

2. Pokazanie aktywnych wystaw (w dniu logowania)
```sql
SELECT wystawa.nazwa, wystawa.koniec FROM wystawa WHERE wystawa.koniec > DATE '{dzis}' AND wystawa.poczatek < DATE '{dzis}';
```

3. Pokazanie rankingu wystaw (popularność jest liczona ilością kupionych biletów na daną wystawę).

a) wszystkie wystawy
```sql
SELECT wystawa.nazwa, wystawa.koniec, wystawa.poczatek, COUNT(bilet.biletID) 
AS ilosc FROM wystawa JOIN bilet ON wystawa.wystawaID = bilet.wystawaID 
GROUP BY wystawa.wystawaID ORDER BY ilosc DESC LIMIT 5;
```
b) tylko aktywne wystawy
```sql
SELECT wystawa.nazwa, wystawa.koniec, wystawa.poczatek, COUNT(bilet.biletID) AS ilosc 
FROM wystawa JOIN bilet ON wystawa.wystawaID = bilet.wystawaID
WHERE DATE '{dzis}' BETWEEN wystawa.poczatek AND wystawa.koniec 
GROUP BY wystawa.wystawaID ORDER BY ilosc DESC LIMIT 5;
```

4. Sprawdzenie ceny biletów na daną wystawę
```sql
SELECT DISTINCT wystawa.nazwa, cena.typ, cena.koszt 
FROM wystawa JOIN cena_wystawa ON wystawa.wystawaID = cena_wystawa.wystawaID 
JOIN cena ON cena.cenaID = cena_wystawa.cenaID 
WHERE wystawa.nazwa = '{nazwa_wystawy}';
```

5. Sprawdzenie na jakich wystawach występują dzieła autorów
```sql
SELECT autor.{typ}, wystawa.nazwa FROM autor 
JOIN eksponat_autor ON autor.autorID = eksponat_autor.autorID 
JOIN eksponat ON eksponat.eksponatID = eksponat_autor.eksponatID               
JOIN wystawa ON eksponat.wystawaID = wystawa.wystawaID 
WHERE autor.{typ}='{nazwa}';
```

6. Wyświetlanie informacji o eksponatach i ich autorach z danej wystawy
```sql
SELECT eksponat.tytul, eksponat.rok_powstania, eksponat.opis, autor.imie, autor.nazwisko, autor.pseudonim
FROM eksponat 
JOIN eksponat_autor ON eksponat_autor.eksponatID = eksponat.eksponatID 
JOIN autor ON autor.autorID = eksponat_autor.autorID 
LEFT JOIN wystawa ON eksponat.wystawaID = wystawa.wystawaID 
WHERE wystawa.nazwa = '{nazwa}';
```

7. Sprawdzenie zakupionych biletów danego użytkownika na wystawy, które jeszcze się nie zakończyły (tak aby zwrot biletu mógł być możliwy).
```sql
SELECT bilet.data_zakupu, wystawa.nazwa 
FROM wystawa JOIN bilet ON wystawa.wystawaID = bilet.wystawaID 
WHERE wystawa.koniec > DATE '{dzis}' AND nazwa_uzytkownika='{uzytkownik}';
```

### Pracownik

1. Sprawdzanie maksymalnej ilości miejsca w salach należących do wystawy
```sql
SELECT SUM(sala.wielkosc) as wielkosc_wystawy, wystawa.nazwa FROM wystawa 
LEFT JOIN wystawa_sala ON wystawa_sala.wystawaID = wystawa.wystawaID 
LEFT JOIN sala ON sala.salaID = wystawa_sala.salaID 
GROUP BY wystawa.wystawaID;
```

2. Sprawdzanie ilości dodanych eksponatów
```sql
SELECT COUNT(eksponat.eksponatID) as ilosc_eksponatow, wystawa.nazwa FROM eksponat 
LEFT JOIN wystawa ON wystawa.wystawaID = eksponat.wystawaID GROUP BY wystawa.wystawaID;
```

3. Pokazanie dostępnych sal w czasie kiedy ma mieć miejsce dana wystawa
```sql
SELECT sala.numer, sala.wielkosc, sala.salaID FROM sala 
WHERE sala.salaID NOT IN 
( SELECT sala.salaID FROM budynek 
INNER JOIN sala ON budynek.budynekID = sala.budynekID 
LEFT JOIN wystawa_sala ON sala.salaID = wystawa_sala.salaID
LEFT JOIN wystawa ON wystawa_sala.wystawaID = wystawa.wystawaID 
WHERE (budynek.budynekID = {budynekID} AND 
((DATE '{poczatek}' BETWEEN wystawa.poczatek AND wystawa.koniec) OR 
(DATE '{koniec}' BETWEEN wystawa.poczatek AND wystawa.koniec))) OR 
( budynek.budynekID != {budynekID}));
```

4. Sprawdzenie dokładnej ilości sprzedanych biletów
```sql
SELECT COUNT(bilet.biletID) as ilosc, wystawa.nazwa 
FROM bilet 
JOIN wystawa ON wystawa.wystawaID = bilet.wystawaID 
JOIN pracownik ON pracownik.pracownikID = wystawa.pracownikID 
JOIN budynek ON budynek.budynekID = pracownik.budynekID 
WHERE budynek.budynekID = {budynekID} 
GROUP BY wystawa.nazwa 
ORDER BY ilosc;
```

5. Sprawdzanie ilości sprzedanych biletów na daną wystawę w dniu logowania pracownika. 
Dodatkowo sprawdzany jest budynek-oddiał muzeum, gdzie znajduje się wystawa oraz suma zarobionych przez muzeum pieniędzy za sprzedane bilety.
```sql
SELECT COUNT(bilet.biletID) as ilosc, SUM(bilet.cena) as zarobki, wystawa.nazwa, 
budynek.nazwa as budynek, budynek.budynekID 
FROM bilet LEFT 
JOIN wystawa ON wystawa.wystawaID = bilet.wystawaID 
LEFT JOIN pracownik ON pracownik.pracownikID = wystawa.pracownikID 
LEFT JOIN budynek ON budynek.budynekID = pracownik.budynekID 
WHERE bilet.data_zakupu = DATE '{dzien}' 
GROUP BY budynek.nazwa, wystawa.nazwa
```

6. Sprawdzanie autorów, którzy mają najwięcej dzieł na wystawach w muzeum (także w przeszłości) oraz wyświetlenie ich liczby.
```sql
SELECT autor.nazwisko, autor.imie, COUNT(eksponat_autor.eksponatID) 
AS ilosc FROM autor JOIN eksponat_autor ON autor.autorID = eksponat_autor.autorID 
GROUP BY autor.autorID ORDER BY autor.nazwisko;
```
7. Wyszukanie danych pracownika podczas logowania
```sql
SELECT pracownik.imie, pracownik.nazwisko, pracownik.pracownikID, pracownik.budynekID 
FROM pracownik 
JOIN uzytkownik ON pracownik.nazwa = uzytkownik.nazwa 
WHERE uzytkownik.nazwa = '{login}';
```

## Aplikacja

Z aplikacji mogą korzystać: osoby niezarejestrowane, użytkownicy z kontem, pracownicy z kontem pracowniczym i zwykłym.

#### Przykładowe dane logowania     

| typ        | login    | hasło  |
|:----------:|:--------:|:------:|
| Pracownik  | Karolina | zxcv   |
| Użytkownik | bloondi  | bloondi|

### Niezalogowany

1. Może przeglądać aktywne wystawy (tylko ich nazwy i data zamknięcia wystawy)
2. Może wyświetlić TOP 5 popularnych wystaw. W zależności od wyboru może być to 5 najbardziej popularnych wystaw w ogóle albo tylko tych, które są aktywne.

### Zalogowany użytkownik

Wszystko to co użytkownik niezalogowany oraz dodatkowo:

1. Przy przeglądaniu aktywnych wystaw może zobaczyć ekspnaty z wybranej przez siebie wystawy, wraz z ich opisem, autorem i datą powstania.
2. Możliwość zakupu biletu na daną wystawę.
3. Możliwość zwrotu biletu jeśli wystawa jest jeszcze aktualna.
4. Wyszukanie wystaw na których możemy prace wybranego przez nas autora.

### Zalogowany pracownik

1. Dodawanie wystawy:
a) Nadanie nazwy i ram czasowych
b) Sprawdzenie wolnych sal w wybranych ramach czasowych. Wybór sal.
c) Wybór typu dostępnych biletów

2. Dodawanie eksponatu:
a) Nadanie atrybutów (nazwy, opisu itd)
b) Wybieranie autora dzieła. Jeśli taki autor już istnieje tworzone jest nowe połączenie wiele do wielu. Jeśli nie istnieje tworzony jest nowy autor.
c) Wybór wystawy do jakiej będzie należeć dzieło. Sprawdzenie czy maksymalna ilość miejsca w salach, w których odbywa się wystawa, pozwala na dodanie nowego eksponatu.

3. Statystyki zwiedzania - liczba wszystkich kupionych biletów na daną wystawę
4. Statystyki dzienne - wykres wszystkich kupionych biletów w dniu logowania pracownika. Suma jaką zarobiło muzeum za sprzedane bilety. 
5. Dodawanie autora
6. Zbadanie autorów - wyświetlenie wszystkich autorów oraz ilości dzieł jakie mają. 

## Dodatkowe uwagi
Nie wszystkie zaplanowane funkcjonalności zostały przedstawione w aktualnej wersji aplikacji. Spowodowane jest to złożonością operacji w samej aplikacji jakie trzeba by było w tym celu zrealizować, a jednocześnie powtarzalnością i przeciętnością potrzebnym ku temu zapytań. Wybrano taki rodzaj funkcjonalności aby przestawić możliwie najciekawsze, złożone, a jednocześnie użyteczne zapytania sql.
