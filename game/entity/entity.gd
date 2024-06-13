class_name Entity extends CharacterBody2D

@onready var health_component = $HealthComponent

func _ready():
	health_component.health_end.connect(die)

func die():
	queue_free()
