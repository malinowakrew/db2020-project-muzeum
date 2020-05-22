import app.wystawy as wystawy
import sql.wystawy as zapytania_wystawy

class uzytkownik(wystawy.niezalogowany):
    def __init__(self):
        super().__init__()
        bufor = self.logowanie()
        self.nazwa = bufor['nazwa']
        self.email = bufor['email']

    def logowanie(self):
        print("Oto nasz panel logowania")
        log = 1
        while(log):
            login = input("Login: ")
            haslo = input("Hasło: ")

            try:
                dane = zapytania_wystawy.zaloguj(login, haslo)
                log = 0
                return dane[0]
            except Exception as wiadomosc:
                print(wiadomosc)
                print("Niepoprawne hasło")
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







