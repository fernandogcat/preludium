class_name GameLogic
extends Node

var game_state: GameState

@onready var ship := %Ship

func _ready():
	ship.ship_shot.connect(_on_ship_shot)
	game_state = GameState.new()
	start_game()

func reset_game():
	game_state.set_state_wait()

func pause_game(pause: bool):
	if pause:
		game_state.set_state_wait()
	else:
		game_state.set_state_player_turn()

func start_game():
	game_state.set_state_player_turn()

func update_physics(delta):
	if !game_state.is_player_turn(): return
	ship.check_input_move(delta)
	ship.check_input_shoot()

func _on_ship_shot(start_global_position: Vector2, direction: Vector2):
	var bullet := Bullet.build().setup(start_global_position, direction)
	add_child(bullet)
	bullet.start_self_destruction_timeout()