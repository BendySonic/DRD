class_name StaticEntity extends StaticBody2D

@onready var health_component = $HealthComponent

func _ready():
	health_component.health_end.connect(destroy)

func _process(delta):
	if get_node("Player_Detected").player == true:
		print(true)
		$E.set_visible(true)
	if get_node("Player_Detected").player == false:
		$E.set_visible(false)
	if get_node("Action_E").action_e == true:
		destroy()

func destroy():
	queue_free()
