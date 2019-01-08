extends Node2D

var TYPE = null
const DAMAGE = 0.5

var maxamount = 3

const SPEED = 150
var movedir = null

const fire_sound = preload("res://items/projectile_fire.wav")
const wall_sound = preload("res://items/tink.wav")

func start():
	$area.connect("body_entered",self,"body_entered")
	add_to_group("projectile")
	TYPE = get_parent().TYPE
	movedir = get_parent().last_movedir
	position = get_parent().position
	z_index = get_parent().z_index - 1
	$anim.play(get_parent().spritedir)
	sfx.play(fire_sound)
	
	var new_parent = get_parent().get_parent()
	get_parent().remove_child(self)
	new_parent.add_child(self)

func _process(delta):
	global_position += movedir * SPEED * delta

func body_entered(body):
	if body.get("TYPE") == null:
		sfx.play(wall_sound)
		queue_free()
	elif body.get("TYPE") != TYPE:
		queue_free()