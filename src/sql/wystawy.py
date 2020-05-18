import os
import pymysql
import datetime

class niezalogowany():
    def __init__(self):
        self.connection = pymysql.connect(
            host='localhost',
            # user=os.getenv("DB_USERNAME"),
            user="admin",
            # password=os.getenv("DB_PASSWORD"),
            password="123",
            database="muzeum",
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )

    def wyszukiwarka_aktywnych_wystaw(self):
        try:
            with self.connection.cursor() as cursor:
                # sprawdzamy dzisiejszą datę
                dzisiejsza_data = datetime.datetime.now()
                dzis = dzisiejsza_data.strftime("%Y-%m-%d")
                print(f"\t Dziś mamy {dzis}")

                # wykonujemy zapytanie do bazy i wyświetlamy
                sql = f"SELECT nazwa, koniec FROM wystawa WHERE koniec > DATE '{dzis}' AND poczatek < DATE '{dzis}'"
                cursor.execute(sql)
                result = cursor.fetchall()
                for iter, wystawa in enumerate(result):
                    print(f"{iter+1}. {wystawa['nazwa']} \t otwarta do {wystawa['koniec']}")

                # informacje dodatkowe dla użytkownika
                if(dzisiejsza_data.weekday() == 0):
                    print("Pamiętaj tylko, że dziś poniedziałek! MUZEUM NIECZYNNE :)")

            return 1
        except:
            print("Przepraszamy wystąpił błąd jakiś tam dziki")
            return 0
        finally:
            self.connection.close()

    def najczesciej_odwiedzane_wystawy(self):
        try:
            with self.connection.cursor() as cursor:
                # wybieramy opcje wyszukiwania
                wybor = input("Czy chcesz oglądać tylko aktywne wystawy? tak/nie ")
                wybor = wybor.lower()

                # konstruujemy odpowiednie zapytania
                if(wybor == "nie"):
                    sql = "SELECT wystawa.nazwa, wystawa.koniec, wystawa.poczatek, COUNT(bilet.biletID) AS ilosc"\
                            "FROM wystawa JOIN bilet ON wystawa.wystawaID = bilet.wystawaID"\
                            "WHERE wystawa.koniec > DATE '2030-01-01'"\
                            "GROUP BY wystawa.wystawaID ORDER BY ilosc"
                    sql2 = "SELECT wystawa.nazwa, wystawa.koniec, wystawa.poczatek, COUNT(bilet.biletID) AS ilosc FROM wystawa JOIN bilet ON wystawa.wystawaID = bilet.wystawaID GROUP BY wystawa.wystawaID ORDER BY ilosc DESC LIMIT 5"
                    print("Aktywne TOP 5")
                elif(wybor == "tak"):
                    dzisiejsza_data = datetime.datetime.now()
                    dzis = dzisiejsza_data.strftime("%Y-%m-%d")
                    sql2 = f"SELECT wystawa.nazwa, wystawa.koniec, wystawa.poczatek, COUNT(bilet.biletID) AS ilosc FROM wystawa JOIN bilet ON wystawa.wystawaID = bilet.wystawaID WHERE DATE '{dzis}' BETWEEN wystawa.poczatek AND wystawa.koniec GROUP BY wystawa.wystawaID ORDER BY ilosc DESC LIMIT 5"

                    print("TOP 5")
                else:
                    raise EOFError
                cursor.execute(sql2)
                result = cursor.fetchall()
                for iter, wystawa in enumerate(result):
                    print(f"{iter + 1}. {wystawa['nazwa']} \t otwarta do {wystawa['koniec']}")
                # wykonujemy zapytanie
            return 1
        except:
            print("Przepraszamy wystąpił błąd jakiś tam dziki")
            return 0
        finally:
            self.connection.close()