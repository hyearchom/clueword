extends Resource

var soubor := {
	"adamant": {"preklad": "neoblomný"},
	"diligence": {"preklad": "pečlivost"},
	"jaded": {"preklad": "unavený"},
	"to retain": {"preklad": "zachovat"},
	"serendipitous": {"preklad": "náhodný"},
	"to engulf": {"preklad": "pohltit"},
	"illicit": {"preklad": "nedovolené"},
	"reluctance": {"preklad": "neochota"},
	"spiteful": {"preklad": "zlomyslný"}
}

var pismena: Array
var indicie := {}

var kolo := int(0)
var skore: int
var zivoty := int(9)


#func pridat_pismena(slovo: String) -> void:
	#for pismeno in slovo:
		#var velke_pismeno: String = pismeno.capitalize()
		#if velke_pismeno not in pismena:
			#pismena.append(velke_pismeno)
