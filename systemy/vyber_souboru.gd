extends FileDialog


func _ready() -> void:
	use_native_dialog = true
	access = FileDialog.ACCESS_FILESYSTEM
	file_mode = FileDialog.FILE_MODE_OPEN_FILE
	filters = PackedStringArray(["*.csv; Tabulka"])
	#current_dir = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	canceled.connect(vycistit)
	file_selected.connect(vycistit.unbind(1))
	dir_selected.connect(vycistit.unbind(1))


func zobrazit() -> void:
	show()


func vycistit() -> void:
	hide()
	clear_filters()
	current_file = ""
	current_path = ""
	deselect_all()
	
