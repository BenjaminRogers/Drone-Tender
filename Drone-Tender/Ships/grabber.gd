extends RigidBody2D
var grab_mode: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
func toggle_grab_mode() -> void:
	if %End.grab_mode == false:
		%End.grab_mode = true
		print("grab_mode on")
		print(%End.grab_mode)
	elif %End.grab_mode == true:
		%End.grab_mode = false
		release()
		print("grab_mode off")
		print(%End.grab_mode)
func release() -> void:
	%GrabJoint.node_b = NodePath("")

func _on_body_entered(body: Node) -> void:
	if body is RigidBody2D:
		if grab_mode == false:
			%GrabJoint.node_b = NodePath("")
		elif grab_mode == true:
			if %GrabJoint.node_b == NodePath(""):
				%GrabJoint.node_b = body.get_path()

				print(%GrabJoint.node_b)
				print(body)
				print(body.get_path)
			else:
				pass
