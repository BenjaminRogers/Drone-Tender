extends RigidBody2D
var rand_rotation_range = 5
var rand_movement_range = 10
var has_been_hit = false
@onready var rand_rotation = Asteroid.randomize_rotation(rand_rotation_range)
@onready var rand_movement = Asteroid.randomize_movement(rand_movement_range)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_inertia(.1)
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	#set_angular_velocity(Asteroid.randomize_rotation(rand_rotation_range))
	#FloatingText.display_text(str("Mass: ", mass), global_position, true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if get_contact_count() > 0:
		has_been_hit = true
	if not has_been_hit:
		apply_force(rand_movement)
		set_angular_velocity(rand_rotation)
	#print(get_contact_count())
	#set_angular_velocity(rand_rotation)
	#transform.y += lateral * delta
	#rotation += rand_rotation * delta
