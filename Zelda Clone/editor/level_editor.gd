extends Node2D

const TILE_SIZE = Vector2(16,16)

var can_draw = true
var current_tile = 0
var tile_rot = [0, 0, 0]
var tile_rot_cycle = 0

const ROTATE_TILES = [4, 5]

var mouse_pos = Vector2(0,0)
var mouse_grid_pos = Vector2(0,0)
onready var tilemap = $TileMap

func _ready():
	if File.new().file_exists("user://map.tscn"):
		load_file()
	$camera.position = find_player() - Vector2(160,128)
	
	$ui/run.connect("mouse_entered",self,"disable_paint")
	$ui/run.connect("mouse_exited",self,"enable_paint")

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				current_tile += 1
			if event.button_index == BUTTON_WHEEL_DOWN:
				current_tile -= 1
			if event.button_index == BUTTON_MIDDLE:
				current_tile = get_tile(get_local_mouse_position() / TILE_SIZE)
	if event is InputEventKey && event.scancode == KEY_TAB && event.is_pressed():
		tile_rot_cycle += 1
	if event is InputEventKey && event.scancode == KEY_ESCAPE && event.is_pressed():
		can_draw = true

func _process(delta):
	print(can_draw)
	mouse_pos = tilemap.get_local_mouse_position()
	
	mouse_grid_pos.x = floor(mouse_pos.x / 16) * 16 + 8
	mouse_grid_pos.y = floor(mouse_pos.y / 16) * 16 + 8
	
	if can_draw:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			paint_tile(current_tile)
		if Input.is_mouse_button_pressed(BUTTON_RIGHT):
			paint_tile(-1)
	
	var tile_amount = tilemap.tile_set.get_tiles_ids().size()
	current_tile = clamp(current_tile, 0, tile_amount - 1)
	
	$ui/current_tile.text = tilemap.tile_set.tile_get_name(current_tile)
	
	update_tile_preview()
	camera_movement()
	tile_rotation()

func tile_rotation():
	match tile_rot_cycle:
		0:
			tile_rot = [false, false, false]
		1:
			tile_rot = [true, false, true]
		2:
			tile_rot = [false, true, false]
		3:
			tile_rot = [false, false, true]
		4:
			tile_rot_cycle = 0
	if !ROTATE_TILES.has(current_tile):
		tile_rot_cycle = 0

func update_tile_preview():
	$tile_preview.position = Vector2(mouse_grid_pos.x,mouse_grid_pos.y)
	$tile_preview.texture = tilemap.tile_set.tile_get_texture(current_tile)
	if ROTATE_TILES.has(current_tile):
		$tile_preview.rotation_degrees = tile_rot_degree(tile_rot)
	else:
		$tile_preview.rotation_degrees = 0
	if current_tile == 0:
		$tile_preview.region_rect = Rect2(16,16,16,16)
	else:
		$tile_preview.region_rect = tilemap.tile_set.tile_get_region(current_tile)

func camera_movement():
	var movedir = Vector2(0,0)
	var speed = 2 * (int(Input.is_key_pressed(KEY_SHIFT)) + 1)
	
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
	$camera.position.x = clamp($camera.position.x, -16, 1456)
	$camera.position.y = clamp($camera.position.y, -16, 1152)
	
	$camera.position += movedir * speed

func _draw():
	for i in 60:
		draw_line(Vector2(i * 160, 16), Vector2( i * 160, 1280), Color("828282"), 2)
		draw_line(Vector2(0, 128 * i + 16), Vector2(1600,128 * i + 16), Color("828282"), 2)

func paint_tile(id):
	if id == 1:
		for tile in tilemap.get_used_cells():
			if tilemap.get_cell(tile.x,tile.y) == 1:
				tilemap.set_cell(tile.x,tile.y, -1)
	var tile_pos = get_local_mouse_position() / TILE_SIZE
	if get_tile(tile_pos) == 1:
		return
	if ROTATE_TILES.has(id):
		tilemap.set_cell(tile_pos.x, tile_pos.y, id, tile_rot[0], tile_rot[1], tile_rot[2])
	else:
		tilemap.set_cell(tile_pos.x, tile_pos.y, id)
	tilemap.update_bitmask_area(tile_pos)

func erase_tile():
	var tile_pos = get_local_mouse_position() / TILE_SIZE
	if get_tile(tile_pos) == 1:
		return
	tilemap.set_cell(tile_pos.x, tile_pos.y, -1)
	tilemap.update_bitmask_area(tile_pos)

func get_tile(tile_pos):
	return tilemap.get_cell(tile_pos.x, tile_pos.y)

func tile_rot_degree(rot):
	match rot:
		[true, false, true]:
			return 90
		[false, true, false]:
			return 180
		[false, false, true]:
			return 270
	return 0

func find_player():
	for tile in tilemap.get_used_cells():
		if tilemap.get_cell(tile.x,tile.y) == 1:
			return tilemap.map_to_world(tile)
	return Vector2(0,0)

func save_file():
	var packed_scene = PackedScene.new()
	packed_scene.pack(tilemap)
	ResourceSaver.save("user://map.tscn", packed_scene)

func load_file():
	var new_map = load("user://map.tscn").instance()
	add_child(new_map)
	var old_map = tilemap
	tilemap = new_map
	old_map.queue_free()

func _on_run_pressed():
	save_file()
	get_tree().change_scene("res://editor/level_player.tscn")

func enable_paint():
	can_draw = true

func disable_paint():
	can_draw = false