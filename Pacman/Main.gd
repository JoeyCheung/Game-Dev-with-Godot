extends Node
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if get_node("/root/Main/Pacman").points == 244:
		game_won()
	
#Check if game_won and game_lost functions are correct or not
func game_won():
	print("You won")
	
func game_over():
	print("You lost")