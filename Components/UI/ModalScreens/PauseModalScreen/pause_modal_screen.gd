class_name PauseModalScreen
extends BaseModalScreen

func _on_main_menu_button_pressed():
	LoadSceneManager.load_scene(LoadSceneManager.Screen.MAIN_MENU)

func _on_exit_button_pressed():
	LoadSceneManager.exit_game()
