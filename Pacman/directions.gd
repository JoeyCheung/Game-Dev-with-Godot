extends Node

const center = Vector2(0,0)
const left = Vector2(-1.9,0)
const right = Vector2(1.9,0)
const up = Vector2(0,-1.9)
const down = Vector2(0,1.9)

func rand():
	var d = randi() % 4 + 1
	match d:
		1:
			return left
		2:
			return right
		3:
			return up
		4:
			return down