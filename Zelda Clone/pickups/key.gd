extends "res://pickups/pickup.gd"

func body_entered(body):
	if body.name == "player" && body.keys < 9:
		body.keys += 1
		destroy()