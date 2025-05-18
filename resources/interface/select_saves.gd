extends Control

@export var itemlist:ItemList

func _ready() -> void:
	if Util.save.get_allsaves():
		for i in Util.save.get_allsaves():
			itemlist.add_item(i)
	else:
		itemlist.add_item("no item here",null,false)

func _on_return_pressed():
	Util.scene.change_to_previous()

func _on_load_game_pressed() -> void:
	Util.save.current_save = itemlist.get_item_text(itemlist.get_selected_items()[0])
	Util.scene.change_scene_with_loading("res://resources/test_level.tscn")


func _on_new_game_pressed() -> void:
	Util.save.current_save = ""
	Util.scene.change_scene_with_loading("res://resources/test_level.tscn")
