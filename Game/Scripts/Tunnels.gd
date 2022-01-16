extends Spatial

#NOTE: levels are numbered from 0
onready var hans = get_node("../Hans")

# load traps
var trap_scenes = []
var bug_scenes = []
var virus_scenes = []
var bug_translations = [Vector2(-20,0),Vector2(-10,-20),Vector2(10,-20)]
var rand = RandomNumberGenerator.new()
var angle = 0	

func _physics_process(_delta):
	#rotates all children of "traps"
	if Input.is_action_pressed("right"):
		var tunnel = get_child(hans.get_current_tunnel())
		tunnel.rotate_object_local(Vector3.RIGHT,-PI/90)
	if Input.is_action_pressed("left"):
		var tunnel = get_child(hans.get_current_tunnel())
		tunnel.rotate_object_local(Vector3.LEFT,-PI/90)
		
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
		create_one_obstacle(0, x) 
		
func create_one_obstacle(level,x):
	match level:
		0:
			create_one_trap(level, x)
		1:
			create_one_trap(level,x) if rand.randi_range(0,1) == 0 else create_one_bug(level,x)
		2:
			create_one_trap(level, x)
			
func deleteObsticleUntilX(level,x):
	var tunnel = get_child(level)
	var light = true
	for obsticle in tunnel.get_children():
		if(light):
			light = false
		else:
			if(obsticle.translation.x + 20 > x):
				obsticle.queue_free()
			else:
				return;
		
func create_one_bug(level,x):
	# get the level we are making traps for
	var tunnel = get_child(level)

	# pick a trap
	var i = rand.randi_range(0, len(bug_scenes) - 1)
	var bug = bug_scenes[i].instance()
	
	# pick how many times we rotate the bug
	# (needed for the tranlsation array, 
	# otherwise bug wont be properly placed in the tunnel)
	i = rand.randi_range(0,5)
	
	translateBug(bug,i)
	bug.translation.x = x
	
	tunnel.add_child(bug)
	rotateBug(bug,i)

func translateBug(bug,i):
	if(i < 3):	
		bug.translation.y = bug_translations[i].x
		bug.translation.z = bug_translations[i].y
	else:	
		bug.translation.y = bug_translations[i%3].x * (-1)
		bug.translation.z = bug_translations[i%3].y * (-1)
		
func rotateBug(bug,i):
	# rotate the trap under some angle
	angle =  i * (PI / 3)	
	bug.rotate_x(angle)
	
func create_one_trap(level,x):
	# get the level we are making traps for
	# pick a trap
	var tunnel = get_child(level)
	var i = rand.randi_range(0, len(trap_scenes) - 1)
	var trap = trap_scenes[i].instance()
	trap.translation.x = x
	
	tunnel.add_child(trap)
	rotateTrap(trap)

func rotateTrap(trap):
	# rotate the trap under some angle
	angle = rand.randi_range(0,5) * (PI / 3)
	trap.rotate_x(angle)
