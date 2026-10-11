extends Node

@onready var Mapa: MarginContainer = $Mapa
@onready var Hadani: Node = $Mapa/Hadani
@onready var Stav: VBoxContainer = $Mapa/Prvky/Stav
@onready var Chyby: Label = Stav.get_node(^"Chyby")
@onready var Oznameni: Label = Stav.get_node(^"Oznameni")
@onready var Pouzita: Label = $Mapa/Prvky/Stav/Pouzita/Pismena


func _ready() -> void:
	#_nova_hra()
	Chyby.prohra.connect(konec_hry)
	Hadani.vyhra.connect(kolo_vyreseno)


func konec_hry() -> void:
	Hadani.aktivace(false)
	vypsat("Konec hry")


func vypsat(vyrok: String) -> void:
	Oznameni.text = vyrok


func kolo_vyreseno() -> void:
	Hadani.aktivace(false)
	vypsat("Výhra")


func nova_hra() -> void:
	get_tree().call_group(&"slova", "queue_free")
	vypsat("")
	Pouzita.text = ""
	Chyby.vynulovat()
	Mapa.nove_kolo()
	Hadani.aktivace(true)


func zavrit() -> void:
	get_tree().quit()
