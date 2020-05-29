# do bazy
import sql.wystawy as zapytania_wystawy
import sql.logowania as zapytania_logowania
import sql.sale as zapytania_sale
import sql.eksponaty as zapytania_eksponaty
## do innych app
import app.wystawy as wystawy_app
import app.eksponaty as eksponaty_app

## dodatkowe
import datetime
from re import search


class Uzytkownik(wystawy_app.niezalogowany):
    def __init__(self):
        super().__init__()
        bufor = self.logowanie()
        self.nazwa = bufor['nazwa']
        self.email = bufor['email']

    def Kup_bilet(self):
        try:
            wystawa = input("\nPodaj nazwę wystawy:")
            dzisiejsza_data = datetime.datetime.now()
            dzis = dzisiejsza_data.strftime("%Y-%m-%d")

            znizka=int(input("1.Bilet ulgowy 10 złoty\n2.Bilet normalny 20zł\nWybierz bilet: "))

            zapytania_wystawy.sprawdz_ceny('1')

            if znizka == 1:
                wybor = input(
                    f"Cena biletu wynosi 10 złoty. Czy kontynuować z transakcją? (tak/nie)\n")
                wybor = wybor.lower()
                if (wybor == "tak"):
                    # dodanie biletu do bazy danych
                    result = zapytania_wystawy.dodaj_bilet(10, dzis, 1, wystawa,  self.nazwa)
                    if result:
                        print("Bilet kupiony pomyślnie.")
            elif znizka == 2:
                wybor = input(
                    f"Cena biletu wynosi 20 złoty. Czy kontynuować z transakcją? (tak/nie)\n")
                wybor = wybor.lower()

                if (wybor == "tak"):
                    # dodanie biletu do bazy danych
                    result = zapytania_wystawy.dodaj_bilet(20, dzis, 1, wystawa,  self.nazwa)
                    if result:
                        print("Bilet kupiony pomyślnie.")

            else:
                print("Błąd")

        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0
        finally:
            return 1

    def logowanie(self):
        print("Oto nasz panel logowania")
        log = 1
        while (log):
            login = input("Login: ")
            haslo = input("Hasło: ")

            try:
                dane = zapytania_logowania.zaloguj(login, haslo)
                log = 0
                return dane[0]
            except Exception as wiadomosc:
                raise Exception(wiadomosc)

                if (log < 4):
                    ponownie = (input("Czy chcesz spróbować ponownie? Napisz 'tak' jeśli chcesz.")).lower()

                    if (ponownie == "tak"):
                        log += 1
                        print(f"Próba numer {log}")
                    else:
                        raise Exception("Niezgodność danych")
                        return 0
                else:
                    raise Exception("Za dużo prób")




class Pracownik(Uzytkownik):
    def __init__(self):
        super().__init__()
        bufor = self.dane()
        self.imie = bufor['imie']
        self.nazwisko = bufor['nazwisko']
        self.pracownikID = int(bufor['pracownikID'])
        self.budynekID = int(bufor['budynekID'])

    def dane(self):
        return zapytania_logowania.dane_pracownika(self.nazwa)[0]

    def dodaj_wystawe(self):
        try:
            nazwa = input("Podaj nazwę wystawy: ")
            startR = input("Będzie trwać od: \nRok:")
            startM = input("Miesiąc:")
            startD = input("Dzień:")
            start = datetime.datetime(int(startR), int(startM), int(startD))
            koniecR = input("Kończy się: \nRok:")
            koniecM = input("Miesiąc:")
            koniecD = input("Dzień:")
            koniec = datetime.datetime(int(koniecR), int(koniecM), int(koniecD))
            poczatek = start.strftime('%Y-%m-%d')
            zakonczenie = koniec.strftime('%Y-%m-%d')
            print(f"Wybrany termin {poczatek} i {zakonczenie}")
            print('Wolne sale w twoim budynku: ')
            sale = zapytania_sale.pokaz_dostepne_sale(self.budynekID, poczatek, zakonczenie)
            if len(sale) != 0:
                for iter, sala in enumerate(sale):
                    print(f"{iter + 1}. Sala nr {sala['numer']}")

                sala_w = int(input("Podaj numer sali: "))

                wybor = input(f"Czy dane są poprawne? \n\t {nazwa} \n\t Od {poczatek} do {zakonczenie}\n\t Sala nr {(sale[sala_w - 1])['salaID']}\n")
                wybor = wybor.lower()

                if (wybor == "tak"):
                    # dodanie wystawy do bazy danych
                    result = zapytania_wystawy.dodaj_wystawe(nazwa, poczatek, zakonczenie, self.pracownikID,
                                                             (sale[sala_w - 1])["salaID"])
                    # przypisanie ID wystawy do odpowiadajacej jej sali
                    # result2 = zapytania_sale.dodaj_wystawe(nazwa, sala, self.budynekID)

                if result == 1:
                    print("Wystawa dodana")
                    return 1

            else:
                print("Brak wolnych sal w wybranym terminie")

        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0

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
                wielkosc = wielkosc.fillna(0.0)

                dostepne_wystawy = wielkosc[wielkosc["wielkosc_wystawy"] > wielkosc["ilosc_eksponatow"]]
                print(dostepne_wystawy)
                wybor = 1

                while(wybor != '0'):
                    wybor = int(input(f"Wybierz wystawę do której chcesz dodać eksponat: \n"
                                  f"jeśli chcesz zrezygnować z dodania wpisz 0 \n"))


                    if (wybor in dostepne_wystawy.index):
                        nazwa_wybranej_wystawy = dostepne_wystawy.iloc[wybor-1, 1]

                        print(f"Wybrałeś wystawę {nazwa_wybranej_wystawy}")
                        result = zapytania_eksponaty.dodaj_eksponat(nazwa, poczatek, opis, nazwa_wybranej_wystawy)

                        if (result == 1):
                            print("\n Dodano eksponat do wystawy \n")
                            return 1

                    elif wybor == '0':
                        return 0
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




