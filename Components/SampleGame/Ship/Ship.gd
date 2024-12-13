class_name Ship
extends Node2D

signal ship_shot(start_global_position: Vector2, direction: Vector2)

@export var speed: float = 10

var num_shots := 0

func check_input_move(delta):
	var input_movement := _get_input_movement()
	if input_movement == Vector2.ZERO: return
	transform.origin += input_movement * speed * delta
	_update_direction(input_movement)

func check_input_shoot():
	if InputManager.is_input_shoot_just_pressed():
		perform_shoot()

func perform_shoot():
	var direction := Vector2(1, 0).rotated(rotation)
	ship_shot.emit(global_position, direction)
	num_shots += 1

func _get_input_movement() -> Vector2:
	var movement = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	return movement.normalized()

func _update_direction(movement: Vector2):
	var angle_rad = movement.angle()
	rotation_degrees = angle_rad * 180 / PI