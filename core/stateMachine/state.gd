class_name State extends Node

var state_machine: StateMachine
var object: Object

func enter(object: Object, state_machine: StateMachine):
	self.state_machine = state_machine
	self.object = object


func update(delta: float):
	pass


func exit():
	pass


func try_transition(state: String):
	pass
