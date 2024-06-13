extends CanvasLayer

@onready var continue_button = %ContinueButton
@onready var exit_button = %ExitButton
@onready var main_menu_button = %MainMenuButton

func _ready():
	continue_button.pressed.connect(toggle.bind(false))
	exit_button.pressed.connect(get_tree().quit)
	main_menu_button.pressed.connect(func():
		toggle(false)
		get_tree().change_scene_to_file("res://game/user_interface/main_menu.tscn"))
	toggle(false)

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle(!get_tree().paused)

var last_mouse_mode = DisplayServer.mouse_get_mode()
func toggle(mode: bool = false):
	if mode:
		last_mouse_mode = DisplayServer.mouse_get_mode()
	get_tree().paused = mode
	visible = get_tree().paused
	DisplayServer.mouse_set_mode(last_mouse_mode if not mode else DisplayServer.MOUSE_MODE_VISIBLE)
