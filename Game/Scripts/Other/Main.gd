extends Node

onready var hans = get_node("Hans")
onready var tunnels = get_node("Tunnels")
onready var score = get_node("UI/Score")
onready var end = get_node("UI/End")
onready var battery = get_node("UI/Battery")
onready var timer = get_node("UI/Battery/DropTimer")
onready var pause = get_node("PauseAndResume/Pause")
onready var pause_popup = get_node("PauseAndResume/Pause_popup")

func _ready():
    for name in ["TrapI","TrapO", "TrapMovingI", "TrapX", "TrapWalls", "TrapHex", 
                    "TrapHexO", "TrapBalls", "TrapTriangles", "TrapHalfHex"]:
        tunnels.trap_scenes.append(load("res://Scenes/Traps/" + name + ".tscn"))
        
    for name in ["Worm", "LadybugFlying", "LadybugWalking"]:
        tunnels.bug_scenes.append(load("res://Scenes/Characters/Bugs/" + name + ".tscn"))
        
    for name in ["Rotavirus", "Bacteriophage"]:
        tunnels.virus_scenes.append(load("res://Scenes/Characters/Viruses/" + name + ".tscn"))
        
    tunnels.token_scenes.append(load("res://Scenes/Tokens/EnergyToken.tscn"))
    
    tunnels.create_first_level_traps()

func _game_over():
    get_tree().paused = true    
    end.show()
    battery.hide()
    timer.stop()
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
    pause.show()
    score.show()
    battery.show()
    timer.start()    
    pause_popup.hide()
    get_tree().paused = false

func _on_Pause_pressed():
    pause_popup.show()
    pause.hide()
    score.hide()
    battery.hide()
    timer.stop()    
    get_tree().paused = true
