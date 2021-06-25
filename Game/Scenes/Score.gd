extends Label

var score = 0.0

func _on_Meter_Passed():
	score += 0.02
	text= "Score: %.1f" % score
