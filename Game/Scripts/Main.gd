extends Node

onready var hans = get_node("Hans")
onready var tunnels = get_node("Tunnels")
onready var score = get_node("UI/Score")
onready var end = get_node("UI/End")

func _ready():
	tunnels._on_Main_ready()

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

func _reload_game():
	# reset Hans and tunnels to their previous positions
	hans.translation = Vector3(3750,-32,0)
	var x = 2500
	for tunnel in tunnels.get_children():
		
		# remove traps from all of the tunnels
		var isTorus = true 
		for trap in tunnel.get_children():
			# make sure the torus doesnt get removed
			# by skipping the first child
			if(isTorus): 
				isTorus = false
			else:
				trap.queue_free()
		
		# get tunnels to the starting position
		tunnel.translation = Vector3(x,0,0)
		x -= 2500
	
	# hide the game_over UI and reset score
	end.hide()
	for node in end.get_children():
		node.hide()
	score._reset()
	
	# generate new traps
	tunnels._on_Main_ready()
