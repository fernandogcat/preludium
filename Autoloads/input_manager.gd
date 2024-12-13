extends Node

const KEY_EXIT = "key_exit"
const ACTION_SHOOT = "shoot"

func check_input_key_exit_pressed(event: InputEvent) -> bool:
	return event.is_action_pressed(KEY_EXIT)

func is_input_shoot_just_pressed() -> bool:
	return Input.is_action_just_pressed(InputManager.ACTION_SHOOT)