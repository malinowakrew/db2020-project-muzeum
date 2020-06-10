# do bazy
import sql.wystawy as zapytania_wystawy
import sql.logowania as zapytania_logowania
import sql.sale as zapytania_sale
import sql.eksponaty as zapytania_eksponaty
import sql.autor as zapytania_autor

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
            print("Aktywne wystawy:")
            aktywne = zapytania_wystawy.wyszukiwarka_aktywnych_wystaw(self.dzis)
            for iter, wystawa in enumerate(aktywne):
                print(f"{iter + 1}. {wystawa['nazwa']} \t otwarta do {wystawa['koniec']}")
            numer = int(input("\nWybierz wystawę:"))
            for iter2, wystawa2 in enumerate(aktywne):
                if iter2 + 1 == numer+1:
                    break
                nazwa = wystawa2['nazwa']
            dzisiejsza_data = datetime.datetime.now()
            dzis = dzisiejsza_data.strftime("%Y-%m-%d")

            ceny=zapytania_wystawy.sprawdz_ceny(nazwa)
            for iter, cena in enumerate(ceny):
                print(f"{iter + 1}. {cena['typ']} \t  {cena['koszt']} zł")
            znizka = int(input("Wybierz bilet: "))

            for iter2, cena2 in enumerate(ceny):
                if iter2 + 1 == znizka+1:
                    break
                koszt = cena2['koszt']

            wybor = input(
                f"Cena biletu wynosi {koszt} zł. Czy kontynuować z transakcją? (tak/nie)\n")
            wybor = wybor.lower()
            if (wybor == "tak"):
                # dodanie biletu do bazy danych
                result = zapytania_wystawy.dodaj_bilet(koszt, dzis, nazwa, self.nazwa)
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

    def Zwrot_biletu(self):
        try:
            print("\nKupione bilety na bieżące wystawy:")
            bilety=zapytania_wystawy.sprawdz_bilety(self.nazwa)
            for iter, bilet in enumerate(bilety):
                print(f"{iter + 1}. {bilet['nazwa']}, data zakupu: {bilet['data_zakupu']}")
            numer = int(input("Wybierz bilet: "))
            for iter2, bilet2 in enumerate(bilety):
                if iter2 + 1 == numer+1:
                    break
                nazwa = bilet2['nazwa']
                data=bilet2['data_zakupu']
            result= zapytania_wystawy.usun_bilet(nazwa,data,self.nazwa)
            if result:
                print("Bilet zwrócony pomyślnie.")


        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0
        finally:
            return 1

    def Szukaj_autora(self):
        try:
            numer = int(input("\nSzukaj po:\n1.Nazwisko\n2.Imie\n3.Pseudonim\n"))
            nazwa=input("Wpisz tutaj: ")
            if numer==1:
                typ='nazwisko'
            elif numer==2:
                typ='imie'
            elif numer==3:
                typ='pseudonim'
            result = zapytania_autor.szukaj_autora(typ, nazwa)
            print(f"Szukaj wystawy po - {nazwa}:")
            for iter, autor in enumerate(result):
                print(f"{iter + 1}. {autor['nazwa']} ")


        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0

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

    def sprawdz_wystawy(self):
        self.wyszukiwarka_aktywnych_wystaw()

        powrot = False
        while powrot == False:

            wybor = (input("Czy chcesz zobaczyć eksponaty z wystawy? tak/nie ")).lower()

            if wybor == "tak":
                nazwa = input("Wpisz nazwę wystawy, którą chcesz lepiej poznać ")

                try:
                    eksponaty = zapytania_wystawy.eksponaty_z_wystawy(nazwa)

                except Exception as błąd:
                    print("Wprowadzono niepoprawne dane")
                    print(błąd)
                    break

                if len(eksponaty) == 0:
                    print("Wystawa musi być pusta! Ups coś poszło nie tak")

                for eksponat in eksponaty:
                    print(f"\n {eksponat['tytul']}")
                    print(f"Data powstania: {eksponat['rok_powstania']}")
                    print(f"Dane o autorze: {eksponat['imie']} {eksponat['nazwisko']} pseudonim {eksponat['pseudonim']}")

                    opis = (str(eksponat['opis']))[2:-1]

                    print(f"Opis: {opis}")

                print("\n\tJeszcze raz?")
            elif wybor == "nie":
                powrot = True
            else:
                print("Niepoprawnie wpisana wartość")



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

                wybor_sal = input("Aby wybrać więcej niż 1 salę wpisz je po przecinku nie dawaj spacji pomiędzy nie\n"
                                   "Podaj numer sali: ")
                try:
                    lista_sal = [int(numer) for numer in wybor_sal.split(",")]
                except:
                    raise Exception("Błądnie wpisane numery sal")

                vip = input("Czy będą dostępne bilety VIP? (tak/nie)")
                wybor = input(
                    f"Czy dane są poprawne? \n\t {nazwa} \n\t Od {poczatek} do {zakonczenie}\n\t Sala nr {lista_sal}\n"
                    f"\t Dostępne bilety VIP: {vip}\n")

                wybor = wybor.lower()

                if (wybor == "tak"):
                    # dodanie wystawy do bazy danych
                    result = zapytania_wystawy.dodaj_wystawe(nazwa, poczatek, zakonczenie, self.pracownikID,
                                                             lista_sal, self.budynekID, vip)

                if result == 1:
                    print("Wystawa dodana")
                    return 1
                else:
                    raise Exception("Nie mogę dodać do bazy")

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
                dostepne_wystawy = dostepne_wystawy.set_index('nazwa')
                print(dostepne_wystawy)
                wybor = 1

                while(wybor != '0'):
                    wybor = input(f"Wybierz wystawę do której chcesz dodać eksponat: \n"
                                  f"jeśli chcesz zrezygnować z dodania wpisz 0 \n")


                    if (wybor in dostepne_wystawy.index):
                        nazwa_wybranej_wystawy = wybor

                        print(f"Wybrałeś wystawę {nazwa_wybranej_wystawy}")
                        result = zapytania_eksponaty.dodaj_eksponat(nazwa, poczatek, opis, nazwa_wybranej_wystawy)

                        if (result == 1):
                            print("\n Dodano eksponat do wystawy \n")
                            break

                    elif wybor == '0':
                        return 0
                    else:
                        print("\n Podano złą nazwę wystawy \n")

                autor = input("Podaj imię, nazwisko oraz pseudonim autora oddzielone spacją: ")

                autor = autor.split(" ")

                res_autor = zapytania_autor.dodaj_autora_do_eksponatu(nazwa, poczatek, opis, autor[0], autor[1], autor[2])

                if  res_autor == 1:
                    print("Dodano autora")

            else:
                print("\n Zrezygnowano z dodania \n")

        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0

    def statystyki(self):
        print("Możesz teraz sprawdzić statystyki w swoim budynku\n"
              "1. Statystyki ze wszystkich wystaw\n"
              "2. Statystyki z dzisiejszego dnia")

        wybor = input("Wybierz numer, który Cię interesuje: ")
        try:
            if wybor == "1":
                ilosc_biletow = zapytania_wystawy.statystyki(self.budynekID)
                for wystawa in ilosc_biletow:
                    print(f"Wystawa {wystawa['nazwa']} została odwiedzona przez {wystawa['ilosc']} użytkowników tej pięknej aplikacji")
            elif wybor == "2":
                print("To masz problem")
            else:
                print("Niepoprawny wybór - skup się pracowniku.\n")
        except Exception as błąd:
            print(błąd)

    def dodaj_autora(self):
        print("Uzupełnij dane autora")

        autor = input("Podaj imię, nazwisko oraz pseudonim autora oddzielone spacją: ")
        autor = autor.split(" ")

        try:
            zapytania_autor.dodaj_autora(autor[0], autor[1], autor[2])
            print("Dodano autora")
        except Exception as błąd:
            print(błąd)


    def dziela_autorow(self):
        try:
            result=zapytania_autor.dziela_autorow()
            for iter, autor in enumerate(result):
                print(f"{iter + 1}. {autor['nazwisko']} {autor['imie']} - liczba eksponatów w muzeum: {autor['ilosc']}")
        except Exception as wiadomosc:
            if wiadomosc == "Błąd bazy":
                print("Niestety baza nie może Cię obsłużyć. To jej wina")
            else:
                print(wiadomosc)
            return 0



