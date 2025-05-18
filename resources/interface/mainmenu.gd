extends Control

@export_file("*.tscn") var OPTION_SCENE 

func _ready() -> void:
	$PanelContainer/VBoxContainer/VBoxContainer/PLAY.grab_focus()


func _on_options_pressed() -> void:
	Util.scene.change_scene_with_loading(OPTION_SCENE)
