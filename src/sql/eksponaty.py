import os
import pymysql


def polaczenie():
    connection = pymysql.connect(
        host='localhost',
        # user=os.getenv("DB_USERNAME"),
        user="root",
        # password=os.getenv("DB_PASSWORD"),
        #password="admin1",
        database="muzeum",
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )
    return connection

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