extends CanvasLayer

@export var textname :LineEdit
@export var scorelabel :Label

var score = 0
func _ready() -> void:
	if Util.save.current_save:
		var data:SaveData = Util.save.load_current_save()
		score = data.score
		textname.text = data.name
		
func _process(delta: float) -> void:
	scorelabel.text = str(score)

func _on_button_2_pressed() -> void:
	Util.save.new_save(textname.text,score)	


func _on_button_pressed() -> void:
	score += 5
