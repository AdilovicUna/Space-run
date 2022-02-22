extends Spatial

export var speed = 100

const queue_free_time = 2
var timer = 0

func _physics_process(delta):
    global_translate(Vector3.LEFT * speed * delta)
    
    timer += delta
    
    if timer >= queue_free_time:
        queue_free()
