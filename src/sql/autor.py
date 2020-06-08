from . import polaczenie

def dodaj_autora_do_eksponatu(tytul, rok, opis, imie, nazwisko, pseudonim):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql2 = (
                f"SELECT * FROM autor "
                f"WHERE autor.imie = '{imie}' AND autor.nazwisko = '{nazwisko}' AND autor.pseudonim = '{pseudonim}';"
            )
            cursor.execute(sql2)
            autor = cursor.fetchall()

            if (len(autor) == 0):
                sql3 = (
                    f"INSERT INTO autor(imie, nazwisko, pseudonim) VALUES('{imie}', '{nazwisko}', '{pseudonim}');"
                )
                cursor.execute(sql3)

                sql4 = (
                    f"SELECT * FROM autor "
                    f"WHERE autor.imie = '{imie}' AND autor.nazwisko = '{nazwisko}' AND autor.pseudonim = '{pseudonim}';"
                )

                cursor.execute(sql4)
                autor = cursor.fetchall()

            try:
                autorID = (autor[0])["autorID"]

            except Exception as opis:
                raise Exception(opis)

            sql5 = ( f"SELECT eksponat.eksponatID FROM eksponat " 
                   f"WHERE eksponat.rok_powstania = DATE '{rok}' AND  eksponat.tytul = '{tytul}';"
                     )
            cursor.execute(sql5)

            eksponatID = (cursor.fetchall()[0])['eksponatID']

            sql = (
                f"INSERT INTO eksponat_autor(eksponatID, autorID) VALUES({eksponatID}, {autorID})"
            )

            cursor.execute(sql)

        connection.commit()
        connection.close()
        return 1

    except Exception as błąd:
        connection.rollback()
        raise Exception(f"Błąd bazy: {błąd}")

def dodaj_autora(imie, nazwisko, pseudonim):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = (
                f"INSERT INTO autor(imie, nazwisko, pseudonim) VALUES('{imie}', '{nazwisko}', '{pseudonim}');"
                   )
            cursor.execute(sql)
            connection.commit()
        connection.close()

    except Exception as błąd:
        raise Exception(błąd)