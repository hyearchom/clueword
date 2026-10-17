extends MarginContainer

var Databaze = preload("uid://dru12gn63xyxn")
const SLOVO = preload("uid://cr6vo1c5td7pw")

@onready var Slova: VBoxContainer = $Prvky/Slova

var vybrano: Array
var hadana_slova: int


func nove_kolo() -> void:
	var slova = Databaze.vybrat_procviceni(hadana_slova)
	for vyber in slova:
		var slovo = SLOVO.instantiate()
		Slova.add_child(slovo)
		slovo.nova_hadanka(vyber, Databaze.tabulka[vyber].preklad)


func _exit_tree() -> void:
	Databaze.ulozit_tabulku()
