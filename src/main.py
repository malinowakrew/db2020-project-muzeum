import os
import app.wystawy as wystawy_app
import app.logowania as logowania
import datetime



def main():
    print("Witamy w naszym muzeum")
    print("Zaloguj się na swoje konto aby mieć dostęp do większej ilości funkcjonalności")
    zmienna = 1

    while (zmienna):
        print("Wybierz co chcesz zrobić z naszego menu: \n"
              "1. Zaloguj się \n"
              "2. Załóż konto \n"
              "3. Przeglądaj zbiory bez konta \n"
              "4. Zamknij\n")
        funkcjonalnosc = input("Podaj numer, który Cię interesuje: ")

        # ten = api.niezalogowany()
        # ten.dodaj_eksponat()

        if (funkcjonalnosc == "1"):
            wybor_pracownik = input("Aby zalogować się jako pracownik kliknij 9 ")
            if wybor_pracownik == "9":
                logowania.sciezka_pracownika()
            else:
                logowania.sciezka_uzytkownika()

        elif (funkcjonalnosc == "2"):
            print("\n \t ################### \n")
            logowania.rejestracja()
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
            elif (funkcjonalnosc == "2"):
                niezalogowany.najczesciej_odwiedzane_wystawy()
            print("\n \t ################### \n")
        elif (funkcjonalnosc == "4"):
            return 0
        else:
            print("Mamy błąd - źle wybrałeś spróbuj ponownie.")
            zmienna = 1

if __name__ == "__main__":
    main()


