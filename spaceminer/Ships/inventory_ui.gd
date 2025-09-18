extends VBoxContainer
@onready var inventory: Dictionary[String, int] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func update_ui(dict: Dictionary[String, int]) -> void:
	inventory = inventory.merged(dict, true)
	for child in get_child_count():
		get_child(child).queue_free()
	for key in inventory:
		var new_label = Label.new()
		new_label.label_settings = LabelSettings.new()
		new_label.text = str(key, ": ", dict.get(key))
		add_child(new_label)
		new_label.label_settings.font_size = 25
