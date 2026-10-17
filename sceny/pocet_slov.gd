extends HBoxContainer

@onready var Mapa: MarginContainer = get_node("/root/Hra/Mapa")
@onready var Pocet: Label = $Pocet

var pocet_slov := int(3)
const MAXIMUM_SLOV = 15


func _ready() -> void:
	nastavit()


func zmenit(mira:int) -> void:
	pocet_slov += mira
	pocet_slov = clamp(pocet_slov, 1, MAXIMUM_SLOV)
	nastavit()
	aktualizovat()


func aktualizovat() -> void:
	Pocet.text = str(pocet_slov)


func nastavit() -> void:
	Mapa.hadana_slova = pocet_slov
