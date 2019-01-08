extends StaticBody2D

func _ready():
	$area.connect("body_entered",self,"body_entered")

func body_entered(body):
	if body.name == "player" && body.get("keys") > 0:
		body.keys -= 1
		sfx.play(preload("res://tiles/key_door.wav"))
		queue_free()