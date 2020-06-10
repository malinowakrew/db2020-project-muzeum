# Muzeum 

| Nazwisko i imię | Wydział | Kierunek | Semestr | Grupa | Rok akademicki |
|:---------------:|:-------:|:--------:|:-------:|:-----:|:--------------:|
| Tycjan Woronko  |  WIMiIP |    IS    |    4    |   4   |    2019/2020   |
|  Edyta Mróz     |  WIMiIP |    IS    |    4    |   3   |    2019/2020   |

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

2. Sprawdzanie maksymalnej ilości miejsca w salach należących do wystawy
``sql
SELECT SUM(sala.wielkosc) as wielkosc_wystawy, wystawa.nazwa FROM wystawa 
LEFT JOIN wystawa_sala ON wystawa_sala.wystawaID = wystawa.wystawaID 
LEFT JOIN sala ON sala.salaID = wystawa_sala.salaID 
GROUP BY wystawa.wystawaID;
```

3. Sprawdzanie ilości dodanych eksponatów
```sql
SELECT COUNT(eksponat.eksponatID) as ilosc_eksponatow, wystawa.nazwa FROM eksponat 
LEFT JOIN wystawa ON wystawa.wystawaID = eksponat.wystawaID GROUP BY wystawa.wystawaID;
```

4. Pokazanie dostępnych sal w czasie kiedy ma mieć miejsce dana wystawa
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

5. Pokazanie aktywnych wystaw (w dniu logowania)
```sql
SELECT nazwa, koniec FROM wystawa WHERE koniec > DATE '{dzis}' AND poczatek < DATE '{dzis}';
```

6. Pokazanie rankingu wystaw (popularność jest liczona ilością kupionych biletów na daną wystawę).
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

7. Sprawdzenie ceny biletów na daną wystawę
```sql
SELECT DISTINCT wystawa.nazwa, cena.typ, cena.koszt 
FROM wystawa JOIN cena_wystawa ON wystawa.wystawaID = cena_wystawa.wystawaID 
JOIN cena ON cena.cenaID = cena_wystawa.cenaID 
WHERE wystawa.nazwa = '{nazwa_wystawy}';
```

### Pracownik

1. Wyszukanie danych pracownika podczas logowania



2. Dodaj wystawę
3. Dodaj eksponat
4. Pokaż statystyki zwiedzania
5. Dodaj autora

