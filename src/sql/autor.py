from . import polaczenie

def dodaj_autora_doeksponatu(eksponatID, autorID, imie, nazwisko, pseudonim):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql2 = (
                f"SELECT autor.pseudonim FROM autor"
            )
            cursor.execute(sql2)
            autorzy= cursor.fetchall()

            if pseudonim in autorzy:
                pass

            else:
                sql = (
                    f"INSERT INTO eksponat_autor(eksponatID, autorID) VALUES({eksponatID}, {autorID})"
                )

            cursor.execute(sql)
            connection.commit()
        connection.close()
        return 1
    except Exception as błąd:
        raise Exception(błąd)

def dodaj_autora(imie, nazwisko, pseudonim):
    try:
        connection = polaczenie()
        with connection.cursor() as cursor:
            sql = (
                f"INSERT INTO autor(imie, nazwisko, pseudonim) VALUES({imie}, {nazwisko}, {pseudonim})"
                   )
            cursor.execute(sql)
            connection.commit()
        connection.close()
        return 1
    except Exception as błąd:
        raise Exception(błąd)