extends Node
class_name screen_mgr
var progress = []
var current_scene
var load_scene
var loading = false
var prev_scene 
signal load_complete

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	
func _process(_delta: float) -> void:
	if loading:
		var load_progess = ResourceLoader.load_threaded_get_status(load_scene,progress)
		$progress/bar.value = floor(progress[0]*100)
		if load_progess == ResourceLoader.THREAD_LOAD_LOADED:
			load_complete.emit()
			
#fast for quick ui use
func change_scene_without_loading(new_scene):
	call_deferred('_change_scenewithoutload',new_scene)

func _change_scenewithoutload(new_scene):
	$"screeneffects".visible = true
	await animate_transition("fade_in")
	current_scene.free()
	current_scene = load(new_scene).instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	await animate_transition("fadeout")
	$"screeneffects".visible = false
	
	
func change_scene_with_loading(new_scene):
	prev_scene = get_tree().current_scene.scene_file_path
	call_deferred('_change_scenewithload',new_scene)
 

func change_to_previous():
	call_deferred('_change_scenewithload',prev_scene)
	prev_scene = null


func _change_scenewithload(new_scene):
	$"screeneffects".visible = true
	await animate_transition("fade_in")
	ResourceLoader.load_threaded_request(new_scene)
	load_scene = new_scene
	loading = true
	$progress.visible = true
	await self.load_complete
	var loaded_scene = ResourceLoader.load_threaded_get(new_scene)
	current_scene.free()
	current_scene = loaded_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	$progress.visible = false  
	await animate_transition("fadeout") 
	$"screeneffects".visible = false
	load_scene = null
	loading = false

func animate_transition(animation):
	$"screeneffects".visible = true
	$AnimationPlayer.play(animation) 
	await $AnimationPlayer.animation_finished
	
	
