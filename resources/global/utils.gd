extends Node
@export var sound :sound_mgr
@export var cfg :cfg_mgr
@export var scene :screen_mgr
@export var save :save_mgr

const displaymode :Array[String] = [
	"Windowed",
	"Fullscreeen",
	'Borderless'
]

const displayres :Dictionary = {
	"1280x720" :Vector2i(1280,720),
	"1920x1080" :Vector2i(1920,1080)
}
func set_resolution(res) ->void:
	DisplayServer.window_set_size(displayres[res])
	
func set_screenmode(mode) ->void:
	match mode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
