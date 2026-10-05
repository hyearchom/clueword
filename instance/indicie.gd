extends PanelContainer

@onready var Pismeno: TextEdit = $Pismeno

var hadanka: String

func _ready() -> void:
	Pismeno.text_changed.connect(omezit_zapis)
	Pismeno.focus_entered.connect(vymazat_text)


func omezit_zapis() -> void:
	if not Pismeno.text:
		return
	Pismeno.text = Pismeno.text[0].capitalize()


func vymazat_text() -> void:
	Pismeno.clear()
