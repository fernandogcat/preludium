class_name GameEntrypoint
extends Node

func _ready():
	LoadSceneManager.load_scene(
		GameScreens.Screen.INITIAL_BOOTSTRAP,
		LoadSceneManager.LOAD_ANIMATION_NONE,
	)
