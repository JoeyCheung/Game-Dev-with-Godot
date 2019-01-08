extends Node2D

func _ready():
	sfx.play(preload("res://enemies/enemy_death.wav"))
	$anim.play("default")
	$anim.connect("animation_finished",self,"destroy")

func destroy(animation):
	queue_free()