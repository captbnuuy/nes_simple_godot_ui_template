extends Button 

@export_file("*.tscn") var NEW_SCENE

func _pressed() -> void:
	Util.scene.change_scene(NEW_SCENE)
