class_name GameScreen
extends BaseScreen

@onready var game_logic := %GameLogic
@onready var pause_button := %PauseButton
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
			toggle_modal_screen(pause_modal_screen)
		return true

	return false

func show_modal_screen(modal_screen: BaseModalScreen, show_modal: bool):
	super.show_modal_screen(modal_screen, show_modal)
	pause_button.visible = !show_modal
	game_logic.pause_game(show_modal)

func _on_pause_button_pressed():
	toggle_modal_screen(pause_modal_screen)
