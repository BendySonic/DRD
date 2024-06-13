extends Control

@onready var master_slider = %MasterHSlider
@onready var music_slider = %MusicHSlider
@onready var sfx_slider = %SfxHSlider

@onready var window_option_button = %WindowOptionButton
@onready var v_sync_check_box = %VSyncCheckBox
@onready var scaling_option_button = %ScalingOptionButton
@onready var taa_check_box = %TAACheckBox
@onready var msaa_2d_option_button = %MSAA2DOptionButton
@onready var msaa_3d_option_button = %MSAA3DOptionButton

var on_audio_slider = func(value: float, bus: int):
	match bus:
		0:
			SaveManager.set_key("settings", "master_audio", value)
		1:
			SaveManager.set_key("settings", "sfx_audio", value)
		2:
			SaveManager.set_key("settings", "music_audio", value)
	Settings.apply_audio()

func _ready():
	master_slider.value_changed.connect(on_audio_slider.bind(0))
	sfx_slider.value_changed.connect(on_audio_slider.bind(1))
	music_slider.value_changed.connect(on_audio_slider.bind(2))
	
	window_option_button.item_selected.connect(func(selected):
		SaveManager.set_key("settings", "window_mode", selected)
		Settings.apply_window()
	)
	
	v_sync_check_box.toggled.connect(func(value):
		SaveManager.set_key("settings", "vsync", value)
		Settings.apply_vsync()
	)
	
	scaling_option_button.item_selected.connect(func(selected):
		SaveManager.set_key("settings", "scaling", selected)
		Settings.apply_scaling3d()
	)
	
	taa_check_box.toggled.connect(func(value):
		SaveManager.set_key("settings", "taa", value)
		Settings.apply_taa()
	)
	
	msaa_2d_option_button.item_selected.connect(func(selected):
		SaveManager.set_key("settings", "msaa_2d", selected)
		Settings.apply_msaa2d()
	)
	
	msaa_3d_option_button.item_selected.connect(func(selected):
		SaveManager.set_key("settings", "msaa_3d", selected)
		Settings.apply_msaa3d()
	)
	
	if SaveManager.get_key("settings", "master_audio"):
		master_slider.value_changed.emit(SaveManager.get_key("settings", "master_audio"))
	if SaveManager.get_key("settings", "sfx_audio"):
		sfx_slider.value_changed.emit(SaveManager.get_key("settings", "sfx_audio"))
	if SaveManager.get_key("settings", "music_audio"):
		music_slider.value_changed.emit(SaveManager.get_key("settings", "music_audio"))
	
	if SaveManager.get_key("settings", "vsync"):
		v_sync_check_box.button_pressed = SaveManager.get_key("settings", "vsync")
		v_sync_check_box.toggled.emit(v_sync_check_box.button_pressed)
		
	if SaveManager.get_key("settings", "window_mode"):
		window_option_button.selected = SaveManager.get_key("settings", "window_mode")
		window_option_button.item_selected.emit(window_option_button.selected)
		
	if SaveManager.get_key("settings", "scaling"):
		scaling_option_button.selected = SaveManager.get_key("settings", "scaling")
		scaling_option_button.item_selected.emit(scaling_option_button.selected)
		
	if SaveManager.get_key("settings", "msaa_2d"):
		msaa_2d_option_button.selected = SaveManager.get_key("settings", "msaa_2d")
		msaa_2d_option_button.item_selected.emit(msaa_2d_option_button.selected)
		
	if SaveManager.get_key("settings", "msaa_3d"):
		msaa_3d_option_button.selected = SaveManager.get_key("settings", "msaa_3d")
		msaa_3d_option_button.item_selected.emit(msaa_3d_option_button.selected)
		
	if SaveManager.get_key("settings", "taa"):
		taa_check_box.button_pressed = SaveManager.get_key("settings", "taa")
		taa_check_box.toggled.emit(taa_check_box.button_pressed)
