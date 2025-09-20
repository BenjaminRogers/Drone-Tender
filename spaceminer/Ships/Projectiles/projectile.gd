extends Area2D
var travelled_distance = 0
var original_position
@export var max_range = 350
@export var speed = 750
var damage = 5
var is_moving = true
signal hit_target
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("hit_target", get_parent().get_parent()._on_projectile_connect)
	speed += get_parent().get_parent().actual_speed # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_moving:
		var direction = Vector2.RIGHT.rotated(rotation)
		position += direction * speed * delta
		travelled_distance += speed * delta
		if travelled_distance > max_range:
			self.queue_free()


func _on_body_entered(body: Node2D) -> void:
	hit_target.emit()
	is_moving = false
	if body.has_method("take_damage"):
		body.take_damage(damage)
	%AnimatedSprite2D.play("collide")
	await %AnimatedSprite2D.animation_finished
	queue_free()
