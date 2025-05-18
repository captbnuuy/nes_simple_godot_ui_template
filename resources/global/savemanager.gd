extends Node
class_name  save_mgr
var saves_list :PackedStringArray
var current_save:String
func _ready() -> void:
	#initialize save directory
	if DirAccess.open("user://saves"):
		DirAccess.make_dir_absolute("user://saves")
	else:
		saves_list = get_allsaves()
		
func get_allsaves():
	var saves = DirAccess.open("user://saves")
	return saves.get_files()

func new_save(savename, score)-> void:
	var new_data = SaveData.new()
	new_data.name = savename
	new_data.score = score
	ResourceSaver.save(new_data,"user://saves/save "+savename+"-"+Time.get_datetime_string_from_system()+".res")

func load_save(path) -> SaveData:
	return ResourceLoader.load(path)
	
func load_current_save() -> SaveData:
	return ResourceLoader.load("user://saves/"+current_save)
