extends KinematicBody2D

var currentMovement= Vector2(0,0)
var startMovement = Vector2(1.7,0)
var up_down_movement = false
var right_left_movement = false
var next_movement
onready var pacman = get_node("AnimatedPacman")

var points = 0

func ready_movement():
	if Input.is_action_just_pressed("ui_down"):
		next_movement = "down"
		
	if Input.is_action_just_pressed("ui_up"):
		next_movement = "up"
		
	if Input.is_action_just_pressed("ui_right"):
		next_movement = "right"
	
	if Input.is_action_just_pressed("ui_left"):
		next_movement = "left"

func _ready():
	pacman.scale.x = 2
	pacman.scale.y = 2

func _physics_process(delta):
	if position.x<0:
		position.x=450
	if position.x>450:
		position.x=0
		
	ready_movement()
		
	if up_down_movement:
		if next_movement == "down":
			pacman.animation="down"
			currentMovement = Vector2(0,1.9)
		
		if next_movement == "up":
			pacman.animation="up"
			currentMovement = Vector2(0,-1.9)
		
	if right_left_movement:
		if next_movement == "right":
			pacman.animation="right"
			currentMovement = Vector2(1.9,0)
		
		if next_movement == "left":
			pacman.animation="left"
			currentMovement = Vector2(-1.9,0)
		
	if currentMovement == Vector2(0,0):
		move_and_collide(startMovement)
	else:
		move_and_collide(currentMovement)
