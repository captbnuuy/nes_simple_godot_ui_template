extends Node

var config: ConfigFile = ConfigFile.new()
@export var reset:bool = false 
enum {KEYBOARD,MOUSE,GAMEPAD}

var default_bind= {
	'left':eventmaker(KEY_A,KEYBOARD),
	'right':eventmaker(KEY_D,KEYBOARD),
	'up':eventmaker(KEY_W,KEYBOARD),
	'down':eventmaker(KEY_S,KEYBOARD),
} 
func _ready() -> void:
	var err = config.load("user://settings.cfg")
	if err == 7 or reset:
		config.set_value("volume","sfx",1.0)
		config.set_value("volume","music",0.6)
		config.set_value("volume","Master",1.0)
		
		config.set_value("screen","resolution",'1280x720')
		config.set_value("screen","borderless",0)
		config.set_value("control","bind",default_bind)
		config.save("user://settings.cfg")
		
	var keybinds = config.get_value("control","bind")
	for key in keybinds:
		InputMap.action_erase_events(key)
		InputMap.action_add_event(key,keybinds[key])
		
	for volume in config.get_section_keys('volume'):
		var _bus = AudioServer.get_bus_index(volume)
		AudioServer.set_bus_volume_db(_bus,linear_to_db(config.get_value("volume",volume)))
		
	Utils.set_resolution(config.get_value("screen","resolution"))
	Utils.set_screenmode(config.get_value("screen","borderless"))
func setvolume(bus:String,val:float) -> void:
	config.set_value('volume',bus,val)
	config.save("user://settings.cfg")
	
func setscreen(mode:String,val) -> void:
	config.set_value('screen',mode,val)
	config.save("user://settings.cfg")
	
func updatebind(action,key):
	var keybinds = config.get_value("control","bind")
	keybinds[action] = key
	config.set_value("control","bind",keybinds)
	config.save("user://settings.cfg")
func eventmaker(event,type):
	var new_event 
	match type:
		KEYBOARD:
			new_event = InputEventKey.new()
			new_event.set_physical_keycode(event)
		MOUSE:
			new_event = InputEventMouseButton.new()
			new_event.set_physical_keycode(event)
		GAMEPAD:
			new_event = InputEventJoypadButton.new()
			new_event.button_index(event)
	return new_event	
