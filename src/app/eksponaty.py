import datetime
import sql.eksponaty as zapytania_eksponaty
import sql.sale as zapytania_sale

class niezalogowany():
    def __init__(self):
        self.dzisiejsza_data = datetime.datetime.now()
        self.dzis = self.dzisiejsza_data.strftime("%Y-%m-%d")

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
                print("Możesz dodać eksponat do następujących wystaw: ")
                #wyświetl obecne wystawy i przyszłe
                wielkosc = zapytania_sale.wielkosc_wystawy(self.dzis)
                dostepne_wystawy = []
                for wystawa in wielkosc:
                    dostepne_wystawy.append(wystawa['nazwa'])
                    print(wystawa['nazwa'])

                wybor = 1
                while(wybor != '0'):
                    wybor = input(f"Wybierz wystawę do której chcesz dodać eksponat: \n"
                                  f"jeśli chcesz zrezygnować z dodania wpisz 0 \n")

                    if (wybor in dostepne_wystawy):
                        result = zapytania_eksponaty.dodaj_eksponat(nazwa, poczatek, opis, wybor)

                        if (result == 1):
                            print("\n Dodano eksponat do wystawy \n")
                            wybor = 0

                    elif wybor == '0':
                        pass
                    else:
                        print("\n Podano złą nazwę wystawy \n")
            else:
                print("\n Zrezygnowano z dodania \n")

        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0
        finally:
            return 1
