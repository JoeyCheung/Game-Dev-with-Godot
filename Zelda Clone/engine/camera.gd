extends Camera2D

onready var player = get_node("../player")
var grid_pos = Vector2(0,0)

func _ready():
	$area.connect("body_entered",self,"body_entered")
	$area.connect("body_exited",self,"body_exited")
	$area.connect("area_exited",self,"area_exited")

func _process(delta):
	global_position = get_grid_pos(player.global_position - Vector2(0,16)) * Vector2(160,128)
	grid_pos = get_grid_pos(global_position)

func get_grid_pos(pos):
	var x = floor(pos.x / 160)
	var y = floor(pos.y / 128)
	return Vector2(x,y)

func get_enemies():
	var enemies = []
	for body in $area.get_overlapping_bodies():
		if body.get("TYPE") == "ENEMY" && enemies.find(body) == -1:
			enemies.append(body)
	return enemies.size()

func body_entered(body):
	if body.get("TYPE") == "ENEMY":
		body.set_physics_process(true)
		body.set_process(true)

func body_exited(body):
	if body.get("TYPE") == "ENEMY":
		body.set_physics_process(false)
		body.set_process(false)

func area_exited(area):
	var body = area.get_parent()
	if body.get_groups().has("projectile"):
		body.queue_free()
	if area.get_groups().has("disappears"):
		area.queue_free()