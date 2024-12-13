class_name BaseScreen
extends Node

## Used to let the new screen keep loading stuff while LoadingScreen is shown.
## When the new screen is ready, its their responsibility to emit
## the signal `LoadSceneManager.new_screen_loading_completed` manually
@export var handle_finish_loading_manually: bool = false

func toggle_modal_screen(modal_screen: BaseModalScreen) -> bool:
	var show_modal = !modal_screen.is_showing()
	show_modal_screen(modal_screen, show_modal)
	return show_modal

func _on_modal_screen_closed(modal_screen: BaseModalScreen):
	show_modal_screen(modal_screen, false)

func show_modal_screen(modal_screen: BaseModalScreen, show_modal: bool):
	if show_modal:
		var node_focused = get_viewport().gui_get_focus_owner()
		if node_focused != null:
			node_focused.release_focus()
		if !modal_screen.on_closed.is_connected(_on_modal_screen_closed):
			modal_screen.on_closed.connect(_on_modal_screen_closed)
	set_process_input(!show_modal)
	modal_screen.show_modal_screen(show_modal)