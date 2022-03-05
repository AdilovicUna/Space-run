extends TextureProgress

onready var main = get_parent().get_parent()

func _on_DropTimer_timeout():
    decrease_value()
    
func decrease_value():
    value -= 1
    get_child(0).text = String(value) + "%"
    
    if value == 0:
        main._game_over()
        return
        
func update_timer():
    $DropTimer.wait_time -= 0.02
