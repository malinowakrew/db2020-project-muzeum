import os
import pymysql

def kolumny():
    connection = pymysql.connect(
        host='localhost',
        # user=os.getenv("DB_USERNAME"),
        user="admin",
        # password=os.getenv("DB_PASSWORD"),
        password="123",
        database="muzeum",
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

    try:
        with connection.cursor() as cursor:
            tabela = input("co chcesz zmodyfikować?")
            sql = f"show columns from {tabela}"
            cursor.execute(sql)
            result = cursor.fetchall()
            kolumny = []
            for item in result:
                print(item['Field'])
                kolumny.append(item['Field'])
        return 1
    except:
        print("Przepraszamy wystąpił błąd")
        return 0
    finally:
        connection.close()


def wyszukiwarka():
    connection = pymysql.connect(
        host='localhost',
        # user=os.getenv("DB_USERNAME"),
        user="admin",
        # password=os.getenv("DB_PASSWORD"),
        password="123",
        database="muzeum",
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

    try:
        with connection.cursor() as cursor:
            nazwa_stylu = input("Podaj nazwę stylu")
            opis = input("Podaj opis stylu")
            lista = [nazwa_stylu, opis]
            kolumny = "nazwa_stylu, opis"
            sql = "INSERT INTO styl (nazwa_stylu, opis) VALUES ('nic', 'nic')"
            cursor.execute(sql)
            connection.commit()

    finally:
        connection.close()