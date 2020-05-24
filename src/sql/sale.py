from . import polaczenie

def pokaz_sale(budynek):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            # wykonujemy zapytanie do bazy i wyświetlamy
            sql = (f"SELECT sala.salaID, sala.wielkosc, sala.numer FROM sala WHERE sala.budynekID = {budynek}")
            cursor.execute(sql)
            result = cursor.fetchall()
        connection.close()
        return result
    except:
        raise Exception("Błąd bazy")