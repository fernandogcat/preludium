class_name GameLoaderBootstrapScreen
extends BaseScreen

# var _bullets_pool_size = 200

# TODO: change to bullets
# @export var deck_tile_scene := preload("res://Components/Bullet/Bullet.tscn")

@export var min_time_to_wait: float = 0.6

# var _game_settings := SettingsManager.new()
var _start_loading_time: float

func _ready():
	var game_configuration := preload("res://Components/GameConfiguration/GameConfiguration.tres")
	game_configuration.setup()
	Globals.setup(game_configuration)
	# _game_settings.setup()
	
	# Globals.settings = _game_settings

	_start_loading()

func _start_loading():
	_start_loading_time = Time.get_unix_time_from_system()
	# await Flasher.setup(game_configuration.pool_size_flashes).finished
	# await TilesPool.build("DeckTilesPool", get_tree().get_root()).setup(deck_tile_scene,_bullets_pool_size).finished
	# await TilesPool.build("EnemyTilesPool", get_tree().get_root()).setup(enemy_tile_scene, game_configuration.pool_size_enemy_tiles).finished
	# await DeckTilesUIPool.build("PlayerDeckTilesUIPool", get_tree().get_root()).setup_tiles_ui(game_configuration.pool_size_player_tiles_ui).finished
	_on_loading_complete()

func _on_loading_complete():
	var now := Time.get_unix_time_from_system()
	var minimum_time_to_show_splash_screen := min_time_to_wait - (now - _start_loading_time)
	if minimum_time_to_show_splash_screen > 0:
		await get_tree().create_timer(minimum_time_to_show_splash_screen).timeout
	LoadSceneManager.new_screen_completed_loading.emit()

	var next_screen: LoadSceneManager.Screen
	if Globals.config.quick_skip_main_screen:
		next_screen = LoadSceneManager.Screen.GAME
	else:
		next_screen = LoadSceneManager.Screen.MAIN_MENU
	LoadSceneManager.load_scene(next_screen, LoadSceneManager.LOAD_ANIMATION_NONE, LoadSceneManager.LOAD_ANIMATION_OUTRO_DEFAULT)
