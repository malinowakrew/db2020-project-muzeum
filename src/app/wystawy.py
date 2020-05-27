import datetime
import sql.wystawy as zapytania_wystawy

class niezalogowany():
    def __init__(self):
        pass

    def wyszukiwarka_aktywnych_wystaw(self):
        try:
            # sprawdzamy dzisiejszą datę
            dzisiejsza_data = datetime.datetime.now()
            dzis = dzisiejsza_data.strftime("%Y-%m-%d")
            print(f"\t Dziś mamy {dzis}")

            # wykonujemy zapytanie do bazy i wyświetlamy
            result = zapytania_wystawy.wyszukiwarka_aktywnych_wystaw(dzis)
            for iter, wystawa in enumerate(result):
                print(f"{iter + 1}. {wystawa['nazwa']} \t otwarta do {wystawa['koniec']}")

            # informacje dodatkowe dla użytkownika
            if (dzisiejsza_data.weekday() == 0):
                print("Pamiętaj tylko, że dziś poniedziałek! MUZEUM NIECZYNNE :)")

        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0
        finally:
            return 1

    def najczesciej_odwiedzane_wystawy(self):
        try:
            # wybieramy opcje wyszukiwania
            wybor = input("Czy chcesz oglądać tylko aktywne wystawy? tak/nie ")
            wybor = wybor.lower()

            if (wybor == "tak"):
                dzisiejsza_data = datetime.datetime.now()
                dzis = dzisiejsza_data.strftime("%Y-%m-%d")

                result = zapytania_wystawy.najczesciej_odwiedzane_wystawy(wybor, dzis)

                print("Aktywne TOP 5")
                for iter, wystawa in enumerate(result):
                    print(f"{iter + 1}. {wystawa['nazwa']} \t otwarta do {wystawa['koniec']}")

            elif (wybor == "nie"):
                result = zapytania_wystawy.najczesciej_odwiedzane_wystawy(wybor, '01-01-1998')

                print("TOP 5")
                for iter, wystawa in enumerate(result):
                    print(f"{iter + 1}. {wystawa['nazwa']} \t otwarta do {wystawa['koniec']}")

        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0
        finally:
            return 1







