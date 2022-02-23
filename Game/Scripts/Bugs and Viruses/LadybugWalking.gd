extends Spatial

# generate a number between 0 and 13
# if we add 8, range will be 8-20
# devide by 1000 so we get a range between 0.008 and 0.02
# with a step of 0.001
# (rand_range would give us numbers such as 0.083425)
export(float) var speed = (randi()%13+8) / 1000.0

export(int) var hit = 0
