extends Node

var player = false

func _on_body_entered(body):
	player = true
func _on_body_exited(body):
	player = false
