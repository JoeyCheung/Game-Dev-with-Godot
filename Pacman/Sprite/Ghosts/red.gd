extends "res://Entity.gd"

const SPEED = 100

var movetimer_length = 15
var movetimer = 0
var up_down = false
var right_left = false
var startMovement = Vector2(1.7,0)
var next_movement

func _ready():
	$anim.play("default")
	movedir = dir.rand()
	
func _physics_process(delta):
	movement_loop()
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = dir.rand()
		movetimer = movetimer_length
		
	if position.x<0:
		position.x=450
	if position.x>450:
		position.x=0
		
	if up_down:
		if next_movement == "down":
			movedir = Vector2(0,1.9)
		
		if next_movement == "up":
			movedir = Vector2(0,-1.9)
		
	if right_left:
		if next_movement == "right":
			movedir = Vector2(1.9,0)
		
		if next_movement == "left":
			movedir = Vector2(-1.9,0)
		
	if movedir == Vector2(0,0):
		move_and_collide(startMovement)
	else:
		move_and_collide(movedir)