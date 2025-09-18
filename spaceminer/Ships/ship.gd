class_name Ship extends CharacterBody2D
var projectile_scene = preload("res://Ships/Projectiles/green_laser_root.tscn")
const ROTATION_SPEED: float = .1
const ACCELERATION: float = 10.0
const LATERAL_SPEED: float = 1
var max_projectiles: int = 3
var previous_position: Vector2
var speed_vector: Vector2
var actual_speed: float = 0

func fire_projectile(projectile: Resource) -> void:
	var projectile_instance = projectile.instantiate()
	%AimOrigin.add_child(projectile_instance)
	projectile_instance.global_position = %AimOrigin.global_position
	projectile_instance.global_rotation = %AimOrigin.global_rotation
	#projectile_instance.speed += abs(velocity.x + velocity.y)
	
func _physics_process(delta: float) -> void:
	var direction_input = Input.get_axis("backwards", "forward")
	var rotation_input = Input.get_axis("rotate_left", "rotate_right")
	var lateral_input = Input.get_axis("lateral_left", "lateral_right")
	if Input.is_action_pressed("Stop"):
		velocity = lerp(velocity, Vector2(0, 0), .1)
	if direction_input:
		velocity += transform.x * direction_input * ACCELERATION
	if rotation_input:
		rotation += rotation_input * ROTATION_SPEED
	if lateral_input:
		velocity += transform.y * lateral_input * ACCELERATION
	
	#Determine ship's current global speed
	speed_vector = (global_position - previous_position) / delta
	actual_speed = abs(speed_vector.x + speed_vector.y)
	previous_position = global_position
	#
	move_and_slide()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		if %AimOrigin.get_child_count() < max_projectiles:
			fire_projectile(projectile_scene)
