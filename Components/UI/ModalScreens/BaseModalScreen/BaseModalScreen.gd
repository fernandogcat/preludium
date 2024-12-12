class_name BaseModalScreen
extends Control

signal on_closed(modal_screen: BaseModalScreen)

@onready var close_modal_button := %CloseModalButton

func _ready():
	show_modal_screen(false)
	if close_modal_button != null:
		close_modal_button.connect("pressed", _on_close_button_pressed)

func _input(event):
	if InputManager.check_input_key_exit_pressed(event):
		_on_close_button_pressed()

func is_showing() -> bool:
	return visible

func show_modal_screen(show_modal: bool):
	visible = show_modal
	set_process_input(show_modal)

func _on_close_button_pressed():
	on_closed.emit(self)
