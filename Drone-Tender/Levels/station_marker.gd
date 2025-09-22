extends Sprite2D


@export var target_node_path: NodePath
var target: Node2D

func _ready():
	target = get_parent()
	visible = false # Start hidden

func _process(delta):
	if target and not target.get_node("VisibleOnScreenNotifier2D").is_on_screen():
		visible = true
		# Calculate direction and position marker
		var camera = get_viewport().get_camera_2d()
		var camera_center = camera.global_position
		var direction_to_target = (target.global_position - camera_center).normalized()

		# Clamp marker position to screen edges
		var viewport_rect = get_viewport_rect()
		var marker_position = camera_center + direction_to_target * (min(viewport_rect.size.x, viewport_rect.size.y) / 2 - 20) # Adjust padding

		global_position = marker_position
		look_at(target.global_position) # Make the marker point towards the target
	else:
		visible = false
