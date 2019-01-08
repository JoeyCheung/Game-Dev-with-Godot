extends Area2D

export(bool) var disappears = false
export(String, FILE) var sound = "res://pickups/item.wav"

func _ready():
	if disappears == true:
		add_to_group("disappears")
	connect("body_entered",self,"body_entered")
	connect("area_entered",self,"area_entered")

func destroy():
	if File.new().file_exists(sound):
		sfx.play(load(sound))
	queue_free()

func area_entered(area):
	var area_parent = area.get_parent()
	if area_parent.name == "sword":
		body_entered(area_parent.get_parent())