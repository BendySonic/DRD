extends Node

var config_file: ConfigFile
var file_dir = "user://config.ini"
var default_config_file: String = "res://core/save_manager/default_config.gd"

func _ready():
	#OS.shell_open(ProjectSettings.globalize_path(file_dir.get_base_dir()))
	config_file = ConfigFile.new()
	if FileAccess.file_exists(file_dir):
		config_file.load(file_dir)
		#config_file.load(default_config_file)
	else:
		config_file.load(default_config_file)
		config_file.save(file_dir)

func set_key(section: String, key: String, value: Variant):
	config_file.set_value(section, key, value)
	config_file.save(file_dir)

func get_key(section: String, key: String):
	if config_file.has_section(section) and config_file.has_section_key(section, key):
		return config_file.get_value(section, key)
	else:
		return null
