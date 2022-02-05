extends Spatial

onready var hans = get_node("../Hans")

# load traps
var trap_scenes = []
var bug_scenes = []
var virus_scenes = []
var bug_virus_translations = [Vector2(-20,0),Vector2(-10,-20),Vector2(10,-20)]
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
    match level:
        hans.lvl.ONE:
            create_one_trap(level, x)
        hans.lvl.TWO:
            call_create(bug_scenes,level,x)
        hans.lvl.THREE:
            call_create(virus_scenes,level,x)
            
func call_create(scene,level,x):
    if rand.randi_range(0,1) == 0:
        create_one_trap(level,x)  
    else:
        create_one_bug_virus(scene,level,x)  
        
func delete_obsticle_until_x(level,x):
    var tunnel = get_child(level)
    for obsticle in tunnel.get_children():
        if not "light" in obsticle.name and not "torus" in obsticle.name:
            if obsticle.translation.x > x:
                obsticle.queue_free()
            else:
                return;
    
func create_one_trap(level,x):
    # get the level we are making traps for
    # pick a trap
    var tunnel = get_child(level)
    var i = rand.randi_range(0, len(trap_scenes) - 1)
    var trap = trap_scenes[i].instance()
    trap.translation.x = x
    
    tunnel.add_child(trap)
    rotate_Trap(trap)

func rotate_Trap(trap):
    # rotate the trap under some angle
    angle = rand.randi_range(0,5) * (PI / 3)
    trap.rotate_x(angle)

func create_one_bug_virus(scene,level,x):
    # get the level we are making traps for
    var tunnel = get_child(level)

    # pick a trap
    var length = len(bug_scenes) if level == hans.lvl.TWO else len(virus_scenes)
    var i = rand.randi_range(0, len(scene) - 1)
    
    # make an instance
    var bug_virus = scene[i].instance()
   
    # pick how many times we rotate the bug or a virus
    # (needed for the tranlsation array, 
    # otherwise it wont be properly placed in the tunnel)
    i = rand.randi_range(0,5)
    
    translate_bug_virus(bug_virus,i)
    bug_virus.translation.x = x
    
    tunnel.add_child(bug_virus)
    rotate_bug_virus(bug_virus,i)
  
func translate_bug_virus(bug_virus,i):
    if i < 3:	
        bug_virus.translation.y = bug_virus_translations[i].x
        bug_virus.translation.z = bug_virus_translations[i].y
    else:	
        bug_virus.translation.y = bug_virus_translations[i%3].x * (-1)
        bug_virus.translation.z = bug_virus_translations[i%3].y * (-1)
        
func rotate_bug_virus(bug_virus,i):
    # rotate bug/virus under some angle
    angle =  i * (PI / 3)	
    bug_virus.rotate_x(angle)
