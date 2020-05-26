import os
import pymysql
from . import polaczenie


def zaloguj(login, haslo):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql3 = (
                f"SELECT uzytkownik.nazwa, uzytkownik.email "
                f"FROM uzytkownik "
                f"WHERE uzytkownik.nazwa = '{login}' AND uzytkownik.haslo = '{haslo}';"
            )
            cursor.execute(sql3)
            result = cursor.fetchall()
            connection.close()
            return result
    except:
        raise Exception("Błąd bazy")


def dane_pracownika(login):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql3 = (
                f"SELECT pracownik.imie, pracownik.nazwisko, pracownik.pracownikID, pracownik.budynekID "
                f"FROM pracownik "
                f"JOIN uzytkownik ON pracownik.nazwa = uzytkownik.nazwa "
                f"WHERE uzytkownik.nazwa = '{login}';"
            )

            cursor.execute(sql3)
            result = cursor.fetchall()
            connection.close()
            return result
    except:
        raise Exception("Błąd bazy")


def powtorzenie(parametr,wartosc):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = f"SELECT 1 FROM uzytkownik WHERE uzytkownik.{parametr}='{wartosc}'; "
            cursor.execute(sql)
            result = cursor.fetchall()
            connection.close()
            return result
    except:
        raise Exception("Błąd bazy")


def dodaj_uzytkownika(email, nazwa, haslo):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # dodajemy do tablicy Uzytkownicy
            sql = (
                f"INSERT INTO uzytkownik " 
                f" VALUES('{nazwa}', '{email}' ,'{haslo}');"
            )
            cursor.execute(sql)
            connection.commit()
            connection.close()
        return 1
    except:
        raise Exception("Błąd bazy")
