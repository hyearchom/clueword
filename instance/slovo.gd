extends HBoxContainer

var Databaze = preload("uid://dru12gn63xyxn")

@onready var Original: Label = $Original
@onready var Preklad: Label = $Preklad
@onready var dvojice := [Original, Preklad]

@onready var Chyby := get_tree().get_first_node_in_group("chyby")

var original: String
var preklad: String
var dvojice_vyrok: Array

var hadanka: int
var vyreseno: bool


func nova_hadanka(originalni_vyrok:String, prelozeny_vyrok:String) -> void:
	original = originalni_vyrok
	preklad = prelozeny_vyrok
	dvojice_vyrok = [original, preklad]
	
	Original.text = original
	Preklad.text = preklad
	
	hadanka = randi_range(0,1)
	dvojice[hadanka].text = zakodovat(dvojice[hadanka].text)
	
	Databaze.zmenit_uroven(original, Chyby.MAXIMUM -1)

func zakodovat(slovo: String) -> String:
	var tajemka: String = ""
	for pismeno in slovo:
		tajemka += " " if pismeno == " " else "*"
	return tajemka


func odhalit(pismeno: String) -> bool:
	var hadany_vyrok: String = dvojice_vyrok[hadanka]
	var pozice: Array[int]
	if pismeno in hadany_vyrok:
		pozice = najdi_vsechny(hadany_vyrok, pismeno)
	if pozice:
		zviditelnit(pismeno, pozice)
		return true
	return false


# Vrátí indexy všech výskytů písmene ve slově
func najdi_vsechny(slovo: String, pismeno: String) -> Array[int]:
	var vysledek: Array[int] = []
	var pozice: int = slovo.findn(pismeno)
	while pozice != -1:
		vysledek.append(pozice)
		pozice = slovo.findn(pismeno, pozice + 1)
	return vysledek


func zviditelnit(pismeno: String, seznam_pozic: Array):
	var hadane_slovo: Label = dvojice[hadanka]
	for pozice: int in seznam_pozic:
		hadane_slovo.text[pozice] = pismeno
	if not "*" in hadane_slovo.text:
		vyreseno = true
		Databaze.zmenit_uroven(original, -Chyby.pocet +Chyby.MAXIMUM)
		#Databaze.ulozit_tabulku()
