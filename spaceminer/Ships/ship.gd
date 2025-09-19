class_name Ship extends CharacterBody2D
var projectile_scene = preload("res://Ships/Projectiles/green_laser_root.tscn")
const ROTATION_SPEED: float = 3
const ACCELERATION: float = 5
const LATERAL_SPEED: float = .1
var max_health: float = 100
var current_health: float = 100
var credits: float = 0.0
var max_projectiles: int = 3
var previous_position: Vector2
var speed_vector: Vector2
var actual_speed: float = 0
var max_speed = 800
var max_weight:int = 100
var current_weight: int = 0
var inventory: Dictionary[String, int]
var collision_leeway: float = 100.0
var collision_damage: float = .05
func repair(cost: float) -> void:
	var repairs_needed = max_health - current_health
	var total_cost = snappedf(repairs_needed * cost, .01)
	if total_cost < credits:
		credits -= total_cost
		FloatingText.display_text(str("Repair cost: ", total_cost), global_position, "RED")
		current_health = max_health
		update_credits()
		%HealthBar.value = current_health
	elif credits < cost:
		FloatingText.display_text(str("Insufficient funds!"), global_position, "RED")
	else:
		var partial_repair = snappedf((credits / cost), .01)
		var leftover_credits = snappedf((fmod(credits, cost)), .01)
		var repair_cost = snappedf((credits - leftover_credits), .01)
		FloatingText.display_text(str("Repair cost: ", repair_cost), global_position, "RED")
		current_health += partial_repair
		credits = snappedf(leftover_credits, .01)
		update_credits()
		%HealthBar.value = current_health
func take_collision_damage() -> void:
	if actual_speed > collision_leeway:
		%CollisionSound.play()
		var collision_speed = actual_speed - collision_leeway
		FloatingText.display_text((collision_speed * collision_damage), global_position, "RED")
		current_health -= collision_speed * collision_damage
		%HealthBar.value = current_health
func update_credits() -> void:
	%CreditsLabel.text = str(credits)
func clear_inventory() -> void:
	inventory = {}
	current_weight = 0
	%InventoryUI.update_ui(inventory)
func add_to_inventory(resource_node):
	var additional_value = resource_node.amount
	if additional_value + current_weight > max_weight:
		FloatingText.display_text("Inventory full!", global_position)
	elif inventory.has(resource_node.resource_type):
		var current_value = inventory.get(resource_node.resource_type)
		current_value += additional_value
		inventory[resource_node.resource_type] = current_value
		current_weight += resource_node.amount
		resource_node.queue_free()
		FloatingText.display_text(str(resource_node.resource_type, " ", resource_node.amount), global_position)
		%InventoryUI.update_ui(inventory)
		%ResourceCollectionSound.play()
	elif not inventory.has(resource_node.resource_type):
		inventory.set(resource_node.resource_type, additional_value)
		current_weight += resource_node.amount
		resource_node.queue_free()
		FloatingText.display_text(str(resource_node.resource_type, " ", resource_node.amount), global_position)
		%InventoryUI.update_ui(inventory)
		%ResourceCollectionSound.play()
func fire_projectile(projectile: Resource) -> void:
	var projectile_instance = projectile.instantiate()
	%AimOrigin.add_child(projectile_instance)
	%FiredSound.play()
	projectile_instance.global_position = %AimOrigin.global_position
	projectile_instance.global_rotation = %AimOrigin.global_rotation
	#projectile_instance.speed += abs(velocity.x + velocity.y)
func _on_projectile_connect() -> void:
	%ConnectSound.play()
func _physics_process(delta: float) -> void:
	var direction_input = Input.get_axis("backwards", "forward")
	var rotation_input = Input.get_axis("rotate_left", "rotate_right")
	var lateral_input = Input.get_axis("lateral_left", "lateral_right")
	if Input.is_action_pressed("Stop"):
		velocity = lerp(velocity, Vector2(0, 0), .03)
	if direction_input:
		velocity += transform.x * direction_input * ACCELERATION
	if rotation_input and rotation_input != 0:
		rotation += rotation_input * ROTATION_SPEED * delta
	if lateral_input:
		velocity += transform.y * lateral_input * ACCELERATION
	
	#Determine ship's current global speed
	speed_vector = abs(global_position - previous_position) / delta
	actual_speed = round(abs(speed_vector.x + speed_vector.y))
	previous_position = global_position
	%Spedometer.text = str(actual_speed)
	#
	move_and_slide()
func pause() -> void:
	get_tree().paused = true
	%PauseMenu.paused()
func _ready() -> void:
	%HealthBar.value = current_health
	%HealthBar.max_value = max_health
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		if %AimOrigin.get_child_count() < max_projectiles:
			fire_projectile(projectile_scene)
	if event.is_action_pressed("debug"):
		print(inventory)#FloatingText.display_text("Inventory full!", global_position)
	if event.is_action_pressed("pause"):
		pause()
