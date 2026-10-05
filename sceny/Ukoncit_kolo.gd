extends Button

var Databaze = preload("uid://dru12gn63xyxn")

func _stisk() -> void:
	Databaze.kolo += 1
	get_tree().call_group("vrazi", "pohyb")
