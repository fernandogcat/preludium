class_name SettingsManager

var settings_data: SettingsData
var save_data_path := "user://game_data/"
var settings_filename := "settings_data.tres"
var settings_file_path := save_data_path + settings_filename

func setup():
	_load_settings()

	if settings_data != null:
		_set_window_mode(settings_data.window_mode)

func toggle_fullscreen_mode():
	var change_to_fullscreen = is_windowed()
	set_fullscreen(change_to_fullscreen)

func set_fullscreen(fullscreen: bool):
	var next_mode: DisplayServer.WindowMode = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED
	_set_window_mode(next_mode)

func _set_window_mode(window_mode: DisplayServer.WindowMode):
	DisplayServer.window_set_mode(window_mode)
	settings_data.window_mode = window_mode
	_save_settings()

func is_fullscreen() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN

func is_windowed() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED

func _load_settings():
	if !DirAccess.dir_exists_absolute(save_data_path):
		DirAccess.make_dir_absolute(save_data_path)

	if ResourceLoader.exists(settings_file_path):
		settings_data = ResourceLoader.load(settings_file_path)

	if settings_data == null:
		settings_data = SettingsData.new()
		_save_settings()

func _save_settings():
	ResourceSaver.save(settings_data, settings_file_path)