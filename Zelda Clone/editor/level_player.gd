extends Node

var tilemap = null

func _ready():
	load_file()
	tile_replacer()
	
	

func _input(event):
	if event is InputEventKey && event.scancode == KEY_ESCAPE:
		get_tree().change_scene("res://editor/level_editor.tscn")

func _process(delta):
	if !has_node("camera") && has_node("player"):
		var camera = load("res://engine/camera.tscn").instance()
		var hud = load("res://ui/hud.tscn").instance()
		add_child(camera)
		add_child(hud)
		camera.current = true

func tile_replacer():
	var size = tilemap.get_cell_size()
	var offset = size / 2
	for tile in tilemap.get_used_cells():
		var tile_name = tilemap.get_tileset().tile_get_name(tilemap.get_cell(tile.x, tile.y))
		if tile_name != "wall":
			var path
			var rot = get_tile_rot(tile.x,tile.y)
			match tile_name:
				"player":
					path = "res://player/player.tscn"
				"stalfos":
					path = "res://enemies/stalfos.tscn"
				"moblin":
					path = "res://enemies/moblin.tscn"
				"enemy_door":
					path = "res://tiles/enemy_door.tscn"
				"key_door":
					path = "res://tiles/key_door.tscn"
				"key":
					path = "res://pickups/key.tscn"
			var node = load(path).instance()
			node.global_position = tile * size + offset
			node.rotation_degrees = tile_rot_degree(rot)
			call_deferred("add_child", node)
			tilemap.set_cell(tile.x,tile.y,-1)

func get_tile_rot(x,y):
	var x_flip = tilemap.is_cell_x_flipped(x,y)
	var y_flip = tilemap.is_cell_y_flipped(x,y)
	var transpose = tilemap.is_cell_transposed(x,y)
	return [x_flip, y_flip, transpose]

func tile_rot_degree(rot):
	match rot:
		[true, false, true]:
			return 90
		[false, true, false]:
			return 180
		[false, false, true]:
			return 270
	return 0

func instance_scene(scene):
	var new_scene = load(scene).instance()
	add_child(new_scene)

func load_file():
	var new_map = load("user://map.tscn").instance()
	add_child(new_map)
	tilemap = new_map