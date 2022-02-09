extends Spatial

onready var hans = get_node("../Hans")

# load traps
var trap_scenes = []
var bug_scenes = []
var virus_scenes = []
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
    var level = hans.lvl.ONE
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
        create_one_obstacle(level, x) 
        
func create_one_obstacle(level,x):
    var scene  = pick_scene(level)   
    # get the level we are making traps for
    var tunnel = get_child(level)
    # pick a trap
    var i = rand.randi_range(0, len(scene) - 1)
    # make an instance
    var obstacle = scene[i].instance()
    obstacle.translation.x = x
    
    tunnel.add_child(obstacle)
    rotate_obstacle(obstacle)

func pick_scene(level,scene = trap_scenes):
    var r = rand.randi_range(0,1)
    if level == hans.lvl.TWO and r == 0:
            scene = bug_scenes
    elif level == hans.lvl.THREE and r == 0:
            scene = virus_scenes
    return scene
    
func rotate_obstacle(obstacle):
    # rotate the obstacle under some angle
    angle = rand.randi_range(0,5) * (PI / 3)
    obstacle.rotate_x(angle)
          
func delete_obstacle_until_x(level,x):
    var tunnel = get_child(level)
    for obstacle in tunnel.get_children():
        if not "light" in obstacle.name and not "torus" in obstacle.name:
            if obstacle.translation.x > x:
                obstacle.queue_free()
            else:
                return;
