import datetime
import sql.wystawy as zapytania_wystawy

class niezalogowany():
    def __init__(self):
        self.dzisiejsza_data = datetime.datetime.now()
        self.dzis = self.dzisiejsza_data.strftime("%Y-%m-%d")

    def wyszukiwarka_aktywnych_wystaw(self):
        try:
            # sprawdzamy dzisiejszą datę
            print(f"\t Dziś mamy {self.dzis}")

            # wykonujemy zapytanie do bazy i wyświetlamy
            result = zapytania_wystawy.wyszukiwarka_aktywnych_wystaw(self.dzis)
            for iter, wystawa in enumerate(result):
                print(f"{iter + 1}. {wystawa['nazwa']} \t otwarta do {wystawa['koniec']}")

            # informacje dodatkowe dla użytkownika
            if (self.dzisiejsza_data.weekday() == 0):
                print("Pamiętaj tylko, że dziś poniedziałek! MUZEUM NIECZYNNE :)")
            return 1
        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0

    def najczesciej_odwiedzane_wystawy(self):
        try:
            # wybieramy opcje wyszukiwania
            wybor = input("Czy chcesz oglądać tylko aktywne wystawy? tak/nie ")
            wybor = wybor.lower()

            if (wybor == "tak"):
                result = zapytania_wystawy.najczesciej_odwiedzane_wystawy(wybor, self.dzis)

                print("Aktywne TOP 5")
                for iter, wystawa in enumerate(result):
                    print(f"{iter + 1}. {wystawa['nazwa']} \t otwarta do {wystawa['koniec']}")

            elif (wybor == "nie"):
                result = zapytania_wystawy.najczesciej_odwiedzane_wystawy(wybor, '01-01-1998')

                print("TOP 5")
                for iter, wystawa in enumerate(result):
                    print(f"{iter + 1}. {wystawa['nazwa']} \t otwarta do {wystawa['koniec']}")
            return 1
        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0







