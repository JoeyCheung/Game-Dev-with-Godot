extends Area2D

func _ready():
	pass

func _on_UD_area_entered(area):
	if area.get_name() == "Move":
		get_node("/root/Main/Pacman").up_down_movement = true
	if area.get_name() == "move":
		get_node("/root/Main/red").up_down = true
	if area.get_name() == "move!":
		get_node("/root/Main/red2").up_down = true
	if area.get_name() == "move!!":
		get_node("/root/Main/red3").up_down = true
	if area.get_name() == "move!!!":
		get_node("/root/Main/red4").up_down = true

func _on_UD_area_exited(area):
	if area.get_name() == "Move":
		get_node("/root/Main/Pacman").up_down_movement = false
	if area.get_name() == "move":
		get_node("/root/Main/red").up_down = false
	if area.get_name() == "move!":
		get_node("/root/Main/red2").up_down = false
	if area.get_name() == "move!!":
		get_node("/root/Main/red3").up_down = false
	if area.get_name() == "move!!!":
		get_node("/root/Main/red4").up_down = false
