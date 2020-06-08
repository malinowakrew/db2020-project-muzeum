import os
import pymysql
from . import polaczenie

def dodaj_autora_doeksponatu(eksponatID, autorID, imie, nazwisko, pseudonim):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql2 = (
                f"SELECT autor.pseudonim FROM autor"
            )
            cursor.execute(sql2)
            autorzy= cursor.fetchall()

            if pseudonim in autorzy:
                pass

            else:
                sql = (
                    f"INSERT INTO eksponat_autor(eksponatID, autorID) VALUES({eksponatID}, {autorID})"
                )

            cursor.execute(sql)
            connection.commit()
        connection.close()
        return 1
    except Exception as błąd:
        raise Exception(błąd)

def dodaj_autora(imie, nazwisko, pseudonim):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = (
                f"INSERT INTO autor(imie, nazwisko, pseudonim) VALUES({imie}, {nazwisko}, {pseudonim})"
                   )
            cursor.execute(sql)
            connection.commit()
        connection.close()
        return 1
    except Exception as błąd:
        raise Exception(błąd)


def dziela_autorow():
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = (
                "SELECT autor.nazwisko, autor.imie, COUNT(eksponat_autor.eksponatID) "
                "AS ilosc FROM autor JOIN eksponat_autor ON autor.autorID = eksponat_autor.autorID "
                "GROUP BY autor.autorID ORDER BY autor.nazwisko LIMIT 5;"
                   )
            cursor.execute(sql)
            result = cursor.fetchall()
        connection.close()
        return result
    except:
        raise Exception("Błąd bazy")

def szukaj_autora(typ,nazwa):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = (
                f"SELECT autor.{typ}, wystawa.nazwa FROM autor "
                f"JOIN eksponat_autor ON autor.autorID = eksponat_autor.autorID "
                f"JOIN eksponat ON eksponat.eksponatID = eksponat_autor.eksponatID "                
                f"JOIN wystawa ON eksponat.wystawaID = wystawa.wystawaID "
                f"WHERE autor.{typ}='{nazwa}';"
                   )
            cursor.execute(sql)
            result = cursor.fetchall()
        connection.close()
        return result
    except:
        raise Exception("Błąd bazy")