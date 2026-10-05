extends HFlowContainer

var Databaze = preload("uid://dru12gn63xyxn")
var Signaly = preload("uid://dsnr8er341thx")

const INDICIE = preload("uid://c387mgkjc8npx")

func _ready() -> void:
	Signaly.vrazi_vybrani.connect(vybrat_pismena)


func nahodne_rozlozeni_stop() -> void:
	var max_vychylka := 45
	
	for indicie in get_children():
		var nahodny_vektor = Vector2i(
		randi_range(-max_vychylka, max_vychylka),
		randi_range(-max_vychylka, max_vychylka)
		)
		var vyhodnoceni := []
		for osa in [0, 1]:
			var podminka = (indicie.global_position[osa] + 2* nahodny_vektor[osa])
			vyhodnoceni.append(podminka > 0 and podminka < get_size()[osa])
		if not false in vyhodnoceni:
			indicie.offset_transform_position = nahodny_vektor
			indicie.Pismeno.offset_transform_position = nahodny_vektor

func vybrat_pismena() -> void:
	var vyber_pismen: Array = Databaze.pismena
	for poradi in vyber_pismen.size():
		var pismeno = vyber_pismen.pick_random()
		vyber_pismen.erase(pismeno)
		var indicie = INDICIE.instantiate()
		indicie.hadanka = pismeno
		add_child(indicie)
		Databaze.indicie[pismeno] = indicie
	await get_tree().process_frame
	nahodne_rozlozeni_stop()
	Signaly.indicie_vybrany.emit()
	
