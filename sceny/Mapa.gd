extends MarginContainer

var Databaze = preload("uid://dru12gn63xyxn")
const SLOVO = preload("uid://cr6vo1c5td7pw")

@onready var Slova: VBoxContainer = $Prvky/Slova

var vybrano: Array

func nove_kolo() -> void:
	var slova = Databaze.vybrat_procviceni(3)
	for vyber in slova:
		var slovo = SLOVO.instantiate()
		Slova.add_child(slovo)
		slovo.nova_hadanka(vyber, Databaze.tabulka[vyber].preklad)
		

#func vybrat_zaznam() -> String:
	#var zaznam: String
	#while true: 
		#zaznam = Databaze.tabulka.keys().pick_random()
		#if zaznam not in vybrano:
			#break
	#vybrano.append(zaznam)
	#return zaznam


func _exit_tree() -> void:
	Databaze.ulozit_tabulku()
