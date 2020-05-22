import datetime
import sql.eksponaty as zapytania_eksponaty

class niezalogowany():
    def __init__(self):
        pass

    def dodaj_eksponat(self):
        try:
            nazwa = input("Podaj nazwę eksponatu: ")
            startR = input("Podaj datę powstania: \nRok:")
            startM = input("Miesiąc:")
            startD = input("Dzień:")
            start = datetime.datetime(int(startR), int(startM), int(startD))
            poczatek = start.strftime('%Y-%m-%d')
            opis = input("Dodaj opis: ")

            wybor = input(f"Czy dane są poprawne? \n\t {nazwa} \n\t {poczatek} \n\t {opis}\n")
            wybor = wybor.lower()

            if (wybor == "tak"):
                 result = zapytania_eksponaty.dodaj_eksponat(nazwa,poczatek,opis)

        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0
        finally:
            return 1