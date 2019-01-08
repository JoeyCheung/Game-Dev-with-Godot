extends "res://engine/entity.gd"

const SPEED = 40
const DAMAGE = 0.5

var movetimer_length = 150
var movetimer = 0

func _physics_process(delta):
	movement_loop()
	damage_loop()
	spritedir_loop()
	
	if movetimer > 50:
		anim_switch("walk")
	else:
		movedir = dir.center
		$anim.stop()
	
	if movetimer == 25:
		use_item(preload("res://items/arrow.tscn"))
	
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0:
		movedir = dir.rand()
		movetimer = int(rand_range(movetimer_length / 2, movetimer_length))
	
	if is_on_wall():
		movedir = -movedir