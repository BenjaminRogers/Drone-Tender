extends Control

func _on_reset_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	self.hide()
