extends Node

@export var sfx_maxchannel :int = 4
var sfx_slot :Array[AudioStreamPlayer] = []
var sfx_queue :Array[String] = []

func _ready() -> void:
	for i in range(sfx_maxchannel):
		var sfxplayer = AudioStreamPlayer.new()
		sfxplayer.bus = AudioServer.get_bus_name(2)
		sfxplayer.finished.connect(_sfx_finish_play.bind(sfxplayer))
		$sfx.add_child(sfxplayer)
		sfx_slot.append(sfxplayer)
	
		
func _sfx_finish_play(stream) -> void:
	sfx_slot.append(stream)

func _process(_delta) -> void:
	if not sfx_queue.is_empty() and not sfx_slot.is_empty():
		sfx_slot[0].stream = load(sfx_queue.pop_front())
		sfx_slot[0].play()
		sfx_slot.pop_front()

func sfx_play(file:String):
	sfx_queue.append(file)
	
func music_play(file:String):
	var loaded_file = load(file)
	if $music/player.stream != loaded_file:
		$music/player.stream = loaded_file
		$music/player.play()
	
