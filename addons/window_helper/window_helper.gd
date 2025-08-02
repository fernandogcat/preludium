@tool
extends EditorPlugin

const WINDOW_HELPER_SCENE = preload("res://addons/window_helper/window_helper.tscn")
const GAME_SCREENS := preload("res://components/game_screens/data/game_screens.tres")

# A class member to hold the dock during the plugin life cycle.
var dock

var _load_screen_button: OptionButton

func _enter_tree():
	dock = WINDOW_HELPER_SCENE.instantiate()

	add_control_to_dock(DOCK_SLOT_LEFT_BR, dock)

func _ready():
	_load_screen_button = dock.get_node("%LoadScreenButton")
	_fill_scene_button_with_scenes()
	_load_screen_button.connect("item_selected", _on_load_scene_button_selected)

func _exit_tree():
	remove_control_from_docks(dock)
	dock.free()

func _fill_scene_button_with_scenes():
	_load_screen_button.clear()
	for screen_key in GameScreens.Screen.keys():
		_load_screen_button.add_item(screen_key, GameScreens.Screen[screen_key])

func _on_load_scene_button_selected(screen_option: GameScreens.Screen):
	var screen_path = GAME_SCREENS.get_screen_path(screen_option)
	EditorInterface.open_scene_from_path(screen_path)