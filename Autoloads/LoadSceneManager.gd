extends Node

const loading_screen := preload("res://Components/UI/Screens/LoadingScreen/LoadingScreen.tscn")

const LOAD_ANIMATION_NONE := ""
const LOAD_ANIMATION_INTRO_DEFAULT := "swipe_in_from_right"
const LOAD_ANIMATION_OUTRO_DEFAULT := "swipe_out_to_right"

enum Screen {
	INITIAL_BOOTSTRAP = 0,
	MAIN_MENU = 1,
	GAME = 2,
}

signal progress_change(progress)
signal new_screen_completed_loading

@export var screen_paths: Dictionary # [ScreenNameString: ScenePathString]

var use_sub_threads: bool = false

var _next_screen_path: String
var _progress: Array = []

func _ready():
	set_process(false)

func load_scene(
	next_screen: Screen,
	intro_animation: String = LoadSceneManager.LOAD_ANIMATION_INTRO_DEFAULT,
	outro_animation: String = LoadSceneManager.LOAD_ANIMATION_OUTRO_DEFAULT,
	) -> void:
	var screen_path_string_key := EnumUtils.get_string_name_from_value(Screen, next_screen)
	if !screen_paths.has(screen_path_string_key):
		assert(false, "load_scene. Not found screen path for: [%s]. Check adding it to LoadSceneManager.screen_paths scene" % screen_path_string_key)
	_next_screen_path = screen_paths[screen_path_string_key]

	var new_loading_screen = loading_screen.instantiate()
	new_loading_screen.setup(intro_animation, outro_animation)
	get_tree().get_root().add_child.call_deferred(new_loading_screen)
	
	progress_change.connect(new_loading_screen.update_progress_bar)
	new_screen_completed_loading.connect(new_loading_screen.start_outro_animation)
	
	await new_loading_screen.loading_screen_has_full_coverage
	_start_load()

func _start_load() -> void:
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
			progress_change.emit(_progress[0])
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			var load_resource := ResourceLoader.load_threaded_get(_next_screen_path)
			progress_change.emit(1.0)
			var _result = get_tree().change_scene_to_packed(load_resource)
			set_process(false)
			# get_current_scene() returns null until next frame
			await get_tree().process_frame
			var current_screen = get_tree().get_current_scene()
			# scene may continue loading after scene changed, until calling `new_screen_completed_loading` signal is emitted
			var is_a_base_screen = current_screen as BaseScreen
			if !is_a_base_screen or !current_screen.handle_finish_loading_manually:
				new_screen_completed_loading.emit()

func exit_game():
	get_tree().quit()
