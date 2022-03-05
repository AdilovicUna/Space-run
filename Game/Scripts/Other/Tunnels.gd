extends Spatial

onready var hans = get_node_or_null("../Hans")
onready var battery = get_node_or_null("../UI/Battery")

# load traps
var trap_scenes = []
var bug_scenes = []
var virus_scenes = []
var token_scenes = []
var rand = RandomNumberGenerator.new()
var angle = 0	
var deviation = 0.01
var obstacle_number = 0

func _physics_process(_delta):
    #rotates all children of "traps"
    if Input.is_action_pressed("right"):
        var tunnel = get_child(hans.get_current_tunnel())
        tunnel.rotate_object_local(Vector3.RIGHT,-PI/90)
    if Input.is_action_pressed("left"):
        var tunnel = get_child(hans.get_current_tunnel())
        tunnel.rotate_object_local(Vector3.LEFT,-PI/90)
    if not hans == null: # if it is not instanced we can't call the function       
        hans.switch_animation()

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
    # pick which kind of obstacle will be added
    var scene  = pick_scene(level)   
    
    # get the level we are making traps for
    var tunnel = get_child(level)
    
    # pick an obstacle
    var i = pick_obstacle(scene)
    
    # make an instance
    var obstacle = scene[i].instance()
    obstacle.translation.x = x
    
    tunnel.add_child(obstacle)
    rotate_obstacle(obstacle)

func pick_obstacle(scene):
    if scene == token_scenes:
        return 0
    if scene == virus_scenes:
        # rotavirus (index 0 in virus_scenes) will occur 75% of the time
        var i = rand.randf_range(0,1)
        return 0 if i <= 0.75 else 1
    return rand.randi_range(0, len(scene) - 1)

func pick_scene(level,scene = trap_scenes):
    if rand.randf_range(0,1) < 0.1 or obstacle_number >= 10:
        obstacle_number = 0
        return token_scenes
    var r = rand.randi_range(0,1)
    if level == hans.lvl.TWO and r == 0:
        scene = bug_scenes
    elif level == hans.lvl.THREE and r == 0 :
        scene = virus_scenes
    obstacle_number += 1
    return scene
    
func rotate_obstacle(obstacle):
    # rotate the obstacle under some angle
    angle = rand.randi_range(0,5) * (PI / 3)
    obstacle.rotate_x(angle)
          
func delete_obstacle_until_x(level,x):
    var tunnel = get_child(level)
    for obstacle in tunnel.get_children():
        if not "light" in obstacle.name and not "torus" in obstacle.name and not "Bullet" in obstacle.name:
            if obstacle.translation.x > x:
                obstacle.queue_free()
            else:
                return;
                
func bug_virus_movement(curr_tunnel):
    var tunnels = get_children()
    for obstacle in tunnels[curr_tunnel].get_children():
        # we only move bugs
        if "Trap" in obstacle.name or "torus" in obstacle.name or "Token" in obstacle.name:
            continue;
        
        # obstacles start moving torwards Hans only when he gets close enough
        # thit way we can avoid them all alligning at one point
        if obstacle.transform.origin.x < hans.transform.origin.x - 150:
            continue;
            
        var tunnel_rot = tunnels[curr_tunnel].rotation.x + PI
        var obstacle_rot = obstacle.rotation.x + PI
        
        if (-1) * deviation > tunnel_rot + obstacle_rot  or tunnel_rot + obstacle_rot > deviation:
            var dec = fmod(abs(obstacle_rot + tunnel_rot),2 * PI) 
            var inc = abs(2 * PI - fmod(tunnel_rot + obstacle_rot, 2* PI))
            # speed for every instance is generated randomly
            # so obstacles of the same species will do not necessarily have the same speed
            if dec > inc:
                obstacle.rotate_x(obstacle.speed)
            else:
                obstacle.rotate_x(-obstacle.speed)      
