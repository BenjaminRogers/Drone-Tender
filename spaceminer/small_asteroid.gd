extends RigidBody2D
var tiny_asteroid = preload("res://Levels/Objects/Scenes/tiny_asteroid.tscn")
var rand_rotation_range = 5
var rand_movement_range = 10
var has_been_hit = false
var health = 25
@onready var screen_center = get_viewport_rect().size / 2
@onready var rand_rotation = Asteroid.randomize_rotation(rand_rotation_range)
@onready var rand_movement = Asteroid.randomize_movement(rand_movement_range)
signal health_depleted
func _ready() -> void:
	set_inertia(.1)
	set_contact_monitor(true)
	set_max_contacts_reported(1)
func _physics_process(delta: float) -> void:
	screen_center = get_viewport_rect().size / 2
	if get_contact_count() > 0:
		has_been_hit = true
	if not has_been_hit:
		apply_force(rand_movement)
		set_angular_velocity(rand_rotation)
#	if abs(global_position - screen_center) > 1000:
		#queue_free()
func take_damage(damage: float) -> void:
	health -= damage
	if health <= 0:
		health_depleted.emit()
func break_apart() -> void:
	var parent_node = get_parent()
	var quantity: int = randi_range(1, 3)
	for i in quantity:
		var new_asteroid = tiny_asteroid.instantiate()
		parent_node.call_deferred("add_child",new_asteroid)
		new_asteroid.global_position = global_position
	queue_free()
func _on_body_entered(body: Node) -> void:
	if body.has_method("take_collision_damage"):
		body.take_collision_damage() # Replace with function body.
