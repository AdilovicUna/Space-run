extends Label

onready var score = get_node("../UI/Score")

func display():
	text = "Final score: %.1f" % score.get("score")