def sciezka_uzytkownika():
    wyloguj = True
    try:
        uzytkownik = Uzytkownik()
        wyloguj = False
    except Exception as wiadomosc:
        if (str(wiadomosc) == "tuple index out of range"):
            print("Niepoprawne hasło")
        else:
            print(f"Tutaj przyda się programista bo {wiadomosc}")



    while (wyloguj == False):
        print(
              "\n\nWitamy, możesz korzystać z naszej bazy. \n"
              "1. Sprawdź aktualne wystawy \n"
              "2. Sprawdź popularne wystawy \n"
              "3. Kup bilet \n"
              "4. Zwróć bilet \n"
              "5. Szukaj wystawy po autorze \n"              
              "6. Wyloguj")
        funkcjonalnosc = input("Podaj numer, który Cię interesuje: ")
        niezalogowany = wystawy_app.niezalogowany()

        if (funkcjonalnosc == "1"):
            uzytkownik.sprawdz_wystawy()

        elif (funkcjonalnosc == "2"):
            niezalogowany.najczesciej_odwiedzane_wystawy()

        elif (funkcjonalnosc == "3"):
            uzytkownik.Kup_bilet()

        elif (funkcjonalnosc == "4"):
            uzytkownik.Zwrot_biletu()

        elif (funkcjonalnosc == "5"):
            uzytkownik.Szukaj_autora()

        elif (funkcjonalnosc == "6"):
            print("Wylogowano \n\n")
            wyloguj = True
        else:
            print("Błąd wpisu")


