import os
import pymysql
from . import polaczenie

def wyszukiwarka_aktywnych_wystaw(dzis):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # wykonujemy zapytanie do bazy i wyświetlamy
            sql = f"SELECT nazwa, koniec FROM wystawa WHERE koniec > DATE '{dzis}' AND poczatek < DATE '{dzis}';"
            cursor.execute(sql)
            result = cursor.fetchall()

        connection.close()
        return result
    except:
        raise Exception("Błąd bazy")



def najczesciej_odwiedzane_wystawy(wybor, dzis):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # konstruujemy odpowiednie zapytania
            if(wybor == "nie"):
                sql2 = (
                    "SELECT wystawa.nazwa, wystawa.koniec, wystawa.poczatek, COUNT(bilet.biletID) "
                    "AS ilosc FROM wystawa JOIN bilet ON wystawa.wystawaID = bilet.wystawaID "
                    "GROUP BY wystawa.wystawaID ORDER BY ilosc DESC LIMIT 5;"
                )

            elif(wybor == "tak"):
                sql2 = (
                    f"SELECT wystawa.nazwa, wystawa.koniec, wystawa.poczatek, COUNT(bilet.biletID) AS ilosc "
                    f"FROM wystawa JOIN bilet ON wystawa.wystawaID = bilet.wystawaID "
                    f"WHERE DATE '{dzis}' BETWEEN wystawa.poczatek AND wystawa.koniec "
                    f"GROUP BY wystawa.wystawaID ORDER BY ilosc DESC LIMIT 5;"
                )

            else:
                raise Exception("Niepoprawnie wpisany tekst")

            cursor.execute(sql2)
            result = cursor.fetchall()

        connection.close()
        return result
    except:
        raise Exception("Błąd bazy")


def dodaj_wystawe(nazwa, poczatek, zakonczenie, pracownik):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # dodajemy do tablicy Wystawa
            sql = (
                f"INSERT INTO wystawa (nazwa, poczatek, koniec, pracownikID) " 
                f" VALUES('{nazwa}', '{poczatek}' ,'{zakonczenie}', {pracownik});"
            )
            cursor.execute(sql)
            connection.commit()

            sql2 = (
                f"UPDATE TABLE sala "
                f"SET sala.wystawaID = '{wystawaID}'"
            )
            connection.close()
        return 1
    except:
        raise Exception("Błąd bazy")






