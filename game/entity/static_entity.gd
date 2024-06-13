class_name StaticEntity extends StaticBody2D

@onready var health_component = $HealthComponent

func _ready():
	health_component.health_end.connect(destroy)

func destroy():
	queue_free()
