class_name HealthComponent extends Node

@export var max_health: int
@onready var health: int = max_health

signal health_changed(delta)
signal health_end()

func damage(attack: Attack):
	health = max(health-attack.damage, 0)
	
	if health != 0:
		health_changed.emit(attack.damage) 
	else:
		health_end.emit()
