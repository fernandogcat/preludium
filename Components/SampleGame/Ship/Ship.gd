class_name Ship
extends Node2D

const bullet_path = "res://Components/Bullet/Bullet.tscn"

@export var speed: float = 10

func check_attack():
	if !Input.is_action_just_pressed("fire"): return
	_fire_bullet()

func move(delta):
	var movement = _get_movement()
	if movement == Vector2.ZERO: return
	transform.origin += movement * speed * delta
	_update_direction(movement)

func _fire_bullet():
	var bullet := preload(bullet_path).instantiate()
	var direction := Vector2(1, 0).rotated(rotation)
	bullet.setup(global_position, direction)
	get_parent().add_child(bullet)

func _get_movement() -> Vector2:
	var movement = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	return movement.normalized()

func _update_direction(movement: Vector2):
	var angle_rad = movement.angle()
	rotation_degrees = angle_rad * 180 / PI