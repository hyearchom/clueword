extends HBoxContainer

var Databaze = preload("uid://dru12gn63xyxn")

const OBTIZNOST_SLOVA = 10

@onready var Original: LineEdit = $Original
@onready var Preklad: LineEdit = $Preklad
@onready var Pridat: Button = $Pridat


func _pridat_slovo() -> void:
	if not Original.text or not Preklad.text:
		return

	Databaze.pridat_zaznam(
		Original.text, 
		Preklad.text, 
		OBTIZNOST_SLOVA)
	vymazat_podklady()


func vymazat_podklady() -> void:
	Original.text = ""
	Preklad.text = ""
