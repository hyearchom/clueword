extends FileDialog


func _ready() -> void:
	access = FileDialog.ACCESS_FILESYSTEM
	#current_dir = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	canceled.connect(vycistit)
	file_selected.connect(vycistit.unbind(1))
	dir_selected.connect(vycistit.unbind(1))


func zobrazit() -> void:
	show()
	popup()
	file_mode = FileDialog.FILE_MODE_OPEN_FILE
	filters = PackedStringArray(["*.csv; Tabulka"])
	#else:
		#file_mode = FileDialog.FILE_MODE_OPEN_DIR
		#filters = PackedStringArray([])


func vycistit() -> void:
	clear_filters()
	current_file = ""
	current_path = ""
	deselect_all()
