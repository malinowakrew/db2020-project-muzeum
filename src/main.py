import sql.eksponaty as api
import os
import sql.wystawy as wystawy
import app.wystawy as wystawy_app
import app.eksponaty as eksponaty_app
import app.logowania as logowania
import datetime

print("Witamy w naszym muzeum")
print("Zaloguj się na swoje konto aby mieć dostęp do większej ilości funkcjonalności")
zmienna = 1


while(zmienna):
    print("Wybierz co chcesz zrobić z naszego menu: \n"
          "1. Zaloguj się \n"
          "2. Załóż konto \n"
          "3. Przeglądaj zbiory bez konta \n")
    funkcjonalnosc = input("Podaj numer, który Cię interesuje: ")

    if (funkcjonalnosc == "1"):
        try:
            on = logowania.uzytkownik()
            wyloguj = False
        except Exception as wiadomosc:
            if (str(wiadomosc) == "tuple index out of range"):
                print("Niepoprawne hasło")
            else:
                print(f"Tutaj przyda się programista bo {wiadomosc}")
            wyloguj = True
                #raise Exception(wiadomosc) # na razi jest tak zrobione, że jak nie podasz dobrze to pada całość :D

        while(wyloguj == False):
            print("1. Dodaj wystawę\n"
                  "2. Dodaj eksponat\n"
                  "3. Wyloguj")

            funkcjonalnosc = input("Podaj numer, który Cię interesuje: ")

            if (funkcjonalnosc == "1"):
                print("\n \t ################### \n")
                niezalogowany = wystawy_app.niezalogowany()
                niezalogowany.dodaj_wystawe()

            elif (funkcjonalnosc == "2"):
                print("\n \t ################### \n")
                niezalogowany = eksponaty_app.niezalogowany()
                niezalogowany.dodaj_eksponat()

            elif (funkcjonalnosc == "3"):
                wyloguj = True
            else:
                print("Błąd wpisu")


    elif (funkcjonalnosc == "2"):
        pass
    elif (funkcjonalnosc == "3"):
        print("\n \t ################### \n"
              "Witamy, możesz w ograniczonu sposób korzystać z naszej bazy. \n"
              "1. Sprawdź aktualne wystawy \n"
              "2. Sprawdź popularne wystawy \n")
        funkcjonalnosc = input("Podaj numer, który Cię interesuje: ")
        niezalogowany = wystawy_app.niezalogowany()

        if (funkcjonalnosc == "1"):
            dzis = datetime.datetime.now()
            niezalogowany.wyszukiwarka_aktywnych_wystaw()
            zmienna =  0
        elif (funkcjonalnosc == "2"):
            niezalogowany.najczesciej_odwiedzane_wystawy()
        print("\n \t ################### \n")

    else:
        print("Mamy błąd - źle wybrałeś spróbuj ponownie.")
        zmienna = 1

