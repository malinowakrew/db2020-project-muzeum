import os
import pymysql

def polaczenie():
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
    return connection

def wyszukiwarka_aktywnych_wystaw(dzis):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # wykonujemy zapytanie do bazy i wyświetlamy
            sql = f"SELECT nazwa, koniec FROM wystawa WHERE koniec > DATE '{dzis}' AND poczatek < DATE '{dzis}';"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result

    except EOFError:
        raise Exception("Błąd bazy")
    finally:
        connection.close()

def najczesciej_odwiedzane_wystawy(wybor, dzis):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # konstruujemy odpowiednie zapytania
            if(wybor == "nie"):
                sql = (
                    "SELECT wystawa.nazwa, wystawa.koniec, wystawa.poczatek, COUNT(bilet.biletID) AS ilosc "
                    "FROM wystawa JOIN bilet ON wystawa.wystawaID = bilet.wystawaID "
                    "GROUP BY wystawa.wystawaID ORDER BY ilosc DESC LIMIT 5;"
                )

            elif(wybor == "tak"):
                sql = (
                    f"SELECT wystawa.nazwa, wystawa.koniec, wystawa.poczatek, COUNT(bilet.biletID) AS ilosc "
                    f"FROM wystawa JOIN bilet ON wystawa.wystawaID = bilet.wystawaID "
                    f"WHERE DATE '{dzis}' BETWEEN wystawa.poczatek AND wystawa.koniec "
                    f"GROUP BY wystawa.wystawaID ORDER BY ilosc DESC LIMIT 5;"
                )

            else:
                raise Exception("Niepoprawnie wpisany tekst")

            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except:
        raise Exception("Błąd bazy")
    finally:
        connection.close()

def sprawdz_cene(nazwa):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = (f"SELECT DISTINCT cena.koszt, cena.typ"
                   f"FROM wystawa" 
                   f"JOIN cena_wystawa ON wystawa.wystawaID = cena_wystawa.wystawaID"
                   f"JOIN cena ON cena.cenaID = cena_wystawa.cenaID"
                   f"WHERE wystawa.nazwa = '{nazwa}';"
                   )

            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except:
        raise Exception("Błąd bazy")
    finally:
        connection.close()



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
            resultt = cursor.fetchall()
            print(resultt)
            return resultt
    except:
        raise Exception("Błąd bazy")
    finally:
        connection.close()



