extends Area2D

var speed = 100
var direction = Vector2()
var width
var height
var hit = false
var lose = false
var clicks = 0 

func _ready():
	position = get_viewport_rect().size / 2
	direction.x = rand_range(-1, 1)
	direction.y = rand_range(-1, 1)
	direction = direction.normalized()
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	
func _process(delta):
	position += direction * speed * delta
	if position.x < 0:
		direction.x = -direction.x
	if position.x > width:
		direction.x = -direction.x
	if position.y < 0:
		direction.y = -direction.y
	if position.y > height:
		direction.y = -direction.y

func _on_UFO_input_event(viewport, event, shape_idx):
	if lose:
		return
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		direction.x = rand_range(-1, 1)
		direction.y = rand_range(-1, 1)
		direction = direction.normalized()
		position.x = rand_range(1, width -1)
		position.y = rand_range(1, height -1)
		speed += 5
		hit = true
		$HITSound.play()