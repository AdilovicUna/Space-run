extends ColorRect

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		var hans = get_node("../../Hans")
		hans.free()
		get_tree().reload_current_scene()
		get_tree().paused = false
