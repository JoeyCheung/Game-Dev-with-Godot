extends "res://pickups/pickup.gd"

func body_entered(body):
	if body.name == "player" && body.rupees < body.MAX_RUPEES:
		body.rupees += 1
		destroy()