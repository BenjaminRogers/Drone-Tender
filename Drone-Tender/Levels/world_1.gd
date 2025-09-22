extends Node2D


func spawn_asteroid() -> void:
	var new_asteroid = preload("res://Levels/Objects/Scenes/small_asteroid_root.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	%AsteroidContainer.add_child(new_asteroid)
	new_asteroid.global_position = %PathFollow2D.global_position
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
