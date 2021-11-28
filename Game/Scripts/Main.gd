extends Node


onready var hans = get_node("Hans")
onready var tunnels = get_node("Tunnels")
onready var score = get_node("UI/Score")
onready var end = get_node("UI/End")

func _ready():
	for name in ["TrapI","TrapO", "TrapMovingI", "TrapX", "TrapWalls", "TrapHex", 
					"TrapHexO", "TrapBalls", "TrapTriangles", "TrapHalfHex"]:
		tunnels.trap_scenes.append(load("res://Scenes/Trap_scenes/" + name + ".tscn"))
	for name in ["Ladybug", "Worm"]:
		tunnels.bug_scenes.append(load("res://Scenes/Characters/Bugs/" + name + ".tscn"))
	#for name in []:
		#tunnels.virus_scenes.append(load("res://Scenes/Characters/Viruses" + name + ".tscn"))
	tunnels.create_first_level_traps()

func _game_over():
	get_tree().paused = true
	end.show()
	score._display_Final_Score()
	var end_children = end.get_children()

	# a little animation for the end of the game
	end_children[0].show()
	yield(get_tree().create_timer(1.2), "timeout")	
	end_children[0].hide()
	end_children[1].show()
	yield(get_tree().create_timer(1.2), "timeout")
	end_children[2].show()


func _on_Resume_pressed():
	$PauseAndResume/Pause.show()
	$UI/Score.show()
	$PauseAndResume/Pause_popup.hide()
	get_tree().paused = false

func _on_Pause_pressed():
	$PauseAndResume/Pause_popup.show()
	$PauseAndResume/Pause.hide()
	$UI/Score.hide()
	get_tree().paused = true
	
