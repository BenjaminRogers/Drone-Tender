extends Node2D
var value_dict: Dictionary[String, float] = {"Copper": 2.5, "Silver": 4.5, "Gold": 8}
var repair_cost: float = 2.5
func buy_resources(object: Node2D):
	if not object.inventory.is_empty():
		var received_dict: Dictionary[String, int] = object.inventory
		var total_credits: float = 0
		for key in received_dict:
			if value_dict.has(key):
				total_credits += received_dict[key] * value_dict[key]
		object.credits += total_credits
		object.update_credits()
		object.clear_inventory()
		await FloatingText.display_text(str("Credits earned: ", total_credits),object.global_position, "GOLD")
	if object.has_method("repair"):
		if object.current_health < object.max_health:
			object.repair(repair_cost)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
