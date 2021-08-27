extends Spatial

# load traps
var trap_scenes = []
var rand = RandomNumberGenerator.new()

func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		rotate_object_local(Vector3.RIGHT,-PI/90)
	if Input.is_action_pressed("left"):
		rotate_object_local(Vector3.LEFT,-PI/90)

func create_first_level_traps():
	rand.randomize()
	# get the level we are making traps for
	var tunnel = get_child(0)
	# pick number of traps to be added
	var num_of_traps = rand.randi_range(50,65)
	# pick x for the first trap
	var x = rand.randi_range(1120,1190)
	
	for n in num_of_traps:
		# pick a trap
		var i = rand.randi_range(0, len(trap_scenes) - 1)
		var trap = trap_scenes[i].instance()
		trap.translation.x = x
		# add space between traps
		x -= rand.randi_range(40,80)
		# check if the trap will be inside the tunnel
		# if not, break
		if x < -1200:
			break
		tunnel.add_child(trap)
		# rotate the trap under some angle
		var r = rand.randf_range(0,360)
		trap.rotate_x(r)

func create_one_trap(level,x):
	# get the level we are making traps for
	var tunnel = get_child(level)
	
	# pick a trap
	var i = rand.randi_range(0, len(trap_scenes) - 1)
	var trap = trap_scenes[i].instance()
	trap.translation.x = x
	
	tunnel.add_child(trap)
	
	# rotate the trap under some angle
	var r = rand.randf_range(0,360)
	trap.rotate_x(r)
