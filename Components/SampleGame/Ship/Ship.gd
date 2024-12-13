class_name Ship
extends Node2D

@export var speed: float = 10

func move(delta):
	var movement = _get_movement()
	transform.origin += movement * speed * delta
	_update_direction(movement)

func _get_movement() -> Vector2:
	var movement = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	return movement.normalized()

func _update_direction(movement: Vector2):
	if movement == Vector2.ZERO: return
	var angle_rad = movement.angle()
	rotation_degrees = angle_rad * 180 / PI