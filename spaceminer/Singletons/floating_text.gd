extends Node


func display_text(value, position: Vector2, is_persistent: bool = false):
	var text_label = Label.new()
	text_label.text = str(value)
	text_label.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	
	text_label.label_settings.font_color = color
	text_label.label_settings.font_size = 20
	text_label.label_settings.outline_color = "#000"
	text_label.label_settings.outline_size = 10
	call_deferred("add_child", text_label)
	await text_label.resized
	text_label.global_position.x = position.x - (text_label.size.x / 2)
	text_label.global_position.y = position.y - 40
	#text_label.pivot_offset = Vector2(text_label.size / 2)
	
	if not is_persistent:
		var movement_tween = create_tween()
		movement_tween.set_parallel(true)
		movement_tween.tween_property(text_label, "position:y", text_label.position.y -5, .25).set_ease(Tween.EASE_OUT)
		movement_tween.tween_property(text_label, "position:y", text_label.position.y, 0.5).set_ease(Tween.EASE_IN).set_delay(.5)
		await movement_tween.finished
		text_label.queue_free()

	
