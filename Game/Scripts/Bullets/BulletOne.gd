extends Spatial

onready var hans = get_node_or_null("../Hans")

export var speed = 100

const queue_free_time = 2
var timer = 0

func _physics_process(delta):
    global_translate(Vector3.LEFT * speed * delta)
    
    timer += delta
    
    if timer >= queue_free_time:
        hans.bullets_in_air -= 1
        queue_free()
