extends Node

@export var controls_container: Array[Node] = []

@export_category("Buttons")
@export var button_pressed_stream: AudioStream
@export var button_hover_stream: AudioStream

@export_category("OptionButton")
@export var option_selected_stream: AudioStream

@export_category("Sliders")
@export var slider_drag_stream: AudioStream
@export var slider_changed_stream: AudioStream

@export_category("TabContainer")
@export var tab_selected_stream: AudioStream
@export var tab_hover_stream: AudioStream

@onready var stream_player = $AudioStreamPlayer

@export_category("other settings")
@export var custom_bus_for_controls: Dictionary = {
	
}

func _ready():
	await owner.ready
	
	var controls: Array = []
	var unadded_controls: Array = controls_container
	while unadded_controls.size():
		for control in unadded_controls:
			controls.append(control)
			unadded_controls.erase(control)
			unadded_controls.append_array(control.get_children())
	
	for control in controls:
		match control.get_class():
			"Button", "TextureButton", "CheckBox", "CheckButton":
				connect_to_stream(control.pressed, button_pressed_stream)
			"OptionButton":
				connect_to_stream(control.pressed, button_pressed_stream)
				connect_to_stream(control.item_selected, option_selected_stream, 1)
			"HSlider", "VSlider":
				connect_to_stream(control.drag_started, slider_drag_stream, get_bus_for(control))
				connect_to_stream(control.value_changed, slider_changed_stream, 1, get_bus_for(control))
			"TabContainer":
				connect_to_stream(control.tab_clicked, tab_selected_stream, 1)
				connect_to_stream(control.tab_hovered, tab_hover_stream, 1)

func get_bus_for(control: Control):
	for _control in custom_bus_for_controls:
		if get_node(_control) == control:
			return custom_bus_for_controls[_control]
	return 0 

func connect_to_stream(_signal: Signal, stream: AudioStream, args_count: int = 0, bus = 0):
	if stream:
		if args_count:
			_signal.connect(play_stream.bind(stream, bus).unbind(args_count))
		else:
			_signal.connect(play_stream.bind(stream, bus))

func play_stream(stream: AudioStream, bus: int):
	stream_player.stop()
	stream_player.bus = AudioServer.get_bus_name(bus)
	stream_player.stream = stream
	stream_player.play()
