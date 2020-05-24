import os
import pymysql
from . import polaczenie

def dodaj_eksponat(nazwa,poczatek,opis):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # dodajemy do tablicy Eksponat
            sql = f"INSERT INTO eksponat (tytul,rok_powstania,opis) VALUES(%s, '{poczatek}', '{opis}')"
            cursor.execute(sql, nazwa)
            connection.commit()
    except EOFError:
        raise Exception("Błąd bazy")
    finally:
        return 1
        connection.close()