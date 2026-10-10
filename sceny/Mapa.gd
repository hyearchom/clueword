extends MarginContainer

var Databaze = preload("uid://dru12gn63xyxn")
const SLOVO = preload("uid://cr6vo1c5td7pw")

@onready var Slova: VBoxContainer = $Prvky/Slova

var vybrano: Array

func nove_kolo() -> void:
	for pocet in range(3):
		var slovo = SLOVO.instantiate()
		Slova.add_child(slovo)
		var zaznam = vybrat_zaznam()
		slovo.nova_hadanka(zaznam, Databaze.tabulka[zaznam].preklad)
		

func vybrat_zaznam() -> String:
	var zaznam: String
	while true: 
		zaznam = Databaze.tabulka.keys().pick_random()
		if zaznam not in vybrano:
			break
	vybrano.append(zaznam)
	return zaznam
