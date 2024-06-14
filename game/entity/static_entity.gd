class_name StaticEntity extends StaticBody2D

@onready var health_component = $HealthComponent

func _ready():
	health_component.health_end.connect(destroy)

func destroy():
	print(randi_range(1,4))
	queue_free()
