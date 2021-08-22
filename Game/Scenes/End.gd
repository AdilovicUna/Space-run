extends ColorRect

onready var main = get_parent().get_parent()

func _unhandled_input(event):
	# reset the game if enter is pressed
	if event.is_action_pressed("ui_accept") and $TryAgain.visible:
		main._reload_game()
		get_tree().paused = false
