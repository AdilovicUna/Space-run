extends Label

var score = 0.0
var game_over = false

func _on_Meter_Passed():
    if not game_over:
        score += 0.02
        text = "Score: %.1f" % score

func _display_Final_Score():
    game_over = true
    text = "Final Score: %.1f" % score
    set_align(ALIGN_CENTER)
    rect_position = Vector2(32,120)

func _reset():
    score = 0.0
    text = "Score: %.1f" % score
    game_over = false
    set_align(ALIGN_LEFT)
    rect_position = Vector2(32,24)
