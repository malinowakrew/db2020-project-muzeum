import os
import pymysql
from . import polaczenie

def dodaj_eksponat(nazwa, poczatek, opis, wystawa_nazwa):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # dodajemy do tablicy Eksponat
            sql = (f"INSERT INTO eksponat (tytul, rok_powstania, opis, wystawaID) VALUES('{nazwa}', '{poczatek}', '{opis}', "
                   f"(SELECT wystawa.wystawaID FROM wystawa WHERE wystawa.nazwa = '{wystawa_nazwa}'));"
                   )
            cursor.execute(sql)
            connection.commit()
        connection.close()
        return 1
    except Exception as błąd:
        raise Exception(błąd)


