extends PanelContainer

func _ready() -> void:
	for res in Utils.displayres:
		$GridContainer/Res_select.add_item(res)
	for mode in Utils.displaymode:
		$GridContainer/dis_mode.add_item(mode)
	
	$GridContainer/Res_select.selected = Utils.displayres.keys().find(CFG.config.get_value("screen","resolution"))
	$GridContainer/dis_mode.selected = CFG.config.get_value("screen","borderless")
	
func _on_res_select_item_selected(index: int) -> void:
	Utils.set_resolution(Utils.displayres.values()[index])
	CFG.setscreen('resolution',Utils.displayres.keys()[index])
	
func _on_dis_mode_item_selected(index: int) -> void:	 
	Utils.set_screenmode(index)
	CFG.setscreen('borderless',index)
