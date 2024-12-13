extends Node

func check_input_key_exit_pressed(event: InputEvent) -> bool:
	return event.is_action_pressed("key_exit")
