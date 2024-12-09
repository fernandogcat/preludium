class_name ToggleFullscreenButton
extends CheckButton

func _ready():
	visibility_changed.connect(_on_visibility_changed)
	toggled.connect(_on_toggled_pressed)

func _on_visibility_changed():
	if !visible: return
	var set_toggle_to_fullscreen := Globals.settings.is_fullscreen()
	set_pressed_no_signal(set_toggle_to_fullscreen)

func _on_toggled_pressed(_pressed: bool):
	Globals.settings.set_fullscreen(_pressed)