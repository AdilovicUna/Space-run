extends Spatial

export var speed = 100
onready var sound = get_node("/root/Main/Hans/Sounds/ShootSomethingDownSound")
onready var score = get_node("/root/Main/UI/Score")

const queue_free_time = 3
var timer = 0

func _physics_process(delta):
    # give bullet speed and direction
    global_translate(Vector3.LEFT * speed * delta)
    
    # remove the bullet form the scene after certian time
    timer += delta
    if timer >= queue_free_time:
        queue_free()

func _on_Area_body_entered(body):
    # bullets can't hit Hans so we disregard if it happens
    if "Hans" in body.name:
        return
        
    if body is KinematicBody and not "Trap" in body.name and not "Token" in body.name:
        # remove the hit obstacle
        #print(body.hit)
        body.hit += 1
        if body.hit == 8:
            body.hit = 0
            sound.play()
            body.queue_free()
                
        # increase score by 10
        score._on_Shooting_Obstacle()
        
    # remove the bullet when it hits anything, including traps
    queue_free()
