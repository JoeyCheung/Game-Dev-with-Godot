extends Node2D

const MAXHEALTH = 1
const TYPE  = "ENEMY"
const SPEED = 0

var movedir = Vector2(0,0)
var last_movedir = Vector2(0,1)
var knockdir = Vector2(0,0)
var spritedir = "down"

var health  = MAXHEALTH
var hitstun = 0
var texture_default = null
var texture_hurt	= null
var sound_damage	= preload("res://enemies/enemy_hurt.wav")

var drop = "res://pickups/heart.tscn"

func _ready():
	if TYPE == "ENEMY":
		set_collision_mask_bit(1,1)
		set_physics_process(false)
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace(".png","_hurt.png"))

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * 125
	move_and_slide(motion, Vector2(0,0))
	if movedir != dir.center && dir.list.has(movedir):
		last_movedir = movedir

func spritedir_loop():
	match movedir:
		Vector2(-1,0):
			spritedir = "left"
		Vector2(1,0):
			spritedir = "right"
		Vector2(0,-1):
			spritedir = "up"
		Vector2(0,1):
			spritedir = "down"

func anim_switch(animation):
	var newanim = str(animation,spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)

func damage_loop():
	health = min(health, MAXHEALTH)
	
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		if TYPE == "ENEMY" && health <= 0:
			enemy_die()
	
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			sfx.play(sound_damage)
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin

func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(item,self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(item,self)).size() > newitem.maxamount:
		newitem.queue_free()
		return
	newitem.start()

func instance_scene(scene):
	var new_scene = scene.instance()
	new_scene.global_position = global_position
	get_parent().add_child(new_scene)

func enemy_die():
	instance_scene(preload("res://enemies/enemy_death.tscn"))
	var drop = randi() % 3
	match drop:
		0:
			instance_scene(preload("res://pickups/heart.tscn"))
		1:
			instance_scene(preload("res://pickups/rupee.tscn"))
	queue_free()