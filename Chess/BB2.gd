extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var isDragging = false
var screensize

func _ready():
	screensize = get_viewport_rect().size

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if isDragging:
		position.x = get_viewport().get_mouse_position().x
		position.y = get_viewport().get_mouse_position().y
		position.x = clamp(position.x, 0, screensize.x)
		position.y = clamp(position.y, 0, screensize.y)

func _on_BB2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				isDragging = true
			if event.is_pressed() == false:
				isDragging = false