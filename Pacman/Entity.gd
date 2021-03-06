extends KinematicBody2D

const SPEED = 0
var movedir = Vector2(0,0)
var spritedir = "down"

func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))
	
func spritedir_loop():
	match movedir:
		Vector2(-1,0):
			spritedir = "left"
			$AnimatedSprite.animation = "left"
		Vector2(1,0):
			spritedir = "right"
			$AnimatedSprite.animation = "right"
		Vector2(0,-1):
			spritedir = "up"
			$AnimatedSprite.animation = "up"
		Vector2(0,1):
			spritedir = "down"
			$AnimatedSprite.animation = "down"