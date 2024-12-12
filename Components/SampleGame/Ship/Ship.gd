class_name Ship
extends Node2D

signal ship_shot(start_global_position: Vector2, direction: Vector2)

@export var speed: float = 10

var num_shots = 0

func check_shoot_input():
	if !Input.is_action_just_pressed("shoot"): return
	perform_shoot()

func check_move(delta):
	var movement = _get_movement()
	if movement == Vector2.ZERO: return
	transform.origin += movement * speed * delta
	_update_direction(movement)

func perform_shoot():
	var direction := Vector2(1, 0).rotated(rotation)
	ship_shot.emit(global_position, direction)
	num_shots += 1

func _get_movement() -> Vector2:
	var movement = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	return movement.normalized()

func _update_direction(movement: Vector2):
	var angle_rad = movement.angle()
	rotation_degrees = angle_rad * 180 / PI