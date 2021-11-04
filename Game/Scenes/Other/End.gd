extends ColorRect

onready var main = get_parent().get_parent()

func _unhandled_input(event):
	# reset the game if enter is pressed
	if event.is_action_pressed("ui_accept") and $TryAgain.visible:
		var hans = get_node("../../Hans")
		hans.free()
		get_tree().reload_current_scene()
		get_tree().paused = false
