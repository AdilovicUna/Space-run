extends KinematicBody

export var speed = 10.0

var velocity = Vector3.ZERO

func _physics_process(_delta):
	move_and_slide(velocity)
	
func initialize(start_pos, hans_pos):
	translation = start_pos
	
