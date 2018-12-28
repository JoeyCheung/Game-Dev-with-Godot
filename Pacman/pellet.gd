extends Area2D

func _ready():
	pass

func _on_pellet_area_entered(area):
	if area.get_name() == "collector":
		get_node("/root/Main/Pacman").points += 1
		queue_free()