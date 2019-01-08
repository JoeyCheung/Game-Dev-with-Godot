extends Node2D

var   TYPE = null
const DAMAGE = 0.5

var maxamount = 1

func start():
	TYPE = get_parent().TYPE
	$anim.connect("animation_finished",self,"destroy")
	$anim.play(str("swing",get_parent().spritedir))
	sfx.play(load(str("res://items/sword_swing",int(rand_range(1,5)),".wav")))
	if get_parent().has_method("state_swing"):
		get_parent().state = "swing"
	
	sword_beam()

func sword_beam():
	if get_parent().health == get_parent().MAXHEALTH:
		var beam = preload("res://items/sword_beam.tscn").instance()
		get_parent().add_child(beam)
		beam.get_node("flash").play("default")
		beam.start()

func destroy(animation):
	if get_parent().has_method("state_swing"):
		get_parent().state = "default"
	queue_free()