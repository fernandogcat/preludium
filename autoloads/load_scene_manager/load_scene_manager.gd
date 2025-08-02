extends Node

signal progress_changed(progress)
signal new_screen_loading_completed

const LOADING_SCREEN := preload("res://components/ui/screens/loading_screen/data/loading_screen.tscn")

const LOAD_ANIMATION_NONE := ""
const LOAD_ANIMATION_INTRO_DEFAULT := "swipe_in_from_right"
const LOAD_ANIMATION_OUTRO_DEFAULT := "swipe_out_to_right"

var _game_screens := preload("res://components/game_screens/data/game_screens.tres")

var _next_screen_path: String
var _progress := []

func _ready():
	set_process(false)

func load_scene(
	next_screen: GameScreens.Screen,
	intro_animation: String = LoadSceneManager.LOAD_ANIMATION_INTRO_DEFAULT,
	outro_animation: String = LoadSceneManager.LOAD_ANIMATION_OUTRO_DEFAULT,
	) -> void:
	_next_screen_path = _game_screens.get_screen_path(next_screen)

	var new_loading_screen = LOADING_SCREEN.instantiate()
	new_loading_screen.setup(intro_animation, outro_animation)
	get_tree().get_root().add_child.call_deferred(new_loading_screen)

	progress_changed.connect(new_loading_screen.update_progress_bar)
	new_screen_loading_completed.connect(new_loading_screen.start_outro_animation)

	await new_loading_screen.loading_screen_coverage_completed
	_start_load()

func _start_load() -> void:
	var use_sub_threads := false
	var state = ResourceLoader.load_threaded_request(_next_screen_path, "", use_sub_threads)
	if state == OK:
		set_process(true)

func _process(_delta):
	var load_status := ResourceLoader.load_threaded_get_status(_next_screen_path, _progress)
	# TODO: Logger.debug
	match load_status:
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED:
			assert(false, "LoadSceneManager failed to load scene: " + _next_screen_path)
			set_process(false)
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			progress_changed.emit(_progress[0])
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			var load_resource := ResourceLoader.load_threaded_get(_next_screen_path)
			progress_changed.emit(1.0)
			var load_result = get_tree().change_scene_to_packed(load_resource)
			if load_result != OK:
				assert(false, "LoadSceneManager failed to change scene to packed: " + _next_screen_path)
			set_process(false)
			# get_current_scene() returns null until next frame
			await get_tree().process_frame
			var current_screen = get_tree().get_current_scene()
			# scene may continue loading after scene changed, until calling `new_screen_loading_completed` signal is emitted
			var is_a_base_screen = current_screen as BaseScreen
			if !is_a_base_screen or !current_screen.handle_finish_loading_manually:
				new_screen_loading_completed.emit()

func exit_game():
	get_tree().quit()
