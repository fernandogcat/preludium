class_name BaseScreen
extends Node

## Used to let the new screen keep loading stuff while LoadingScreen is shown. When the new screen is ready, its their responsibility to emit the signal `LoadSceneManager.new_screen_completed_loading` manually.
@export var handle_finish_loading_manually: bool = false

func toggle_modal_screen(modal_screen: BaseModalScreen) -> bool:
	var _show = !modal_screen.is_showing()
	show_modal_screen(modal_screen, _show)
	return _show

func show_modal_screen(modal_screen: BaseModalScreen, show: bool = true):
	if show:
		set_process_input(false)
		var node_focused = get_viewport().gui_get_focus_owner()
		if node_focused != null:
			node_focused.release_focus()
		if !modal_screen.on_closed.is_connected(_on_modal_screen_closed):
			modal_screen.on_closed.connect(_on_modal_screen_closed)
	modal_screen.show_modal_screen(show)

func _on_modal_screen_closed():
	set_process_input(true)