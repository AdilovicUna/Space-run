extends Spatial

# generate a number between 0 and 10
# if we add 10, range will be 10-20
# devide by 1000 so we get a range between 0.01 and 0.02
# with a step of 0.001
# (rand_range would give us numbers such as 0.01314...)
export(float) var speed = (randi()%10+10) / 1000.0
