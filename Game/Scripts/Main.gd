extends Node

onready var hans = get_node("Hans")

func _ready():
	hans._on_Main_ready()
