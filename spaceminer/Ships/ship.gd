class_name Ship extends CharacterBody2D
var projectile_scene = preload("res://Ships/Projectiles/green_laser_root.tscn")
const ROTATION_SPEED: float = .1
const SPEED: float = 10.0
const LATERAL_SPEED: float = 1

func fire_projectile(projectile: Resource) -> void:
	var projectile_instance = projectile.instantiate()
	%AimOrigin.add_child(projectile_instance)
	projectile_instance.global_position = %AimOrigin.global_position
	projectile_instance.global_rotation = %AimOrigin.global_rotation
	projectile_instance.speed += (velocity.x + velocity.y)
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	var direction_input = Input.get_axis("backwards", "forward")
	var rotation_input = Input.get_axis("rotate_left", "rotate_right")
	var lateral_input = Input.get_axis("lateral_left", "lateral_right")
	if Input.is_action_pressed("Stop"):
		velocity = lerp(velocity, Vector2(0, 0), .1)
	if direction_input:
		velocity += transform.x * direction_input * SPEED
	if rotation_input:
		rotation += rotation_input * ROTATION_SPEED
	if lateral_input:
		velocity += transform.y * lateral_input * SPEED
	move_and_slide()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		fire_projectile(projectile_scene)
