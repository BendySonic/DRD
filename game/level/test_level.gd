extends Node

func _process(delta):
	if $World/Objects/lever.enabled == true:
		$CoolGuy/Victory.set_visible(true)
