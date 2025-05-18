extends PanelContainer


func _on_button_pressed() -> void:
	Util.sound.music_play('res://asset/audio/Summer is here.ogg')
	

func _on_button_2_pressed() -> void:
	Util.sound.sfx_play('res://asset/audio/push.wav')
