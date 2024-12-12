class_name Bullet
extends Node2D

var speed = 400
var direction = Vector2()

func setup(_global_position: Vector2, _direction: Vector2):
	self.global_position = _global_position
	self.direction = _direction
	self.rotation = direction.angle()

func _process(delta):
	position.x += direction.x * speed * delta
	position.y += direction.y * speed * delta

	if position.x > get_viewport_rect().size.x:
		queue_free()
