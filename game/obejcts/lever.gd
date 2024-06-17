extends StaticBody2D

var enabled = false

func _process(delta):
	if get_node("Player_Detected").player == true:
		print(true)
		$E.set_visible(true)
	if get_node("Player_Detected").player == false:
		$E.set_visible(false)
	if get_node("Action_E").action_e == true:
		enabled = true
