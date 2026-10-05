extends Control

var Databaze = preload("uid://dru12gn63xyxn")
var Signaly = preload("uid://dsnr8er341thx")

var barvy := [
	"#dd5184",
	"#a75699",
	"#6c5994",
	"#3e547b",
	"#2f4858",
	]
var odstin: Color

@onready var Odhaleno: Label = $Okraje/Dole/Udaje/Odhaleno
@onready var Preklad: Label = $Okraje/Dole/Udaje/Preklad
@onready var Ikona: Polygon2D = $Ikona
@onready var Osa: Marker2D = $Osa
var Linka: Line2D

var hadanka := ""
var soucasna_indicie: Object

func _ready() -> void:
	add_to_group(&"vrazi")
	nastavit_barvu()
	Signaly.indicie_vybrany.connect(pohyb)
	Signaly.vrazi_vybrani.connect(vyznacit_bod)

func nastavit_barvu() -> void:
	odstin = Color(barvy[get_index()])
	Ikona.color = odstin

func registrovat_pismena() -> void:
	Databaze.pridat_pismena(hadanka)

func prideleni(slovo, zaznam) -> void:
	hadanka = slovo
	var hvezdy: String = ""
	for znak in range(len(hadanka)):
		hvezdy += "*"
	Odhaleno.text = hvezdy
	Preklad.text = zaznam["preklad"]
	registrovat_pismena()

func pohyb() -> void:
	print(hadanka)
	if Databaze.kolo < len(hadanka):
		var nazev_cile = hadanka[Databaze.kolo].capitalize()
		var cilova_indicie = Databaze.indicie[nazev_cile]
		Linka.add_point(cilova_indicie.global_position +cilova_indicie.size /2)
		overeni()
		soucasna_indicie = cilova_indicie
	else:
		vyhodnoceni()
		call_deferred(&"queue_free")

func vyznacit_bod(pozice:=Vector2.ZERO) -> void:
	if pozice:
		Linka.add_point(pozice)
	else:
		Linka.add_point(Osa.global_position)

func overeni() -> void:
	var poradi_pismene := int(0)
	for pismeno in hadanka:
		var zadano = Databaze.indicie[pismeno.capitalize()].Pismeno.text
		if zadano and pismeno.capitalize() == zadano:
			Odhaleno.text[poradi_pismene] = pismeno.capitalize()
		poradi_pismene += 1

func vyhodnoceni() -> void:
	overeni()
	#overeni(hadanka[Databaze.kolo -1].capitalize(), soucasna_indicie, Databaze.kolo -1)
	if not "*" in Odhaleno.text:
		Databaze.skore += 1
	else:
		Databaze.zivoty -= 1
	printt(Databaze.skore, Databaze.zivoty)


func stisk() -> void:
	Linka.visible = !Linka.visible

func _exit_tree() -> void:
	Linka.queue_free()
