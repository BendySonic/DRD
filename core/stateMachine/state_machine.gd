class_name StateMachine extends Node

@export var start_state: String
var state: Node

func _ready():
	await owner.ready
	if not start_state.is_empty():
		state = get_node(start_state)
		state.enter(owner, self)


func _process(delta):
	if state:
		state.update(delta)


func transition_to(state: String):
	self.state.exit()
	self.state = get_node(state)
	self.state.enter(owner, self)
