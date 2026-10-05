extends Control

const VRAH = preload("uid://ckleopg2441yi")

var Databaze = preload("uid://dru12gn63xyxn")
var Signaly = preload("uid://dsnr8er341thx")

@export var Linky: Node2D

var priradit_slova: Dictionary

#func _ready() -> void:
	#vybrat_preklady(3)

func vybrat_preklady(pocet:int) -> void:
	priradit_slova = Databaze.slova
	for poradi in pocet:
		var vrah = VRAH.instantiate()
		add_child(vrah)
		var slovo_data = volba_slova()
		priradit_slova.erase(slovo_data[0])
		vrah.prideleni(slovo_data[0], slovo_data[1])
		vrah.Linka = Linky.pridat(vrah.odstin)
	await get_tree().process_frame
	Signaly.vrazi_vybrani.emit()


func volba_slova() -> Array:
	var slovo = priradit_slova.keys()[randi_range(0, priradit_slova.size() -1)]
	var zaznam = priradit_slova[slovo]
	return [slovo, zaznam]
