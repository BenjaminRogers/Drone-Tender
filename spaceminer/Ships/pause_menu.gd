extends Control


# Called when the node enters the scene tree for the first time.
func unpause() -> void:
	get_tree().paused = false
	hide()
func paused() -> void:
	show()
	%ResumeButton.grab_focus()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		unpause()
	
