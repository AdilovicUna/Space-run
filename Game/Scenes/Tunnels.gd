extends Spatial

func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		rotate_object_local(Vector3.RIGHT,-PI/90)
	if Input.is_action_pressed("left"):
		rotate_object_local(Vector3.LEFT,-PI/90)
