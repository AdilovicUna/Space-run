extends Label

var score = 0.0
var game_over = false

func _on_Meter_Passed():
    if not game_over:
        score += 0.02
        text = "Score: %.1f" % score

func _on_Shooting_Obstacle():
    if not game_over:
        score += 10
        text = "Score: %.1f" % score

func _display_Final_Score():
    game_over = true
    text = "Final Score: %.1f" % score
    set_align(ALIGN_CENTER)
    rect_position = Vector2(32,120)
