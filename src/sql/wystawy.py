import os
import pymysql
#from . import polaczenie
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


def dodaj_wystawe(nazwa, poczatek, zakonczenie, pracownik, salaID):
    connection = polaczenie()
    try:
        with connection.cursor() as cursor:
            # dodajemy do tablicy Wystawa
            #cursor.execute("SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED")
            #connection.commit()

            sql = (
                f"INSERT INTO wystawa (nazwa, poczatek, koniec, pracownikID) " 
                f" VALUES('{nazwa}', '{poczatek}' ,'{zakonczenie}', {pracownik});"
            )
            cursor.execute(sql)

            sql3 = (
                f"SELECT wystawa.wystawaID FROM wystawa WHERE wystawa.nazwa = '{nazwa}';"
            )

            cursor.execute(sql3)
            result = ((cursor.fetchall())[0])["wystawaID"]
            #result = cursor.fetchall()
            print(result)

            sql2 = f"INSERT INTO wystawa_sala(salaID, wystawaID) VALUES ({salaID}, {result});"
            cursor.execute(sql2)
            connection.commit()

    except Exception as błąd:
        raise Exception(błąd)
    finally:
        connection.close()

def dodaj_bilet(cena, data, wartosc, wystawa,  nazwa):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # dodajemy do tablicy Bilet
            sql = (
                f"INSERT INTO bilet (cena, data_zakupu, zakupiony, wystawaID, nazwa_uzytkownika) " 
                f" VALUES({cena}, '{data}' ,{wartosc}, (SELECT wystawaID FROM wystawa WHERE nazwa = '{wystawa}') , '{nazwa}' );"
            )
            cursor.execute(sql)
            connection.commit()
            connection.close()
        return 1
    except:
        raise Exception("Błąd bazy")


def sprawdz_ceny(nazwa_wystawy):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = (
                f"SELECT DISTINCT wystawa.nazwa, cena.typ, cena.koszt "
                f"FROM wystawa JOIN cena_wystawa ON wystawa.wystawaID = cena_wystawa.wystawaID "
                f"JOIN cena ON cena.cenaID = cena_wystawa.cenaID "
                f"WHERE wystawy.nazwa = '{nazwa_wystawy}';"
            )
            cursor.execute(sql)
            result = cursor.fetchall()
        connection.close()
        return result
    except Exception as bład:
        raise Exception(bład)



def main():
    dodaj_wystawe("nazwa", "1999-01-01", "1999-12-12", 2, 1)


if __name__ == "__main__":
    main()