def sciezka_pracownika():
    wyloguj = True
    try:
        pracownik = Pracownik()
        wyloguj = False
    except Exception as wiadomosc:
        if (str(wiadomosc) == "tuple index out of range"):
            print("Niepoprawne hasło")
        else:
            print(f"Tutaj przyda się programista bo {wiadomosc}")



    while (wyloguj == False):
        print("\n1. Dodaj wystawę\n"
              "2. Dodaj eksponat\n"
              "3. Pokaż statystyki zwiedzania\n"
              "4. Dodaj autora\n"
              "5. Zbadaj autorów\n"              
              "6. Wyloguj")
        funkcjonalnosc = input("Podaj numer, który Cię interesuje: ")

        if (funkcjonalnosc == "1"):
            print("\n \t ################### \n")
            pracownik.dodaj_wystawe()

        elif (funkcjonalnosc == "2"):
            print("\n \t ################### \n")
            pracownik.dodaj_eksponat()

        elif (funkcjonalnosc == "3"):
            print("\n \t ################### \n")
            pracownik.statystyki()

        elif(funkcjonalnosc == "4"):
            print("\n \t ################### \n")
            pracownik.dodaj_autora()

        elif (funkcjonalnosc == "5"):
            print("\n \t ################### \n")
            pracownik.dziela_autorow()

        elif (funkcjonalnosc == "6"):
            print("Wylogowano \n\n")
            wyloguj = True
        else:
            print("Błąd wpisu")

def rejestracja():
    try:
        mail = input("Podaj email: ")
        res1 = zapytania_logowania.powtorzenie("email",mail)
        #comment bo nie dziala ?
        #boolean = search(".@gmail.com$", res1[0]["email"])
        if len(res1) == 1:
            print("Ten email ma już przypisane konto.")
            return 0
        #elif boolean != True:
         #       raise ValueError("Nieprawidłowa forma emaila")
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

