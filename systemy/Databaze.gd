extends Resource

var tabulka: Dictionary

const CSV_CESTA = "res://slovnik.csv"


func _init() -> void:
	importuj_csv(CSV_CESTA)
	#print(tabulka)


func importuj_csv(cesta: String) -> void:
	# 1. Zkontrolujeme, zda soubor fyzicky existuje
	if not FileAccess.file_exists(cesta):
		push_error("Chyba: Soubor neexistuje na cestě: ", cesta)
		return

	# 2. Otevřeme soubor v režimu čtení (READ)
	var soubor = FileAccess.open(cesta, FileAccess.READ)
	if soubor == null:
		push_error("Nelze otevřít soubor. Kód chyby: ", FileAccess.get_open_error())
		return

	var je_prvni_radek = true
	var hlavicka: PackedStringArray = []

	# 3. Čteme soubor cyklicky až do konce souboru (EOF)
	while not soubor.eof_reached():
		# Načte aktuální řádek jako pole řetězců (automaticky rozděleno podle čárek)
		var radek: PackedStringArray = soubor.get_csv_line()
		
		# Ochrana proti prázdným řádkům (často na konci souboru)
		if radek.size() == 1 and radek[0] == "":
			continue

		# 4. Zpracování hlavičky (první řádek CSV)
		if je_prvni_radek:
			hlavicka = radek
			#print("Nalezená hlavička: ", hlavicka)
			je_prvni_radek = false
			continue

		# 5. Zpracování běžných datových řádků
		zpracuj_datovy_radek(hlavicka, radek)

	print("Import CSV dat byl úspěšně dokončen.")


func zpracuj_datovy_radek(hlavicka: PackedStringArray, radek: PackedStringArray) -> void:
	var jmeno: String
	var zaznam = {}
	for i in range(min(hlavicka.size(), radek.size())):
		match i:
			0:
				jmeno = radek[0]
			_:
				var klic = hlavicka[i]
				var hodnota = radek[i]
				zaznam[klic] = hodnota

	tabulka[jmeno] = zaznam
