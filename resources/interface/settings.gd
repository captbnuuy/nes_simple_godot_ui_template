extends Panel

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventJoypadButton and event.is_pressed():
        if event.button_index == JOY_BUTTON_LEFT_SHOULDER:
            $tabs.current_tab += 1


func _on_button_pressed() -> void:
    ScreenManager.change_to_previous()
