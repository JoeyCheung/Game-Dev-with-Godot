extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var hit = false

func _ready():
	$LoseLabel.hide()

func _process(delta):
	if $UFO.hit == false and hit == true:
		print("lose")
		$UFO.lose = true
		$LoseLabel.show()
	if $UFO.hit == true:
		$UFO.clicks += 1
		$ClicksLabel.text = "Clicks: " + str($UFO.clicks)
	$UFO.hit = false
	hit = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		hit = true