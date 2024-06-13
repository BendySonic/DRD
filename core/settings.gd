extends Node

var viewport_rid: RID

func _ready():
	apply_audio()
	apply_msaa2d()
	apply_msaa3d()
	apply_scaling3d()
	apply_taa()
	apply_vsync()
	apply_window()

func _process(delta):
	viewport_rid = get_viewport().get_viewport_rid()

# AUDIO BUSES
func apply_audio():
	AudioServer.set_bus_volume_db(0, SaveManager.get_key("settings", "master_audio"))
	AudioServer.set_bus_volume_db(1, SaveManager.get_key("settings", "sfx_audio"))
	AudioServer.set_bus_volume_db(2, SaveManager.get_key("settings", "music_audio"))

# WINDOW
func apply_window():
	var window = SaveManager.get_key("settings", "window_mode")
	var window_mode: int
	match window:
		0:
			window_mode = DisplayServer.WINDOW_MODE_WINDOWED
		1:
			window_mode = DisplayServer.WINDOW_MODE_FULLSCREEN
	DisplayServer.window_set_mode(window_mode)

# VSYNC
func apply_vsync():
	var vsync = SaveManager.get_key("settings", "vsync")
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if vsync else DisplayServer.VSYNC_DISABLED)

# SCALING3d
func apply_scaling3d():
	var scaling: int = RenderingServer.VIEWPORT_SCALING_3D_MODE_BILINEAR
	match SaveManager.get_key("settings", "scaling"):
		0:
			scaling = RenderingServer.VIEWPORT_SCALING_3D_MODE_BILINEAR
		1:
			scaling = RenderingServer.VIEWPORT_SCALING_3D_MODE_FSR
		2:
			scaling = RenderingServer.VIEWPORT_SCALING_3D_MODE_FSR2
	RenderingServer.viewport_set_scaling_3d_mode(viewport_rid, scaling)

# TAA
func apply_taa():
	var taa = SaveManager.get_key("settings", "taa")
	RenderingServer.viewport_set_use_taa(viewport_rid, taa)

# MSAA2d
func apply_msaa2d():
	var msaa2d: int = RenderingServer.VIEWPORT_MSAA_DISABLED
	match SaveManager.get_key("settings", "msaa_2d"):
		0:
			msaa2d = RenderingServer.VIEWPORT_MSAA_DISABLED
		1:
			msaa2d = RenderingServer.VIEWPORT_MSAA_2X
		2:
			msaa2d = RenderingServer.VIEWPORT_MSAA_4X
		3:
			msaa2d = RenderingServer.VIEWPORT_MSAA_8X
	RenderingServer.viewport_set_msaa_2d(viewport_rid, msaa2d)

# MSAA3d
func apply_msaa3d():
	var msaa3d: int = RenderingServer.VIEWPORT_MSAA_DISABLED
	match SaveManager.get_key("settings", "msaa_3d"):
		0:
			msaa3d = RenderingServer.VIEWPORT_MSAA_DISABLED
		1:
			msaa3d = RenderingServer.VIEWPORT_MSAA_2X
		2:
			msaa3d = RenderingServer.VIEWPORT_MSAA_4X
		3:
			msaa3d = RenderingServer.VIEWPORT_MSAA_8X
	RenderingServer.viewport_set_msaa_3d(viewport_rid, msaa3d)
