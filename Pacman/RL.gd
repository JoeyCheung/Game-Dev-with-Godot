extends Area2D

func _ready():
	pass

func _on_RL_area_entered(area):
	if area.get_name() == "Move":
		get_node("/root/Main/Pacman").right_left_movement = true
	if area.get_name() == "move":
		get_node("/root/Main/red").right_left = true
	if area.get_name() == "move!":
		get_node("/root/Main/red2").right_left = true
	if area.get_name() == "move!!":
		get_node("/root/Main/red3").right_left = true
	if area.get_name() == "move!!!":
		get_node("/root/Main/red4").right_left = true

func _on_RL_area_exited(area):
	if area.get_name() == "Move":
		get_node("/root/Main/Pacman").right_left_movement = false
	if area.get_name() == "move":
		get_node("/root/Main/red").right_left = false
	if area.get_name() == "move!":
		get_node("/root/Main/red2").right_left = false
	if area.get_name() == "move!!":
		get_node("/root/Main/red3").right_left = false
	if area.get_name() == "move!!!":
		get_node("/root/Main/red4").right_left = false
