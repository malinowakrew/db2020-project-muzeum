import sql.eksponaty as api

print("Witamy w naszym muzeum")
print("Wyszukaj kolumny - tymczasowe")
co = input("kim jesteś?")
if(co == "kierownik"):
    api.kolumny()
else:
    api.wyszukiwarka()
