class_name SettingsManager

func toggle_fullscreen_mode():
	var change_to_fullscreen = is_windowed()
	set_fullscreen(change_to_fullscreen)

static func set_fullscreen(fullscreen: bool):
	var next_mode: DisplayServer.WindowMode = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED
	_set_window_mode(next_mode)

static func _set_window_mode(window_mode: DisplayServer.WindowMode):
	DisplayServer.window_set_mode(window_mode)

static func is_fullscreen() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN

static func is_windowed() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED
