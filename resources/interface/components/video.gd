extends PanelContainer

func _ready() -> void:
	for res in Util.displayres:
		$GridContainer/Res_select.add_item(res)
	for mode in Util.displaymode:
		$GridContainer/dis_mode.add_item(mode)
	
	$GridContainer/Res_select.selected = Util.displayres.keys().find(Util.cfg.config.get_value("screen","resolution"))
	$GridContainer/dis_mode.selected = Util.cfg.config.get_value("screen","borderless")
	
func _on_res_select_item_selected(index: int) -> void:
	Util.set_resolution(Util.displayres.values()[index])
	Util.cfg.setscreen('resolution',Util.displayres.keys()[index])
	
func _on_dis_mode_item_selected(index: int) -> void:	 
	Util.set_screenmode(index)
	Util.cfg.setscreen('borderless',index)
