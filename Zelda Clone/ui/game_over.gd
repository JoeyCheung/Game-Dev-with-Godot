extends CanvasLayer

func _ready():
	get_tree().set_pause(false)

func _input(event):
	if event.is_action_pressed("start"):
		get_tree().change_scene("res://editor/level_player.tscn")