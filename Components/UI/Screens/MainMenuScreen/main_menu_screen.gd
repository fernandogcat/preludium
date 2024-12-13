class_name MainMenuScreen
extends BaseScreen

@onready var version_label: Label = %VersionLabel
@onready var settings_modal_screen := %SettingsModalScreen

func _ready():
	version_label.text = Globals.config.version

func _input(event):
	_check_ui_actions_input(event)

func _check_ui_actions_input(event: InputEvent):
	if InputManager.check_input_key_exit_pressed(event):
		_pressed_exit()

func _on_start_game_button_pressed():
	LoadSceneManager.load_scene(LoadSceneManager.Screen.GAME)

func _on_settings_button_pressed():
	toggle_modal_screen(settings_modal_screen)

func _on_exit_button_pressed():
	_pressed_exit()

func _pressed_exit():
	LoadSceneManager.exit_game()
