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

