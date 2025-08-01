@tool

class_name GameScreens
extends Resource

enum Screen {
	INITIAL_BOOTSTRAP = 0,
	MAIN_MENU = 1,
	GAME = 2,
}

@export var screen_paths: Dictionary # [ScreenNameString: ScenePathString]

func get_screen_path(screen: GameScreens.Screen) -> String:
	var screen_path_string_key := EnumUtils.get_string_name_from_value(GameScreens.Screen, screen)
	if !screen_paths.has(screen_path_string_key):
		assert(false, "Not found screen path for: [%s]. Check adding it to GameScreens.Screen_paths scene" % screen_path_string_key)
	return screen_paths[screen_path_string_key]
