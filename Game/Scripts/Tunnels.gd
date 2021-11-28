extends Spatial

#NOTE: levels are numbered from 0

# load traps
var trap_scenes = []
var bug_scenes = []
var virus_scenes = []
var rand = RandomNumberGenerator.new()
var angle = 0

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
	var x = 1200
			
	for n in num_of_traps:
		# add space between traps
		x -= rand.randi_range(70,90)
		# check if the trap will be inside the tunnel
		# if not, break
		if x < -1200:
			break
		create_one_trap(0, x) 

func create_one_obstacle(level,x):
	match level:
		0:
			create_one_trap(level, x)
		1:
			create_one_trap(level,x) if rand.randi_range(0,1) == 0 else create_one_bug(level,x)
		2:
			create_one_trap(level, x)
			
	 
func create_one_bug(level,x):
	# get the level we are making traps for
	var tunnel = get_child(level)
	
	# pick a trap
	var i = rand.randi_range(0, len(bug_scenes) - 1)
	var bug = bug_scenes[i].instance()
	bug.translation.x = x
	
	tunnel.add_child(bug)

func create_one_trap(level,x):
	# get the level we are making traps for
	var tunnel = get_child(level)
	
	# pick a trap
	var i = rand.randi_range(0, len(trap_scenes) - 1)
	var trap = trap_scenes[i].instance()
	trap.translation.x = x
	
	tunnel.add_child(trap)
	rotateTrap(trap)

func rotateTrap(trap):
	# rotate the trap under some angle
	angle = rand.randi_range(0,5) * (PI / 3)
	trap.rotate_x(angle)

func deleteObsticleUntilX(level,x):
	var tunnel = get_child(level)
	var torus = true
	for obsticle in tunnel.get_children():
		if(torus):
			torus = false
		else:
			if(obsticle.translation.x > x):
				obsticle.queue_free()
			else:
				return;
		
