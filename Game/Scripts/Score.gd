extends Label

var score = 0.0

func _on_Meter_Passed():
	score += 0.02
	text = "Score: %.1f" % score

func _display_Final_Score():
	text = "Final Score: %.1f" % score
	set_align(ALIGN_CENTER)
