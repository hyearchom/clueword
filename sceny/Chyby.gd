extends Label

signal prohra

const MAXIMUM = 5
var pocet: int = 0

@export var Hadani: Node


func _ready() -> void:
	Hadani.chyba.connect(_pridat_chybu)


func _pridat_chybu() -> void:
	pocet += 1
	text += "X"
	_overit_konec()


func _overit_konec() -> void:
	if len(text) > MAXIMUM:
		prohra.emit()


func vynulovat() -> void:
	pocet = 0
	text = ""
