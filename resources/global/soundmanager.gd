extends Node
class_name sound_mgr
@export var sfx_maxchannel :int = 4
var sfx_slot :Array[AudioStreamPlayer] = []
var sfx_queue :Array[String] = []
var sfx_pos_slot :Array[AudioStreamPlayer2D] = []
var sfx_pos_used :Array[AudioStreamPlayer2D] = []
var sfx_pos_queue :Dictionary[String,Vector2] = {}

func _ready() -> void:
	for i in range(sfx_maxchannel):
		var sfxplayer = AudioStreamPlayer.new()
		sfxplayer.bus = AudioServer.get_bus_name(2)
		sfxplayer.finished.connect(_sfx_finish_play.bind(sfxplayer))
		$sfx.add_child(sfxplayer)
		sfx_pos_slot.append(sfxplayer)
		var sfxposplayer = AudioStreamPlayer2D.new()
		sfxposplayer.bus = AudioServer.get_bus_name(2)
		sfxposplayer.finished.connect(_sfx_pos_finish_play.bind(sfxplayer))
		$sfx.add_child(sfxposplayer)
		sfx_pos_slot.append(sfxposplayer)

func _process(_delta) -> void:
	
	if not sfx_queue.is_empty() and not sfx_slot.is_empty():
		sfx_slot[0].stream = load(sfx_queue.pop_front())
		sfx_slot[0].play()
		sfx_slot.pop_front()
		
	if not sfx_pos_queue.is_empty() and not sfx_pos_slot.is_empty():
		var stream:Array = [sfx_pos_queue.keys()[0], sfx_pos_queue.values()[0]]
		sfx_pos_slot[0].stream = load(stream[0])
		sfx_pos_slot[0].position = stream[1]
		sfx_pos_slot[0].play()
		sfx_pos_queue.erase(stream[0])
		sfx_pos_slot.pop_front()
		
func sfx_play(file:String):
	sfx_queue.append(file)
	
func _sfx_finish_play(stream) -> void:
	sfx_slot.append(stream)
	
func sfx_positional_play(file:String,position:Vector2):
	sfx_pos_queue[file] = position
	
func _sfx_pos_finish_play(stream):
	sfx_pos_slot.append(stream)
	
func music_play(file:String):
	var loaded_file = load(file)
	if $music/player.stream != loaded_file:
		$music/player.stream = loaded_file
		$music/player.play()
	
