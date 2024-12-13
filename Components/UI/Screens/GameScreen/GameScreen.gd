class_name GameScreen
extends BaseScreen

@onready var game_logic := %GameLogic
@onready var pause_modal_screen := %PauseModalScreen

func _input(event: InputEvent):
	if _check_ui_actions_input(event):
		return

func _physics_process(delta):
	game_logic.update_physics(delta)

func _check_ui_actions_input(event: InputEvent) -> bool:
	if InputManager.check_input_key_exit_pressed(event):
		if Globals.config.quick_exit_game:
			LoadSceneManager.exit_game()
		else:
			show_modal_screen(pause_modal_screen)
		return true

	return false

func _on_pause_button_pressed():
	show_modal_screen(pause_modal_screen)
