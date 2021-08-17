extends Node

onready var hans = get_node("Hans")

func _ready():
	hans._on_Main_ready()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UI/End.visible:
		get_tree().reload_current_scene()
