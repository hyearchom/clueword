extends Button

var Databaze = preload("uid://dru12gn63xyxn")

@export var Vyber_souboru: Node
@export var Hra: Node

func _stisk() -> void:
	Vyber_souboru.zobrazit()
	Vyber_souboru.file_selected.connect(_nahrat_data)

func _nahrat_data(cesta:String) -> void:
	Databaze.importuj_csv(cesta)
	Hra.nova_hra()
	hide()
