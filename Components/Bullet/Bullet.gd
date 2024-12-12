class_name Bullet
extends Node2D

const bullet_path = "res://Components/Bullet/Bullet.tscn"

var speed = 400
var direction = Vector2()

static func build() -> Bullet:
	var bullet := preload(bullet_path).instantiate()
	return bullet

func setup(_global_position: Vector2, _direction: Vector2) -> Bullet:
	self.global_position = _global_position
	self.direction = _direction
	self.rotation = direction.angle()
	return self

func start_self_destruction_timeout():
	get_tree().create_timer(3.0).connect("timeout", func(): queue_free())

func _process(delta):
	position.x += direction.x * speed * delta
	position.y += direction.y * speed * delta