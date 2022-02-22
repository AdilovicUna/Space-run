extends Label

var level = 0

func update_level():
    level += 1
    text = "Level %s" % level
