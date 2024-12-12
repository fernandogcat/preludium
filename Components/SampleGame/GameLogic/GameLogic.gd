class_name GameLogic
extends Node

@onready var ship := %Ship

func _ready():
	ship.ship_shot.connect(_on_ship_shot)

func update_physics(delta):
	ship.check_move(delta)
	ship.check_shoot_input()

func _on_ship_shot(start_global_position: Vector2, direction: Vector2):
	var bullet := Bullet.build().setup(start_global_position, direction)
	add_child(bullet)
	bullet.start_self_destruction_timeout()