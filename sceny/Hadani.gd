extends Node

signal chyba
signal vyhra

var souhrn_odpovedi: Array

func _ready() -> void:
	aktivace(false)
	zobrazit_klavesnici()


func _unhandled_key_input(event: InputEvent) -> void:
	var klavesa = event.as_text_key_label().to_lower()
	if event.is_released():
		for slovo: Node in get_tree().get_nodes_in_group(&"slova"):
			var overeni = slovo.odhalit(klavesa)
			souhrn_odpovedi.append(overeni)
		_vyhodnotit_odpovedi()
		souhrn_odpovedi.clear()
		_overit_vyhru()


func aktivace(stav:bool) -> void:
	set_process_unhandled_key_input(stav)
	
func zobrazit_klavesnici() -> void:
	DisplayServer.virtual_keyboard_show(
		"",                                   # existing text
		Rect2(),                              # position (ignored on Android)
		DisplayServer.KEYBOARD_TYPE_DEFAULT,  # or _NUMBER, _EMAIL_ADDRESS, ...
		-1,                                   # max length (-1 = unlimited)
		-1, -1                                # cursor start/end
	)

func _vyhodnotit_odpovedi() -> void:
	if true in souhrn_odpovedi:
		return
	else:
		chyba.emit()


func _overit_vyhru() -> void:
	var podminka: Array
	for slovo: Node in get_tree().get_nodes_in_group(&"slova"):
		podminka.append(slovo.vyreseno)
	if not false in podminka:
		vyhra.emit()
