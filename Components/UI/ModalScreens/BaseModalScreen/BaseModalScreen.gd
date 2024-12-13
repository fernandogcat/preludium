class_name BaseModalScreen
extends Control

signal on_closed

@onready var close_modal_button := %CloseModalButton

func _ready():
	show_modal_screen(false)
	close_modal_button.connect("pressed", _on_close_button_pressed)

func _input(event):
	if InputManager.check_input_key_exit_pressed(event):
		_on_close_button_pressed()

func is_showing() -> bool:
	return visible

func show_modal_screen(_show: bool):
	visible = _show
	set_process_input(_show)

func _on_close_button_pressed():
	on_closed.emit()
	show_modal_screen(false)
