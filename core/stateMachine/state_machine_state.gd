extends StateMachine

class_name StateMachineState

var state_machine: StateMachine
var object: Object

func _process(delta):
	if state and state_machine.state == self:
		state.update(delta)

func enter(object: Object, state_machine: StateMachine):
	self.state_machine = state_machine
	self.object = object


func update(delta: float):
	pass


func exit():
	pass


func try_transition(state: String):
	pass

func is_current():
	return state_machine.state == self
