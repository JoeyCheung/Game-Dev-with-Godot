extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var map = get_node("Board")
var white_turn = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if $Music.playing == false:
		$Music.play(0.0)
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				var tile = map.world_to_map(event.position)
				