extends Resource

var tabulka: Dictionary
var cesta_k_tabulce: String

var hlavicka: PackedStringArray = []


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
	
	cesta_k_tabulce = cesta
	
	var je_prvni_radek = true
	#var hlavicka: PackedStringArray = []
	
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
		zpracuj_datovy_radek(radek)

	#print("Import CSV dat byl úspěšně dokončen.")


func zpracuj_datovy_radek(radek: PackedStringArray) -> void:
	var jmeno: String
	var zaznam = {}
	for i in range(min(hlavicka.size(), radek.size())):
		match i:
			0:
				jmeno = radek[0]
			_:
				var klic = hlavicka[i]
				var hodnota = radek[i]
				if hodnota.is_valid_int():
					hodnota = int(hodnota)
				zaznam[klic] = hodnota

	tabulka[jmeno] = zaznam


func ulozit_tabulku() -> void:
	var soubor := FileAccess.open(cesta_k_tabulce, FileAccess.WRITE)
	if soubor == null:
		push_warning("Nelze otevřít soubor tabulky")
	
	#Hlavička
	soubor.store_csv_line(hlavicka)
	
	#Tělo
	for zaznam in tabulka:
		var radek: PackedStringArray = []
		radek.append(zaznam)
		for sloupec in hlavicka.slice(1):
			radek.append(str(tabulka[zaznam][sloupec]))
		soubor.store_csv_line(radek)
	soubor.close()


func zmenit_uroven(slovo: String, hodnota: int) -> void:
	tabulka[slovo].uroven += hodnota
	tabulka[slovo].uroven = max(0, tabulka[slovo].uroven)


func vybrat_procviceni(pocet:int) -> Array:
	if not tabulka.size():
		push_warning("První je potřeba import")
		return []
	var vyber: Array
	var kopie := tabulka.duplicate_deep()
	while true:
		var nejvyssi_uroven: int
		for zaznam in kopie:
			if tabulka[zaznam].uroven > nejvyssi_uroven:
				nejvyssi_uroven = tabulka[zaznam].uroven
		var zprehazeni = kopie.keys()
		zprehazeni.shuffle()
		for zaznam in zprehazeni:
			if tabulka[zaznam].uroven == nejvyssi_uroven:
				vyber.append(zaznam)
				kopie.erase(zaznam)
				if vyber.size() == pocet:
					return vyber
	# tohle je jen, aby byl ticho debugger
	return []
