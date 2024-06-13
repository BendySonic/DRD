extends CanvasLayer

@onready var start_button = %StartButton
@onready var settings_button = %SettingsButton
@onready var exit_button = %ExitButton

@onready var settings = %Settings

@export_file("*.tscn") var started_scene: String

func _ready():
	var start = func():
		get_tree().change_scene_to_file(started_scene)

	start_button.pressed.connect(start)
	var settings = func():
		self.settings.visible = !self.settings.visible
	settings_button.pressed.connect(settings)
	exit_button.pressed.connect(get_tree().quit)
