extends Node2D

const LINKA = preload("uid://7ff6a413268l")

func pridat(odstin:Color) -> Line2D:
	var linka = LINKA.instantiate()
	add_child(linka)
	linka.default_color = odstin
	return linka
