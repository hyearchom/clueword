extends Label

signal prohra

const MAXIMUM_CHYB = 5

@export var Hadani: Node

func _ready() -> void:
	Hadani.chyba.connect(_pridat_chybu)

func _pridat_chybu() -> void:
	text += "X"
	_overit_konec()

func _overit_konec() -> void:
	if len(text) > MAXIMUM_CHYB:
		prohra.emit()

func vynulovat() -> void:
	text = ""
