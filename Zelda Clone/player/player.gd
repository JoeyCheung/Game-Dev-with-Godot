extends "res://engine/entity.gd"

const MAXHEALTH = 5
const TYPE  = "PLAYER"
const SPEED = 70
var state = "default"

const MAX_RUPEES = 999

var keys = 0
var rupees = 0

signal player_initialized

func _ready():
	sound_damage = preload("res://player/player_hurt.wav")

func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()
		"hold":
			state_hold()
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	rupees = min(rupees, MAX_RUPEES)
	
	if health <= 0 && state != "dead":
		get_node("../hud").queue_free()
		var player_death = preload("res://player/player_death.tscn").instance()
		player_death.global_position = global_position
		get_parent().add_child(player_death)
		player_death.pause_mode = Node.PAUSE_MODE_PROCESS
		hide()
		get_tree().set_pause(true)
	
func state_default():
	controls_loop()
	movement_loop()
	spritedir_loop()
	damage_loop()
	
	if is_on_wall() && hitstun == 0:
		if spritedir == "left" and test_move(transform, Vector2(-1,0)):
			anim_switch("push")
		if spritedir == "right" and test_move(transform, Vector2(1,0)):
			anim_switch("push")
		if spritedir == "up" and test_move(transform, Vector2(0,-1)):
			anim_switch("push")
		if spritedir == "down" and test_move(transform, Vector2(0,1)):
			anim_switch("push")
	elif movedir != Vector2(0,0):
		anim_switch("walk")
	else:
		anim_switch("idle")
	
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/sword.tscn"))
	if Input.is_action_just_pressed("b"):
		use_item(preload("res://items/arrow.tscn"))

func state_swing():
	anim_switch("swing")
	movement_loop()
	damage_loop()
	movedir = dir.center

func state_hold():
	movement_loop()
	damage_loop()
	if movedir != dir.none:
		anim_switch("walk")
	else:
		anim_switch("idle")

func controls_loop():
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)