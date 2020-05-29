import os
import pymysql
from . import polaczenie


def pokaz_dostepne_sale(budynekID, poczatek, koniec):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # wykonujemy zapytanie do bazy
            sql = (
                f"SELECT sala.numer, sala.wielkosc, sala.salaID FROM sala "
                f"WHERE sala.salaID NOT IN "
                f"( SELECT sala.salaID FROM budynek "
                f"INNER JOIN sala ON budynek.budynekID = sala.budynekID "
                f"LEFT JOIN wystawa_sala ON sala.salaID = wystawa_sala.salaID "
                f"LEFT JOIN wystawa ON wystawa_sala.wystawaID = wystawa.wystawaID "
                f"WHERE (budynek.budynekID = {budynekID} AND "
                f"((DATE '{poczatek}' BETWEEN wystawa.poczatek AND wystawa.koniec) OR "
                f"(DATE '{koniec}' BETWEEN wystawa.poczatek AND wystawa.koniec))) OR "
                f"( budynek.budynekID != {budynekID}));"
            )

            #sql = f"SELECT sala.numer FROM sala " \
            #f"WHERE sala.budynekID = {budynek} AND sala.wystawaID IS NULL"

            cursor.execute(sql)
            result = cursor.fetchall()
        connection.close()
        return result
    except Exception as błąd:
        raise Exception(f"Błąd bazy \n Swojemu programiście powiedz: {błąd}")


def dodaj_wystawe(wystawa, sala, budynek):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = f"INSERT INTO wystawa_sala(salaID, wystawaID) VALUES ({sala}, {wystawa})"
            """
            sql = f"UPDATE sala SET sala.wystawaID = (SELECT wystawaID from wystawa where wystawa.nazwa='{wystawa}')" \
                  f" WHERE sala.numer = {sala} AND sala.budynekID = {budynek} "
            """
            cursor.execute(sql)
            connection.commit()
        connection.close()
        return 1
    except Exception as błąd:
        raise Exception(błąd)


def wielkosc_wystawy(dzis):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = (
                f"SELECT COUNT(eksponat.eksponatID) as ilosc_eksponatow, SUM(sala.wielkosc) as wielkosc, wystawa.nazwa "
                f"FROM eksponat JOIN wystawa ON wystawa.wystawaID = eksponat.wystawaID "
                f"INNER JOIN wystawa_sala ON wystawa_sala.wystawaID = wystawa.wystawaID"
                f"JOIN sala ON sala.salaID = wystawa_sala.salaID "
                f"WHERE wystawa.koniec < DATE '{dzis}'"
                f"GROUP BY wystawa.wystawaID"
            )
            cursor.execute(sql)
            result = cursor.fetchall()
        connection.close()
        return result
    except Exception as błąd:
        raise Exception(błąd)