def sciezka_uzytkownika():
    try:
        uzytkownik = Uzytkownik()
    except Exception as wiadomosc:
        if (str(wiadomosc) == "tuple index out of range"):
            print("Niepoprawne hasło")
        else:
            print(f"Tutaj przyda się programista bo {wiadomosc}")

    wyloguj = False

    while (wyloguj == False):
        print(
              "Witamy, możesz korzystać z naszej bazy. \n"
              "1. Sprawdź aktualne wystawy \n"
              "2. Sprawdź popularne wystawy \n"
              "3. Kup bilet \n"
              "4. Wyloguj")
        funkcjonalnosc = input("Podaj numer, który Cię interesuje: ")
        niezalogowany = wystawy_app.niezalogowany()

        if (funkcjonalnosc == "1"):
            dzis = datetime.datetime.now()
            niezalogowany.wyszukiwarka_aktywnych_wystaw()
            zmienna =  0

        elif (funkcjonalnosc == "2"):
            niezalogowany.najczesciej_odwiedzane_wystawy()

        elif (funkcjonalnosc == "3"):
            niezalogowany.wyszukiwarka_aktywnych_wystaw()
            uzytkownik.Kup_bilet()

        elif (funkcjonalnosc == "4"):
            print("Wylogowano \n\n")
            wyloguj = True
        else:
            print("Błąd wpisu")


def sciezka_pracownika():
    try:
        pracownik = Pracownik()
    except Exception as wiadomosc:
        if (str(wiadomosc) == "tuple index out of range"):
            print("Niepoprawne hasło")
        else:
            print(f"Tutaj przyda się programista bo {wiadomosc}")

    wyloguj = False

    while (wyloguj == False):
        print("1. Dodaj wystawę\n"
              "2. Dodaj eksponat\n"
              "3. Wyloguj")
        funkcjonalnosc = input("Podaj numer, który Cię interesuje: ")

        if (funkcjonalnosc == "1"):
            print("\n \t ################### \n")
            pracownik.dodaj_wystawe()

        elif (funkcjonalnosc == "2"):
            print("\n \t ################### \n")
            pracownik.dodaj_eksponat()

        elif (funkcjonalnosc == "3"):
            print("Wylogowano \n\n")
            wyloguj = True
        else:
            print("Błąd wpisu")

def rejestracja():
    try:
        mail = input("Podaj email: ")
        res1 = zapytania_logowania.powtorzenie("email",mail)
        boolean = search(".@gmail.com$", res1[0]["email"])
        if len(res1) == 1:
            print("Ten email ma już przypisane konto.")
            return 0
        elif boolean != True:
                raise ValueError("Nieprawidłowa forma emaila")
        else:
            nazwa = input("Podaj nazwę użytkownika: ")
            res2 = zapytania_logowania.powtorzenie("nazwa",nazwa)
            if len(res2) == 1:
                print("Nazwa użytkownika już zajęta. Spróbuj ponownie.")
                return 0
            else:
                haslo = input("Podaj haslo: ")
                wybor = input(
                    f"Czy dane są poprawne? \n\t Email: {mail} \n\t Login: {nazwa} \n\t Haslo: {haslo}\n")
                wybor = wybor.lower()

                if (wybor == "tak"):
                    # dodanie uzytkownika do bazy danych
                     result = zapytania_logowania.dodaj_uzytkownika(mail, nazwa, haslo)

                if result == 1:
                   print("Twoje konto zostalo utworzone pomyślnie!")

    except Exception as wiadomosc:
        if str(wiadomosc) == "Błąd bazy":
            print("Niestety baza nie może Cię obsłużyć. To jej wina")
        else:
            print(wiadomosc)
        return 0
    finally:
        return 1
