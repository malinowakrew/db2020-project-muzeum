# Muzeum 

| Nazwisko i imię | Wydział | Kierunek | Semestr | Grupa | Rok akademicki |
|:---------------:|:-------:|:--------:|:-------:|:-----:|:--------------:|
| Tycjan Woronko  |  WIMiIP |    IS    |    4    |   4   |    2019/2020   |
|  Edyta Mróz     |  WIMiIP |    IS    |    4    |   3   |    2019/2020   |

## Projekt bazy danych

### Schemat ERD

### Zapytania DDL

Dodawanie eksponatów
```sql
INSERT INTO eksponat (tytul, rok_powstania, opis, wystawaID) VALUES('{nazwa}', '{poczatek}', '{opis}',
(SELECT wystawa.wystawaID FROM wystawa WHERE wystawa.nazwa = '{wystawa_nazwa}'));
```

## Implementacja zapytań SQL

