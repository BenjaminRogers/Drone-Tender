extends RigidBody2D
var rng = RandomNumberGenerator.new()
var resource_types: Array[String] = ["Copper", "Silver", "Gold"]
#@onready var direction = rng.randf_range(-20, 20)
#@onready var lateral = rng.randf_range(-20, 20)
#@onready var rand_rotation = rng.randf_range(-1, 1)
func randomize_movement(direction) -> Vector2:
	var new_direction = randf_range((direction * -1), direction)
	var new_lateral = randf_range((direction * -1), direction)
	return Vector2(new_direction, new_lateral)
func randomize_rotation(rotation_range) -> float:
	var new_rotation = randf_range((rotation_range * -1), rotation_range)
	return new_rotation
func randomize_mass(mass_range) -> float:
	var new_mass = randf_range(0.1, mass_range)
	return new_mass
func randomize_resource() -> String:
	var index = rng.randi_range(0, (resource_types.size() - 1))
	return resource_types[index]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
