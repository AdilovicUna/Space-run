extends Spatial

export var speed = 100
onready var score = get_node("../UI/Score")

const queue_free_time = 3
var timer = 0

func _physics_process(delta):
    var real_forward = global_transform.basis.x.normalized()
    global_translate(real_forward * speed * delta)
    
    timer += delta
    if timer >= queue_free_time:
        queue_free()

func _on_Area_body_entered(body):
    if "Hans" in body.name:
        return
        
    if body is KinematicBody and not "Trap" in body.name :
        score._on_Shooting_Obstacle()
        #print(body.hit)
        #body.hit += 1
        #if body.hit == 8:
        body.queue_free()
        
    queue_free()
