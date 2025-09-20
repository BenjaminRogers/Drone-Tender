extends RigidBody2D
var rand_rotation_range = 5
var rand_movement_range = 10
var has_been_hit = false
@onready var rand_rotation = Asteroid.randomize_rotation(rand_rotation_range)
@onready var rand_movement = Asteroid.randomize_movement(rand_movement_range)
var resource_type: String
@onready var amount: int = randi_range(1, 10)
func _ready() -> void:
	set_inertia(.1)
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	resource_type = Asteroid.randomize_resource()
	apply_force(rand_movement, rand_movement)
func _physics_process(delta: float) -> void:
	if get_contact_count() > 0:
		has_been_hit = true
	if not has_been_hit:
		apply_force(rand_movement)
		set_angular_velocity(rand_rotation)
