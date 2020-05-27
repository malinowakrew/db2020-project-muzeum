import os
import pymysql
from . import polaczenie


def pokaz_sale(budynek):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # wykonujemy zapytanie do bazy
            sql = f"SELECT sala.numer FROM sala " \
                  f"WHERE sala.budynekID = {budynek} AND sala.wystawaID IS NULL"
            cursor.execute(sql)
            result = cursor.fetchall()
        connection.close()
        return result
    except:
        raise Exception("Błąd bazy")


def dodaj_wystawe(wystawa, sala, budynek):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = f"UPDATE sala SET sala.wystawaID= (SELECT wystawaID from wystawa where wystawa.nazwa='{wystawa}')" \
                  f" WHERE sala.numer = {sala} AND sala.budynekID = {budynek} "
            cursor.execute(sql)
            connection.commit()
        connection.close()
        return 1
    except:
        raise Exception("Błąd bazy")


def wielkosc_wystawy(dzis):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = (
                f"SELECT COUNT(eksponat.eksponatID) as ilosc_eksponatow, SUM(sala.wielkosc) as wielkosc, wystawa.nazwa "
                f"FROM eksponat JOIN wystawa ON wystawa.wystawaID = eksponat.wystawaID "
                f"JOIN sala ON sala.wystawaID = wystawa.wystawaID "
                f"WHERE wystawa.koniec < DATE '{dzis}'"
                f"GROUP BY wystawa.wystawaID"
            )
            cursor.execute(sql)
            result = cursor.fetchall()
        connection.close()
        return result
    except Exception as błąd:
        raise Exception(błąd)
