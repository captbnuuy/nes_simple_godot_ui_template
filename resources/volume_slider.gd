extends HSlider

@export var bus :String = "Master"
@onready var _bus = AudioServer.get_bus_index(bus)

func _ready() -> void:
	#TODO: ADD HOOK TO CONFIG
	value = AudioServer.get_bus_volume_linear(_bus)
	print(AudioServer.get_bus_volume_linear(_bus))
	
func _on_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_db(_bus,linear_to_db(_value))
	CFG.setvolume(bus,_value)
