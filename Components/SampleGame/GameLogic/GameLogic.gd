class_name GameLogic
extends Node

@onready var ship := %Ship

func update_physics(delta):
	ship.check_attack()
	ship.move(delta)