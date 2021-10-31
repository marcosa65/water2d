extends RigidBody2D

func _on_Point_1_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if event.is_pressed():
			apply_central_impulse(Vector2(0,20))
