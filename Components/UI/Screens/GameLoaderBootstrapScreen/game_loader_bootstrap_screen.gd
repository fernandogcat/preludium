class_name GameLoaderBootstrapScreen
extends BaseScreen

@export var min_time_to_wait: float = 0.6

var _start_loading_time: float

func _ready():
	_start_loading()

func _start_loading():
	_start_loading_time = Time.get_unix_time_from_system()
	Globals.setup()
	_on_loading_complete()

func _on_loading_complete():
	var now := Time.get_unix_time_from_system()
	var minimum_time_to_show_splash_screen := min_time_to_wait - (now - _start_loading_time)
	if minimum_time_to_show_splash_screen > 0:
		await get_tree().create_timer(minimum_time_to_show_splash_screen).timeout
	LoadSceneManager.new_screen_loading_completed.emit()

	var next_screen: LoadSceneManager.Screen
	if Globals.config.quick_skip_main_screen:
		next_screen = LoadSceneManager.Screen.GAME
	else:
		next_screen = LoadSceneManager.Screen.MAIN_MENU
	LoadSceneManager.load_scene(next_screen, LoadSceneManager.LOAD_ANIMATION_NONE, LoadSceneManager.LOAD_ANIMATION_OUTRO_DEFAULT)
