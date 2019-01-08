extends CanvasLayer

onready var player = get_node("../player")

const HEART_ROW_SIZE = 8
const HEART_SIZE = 8

func _ready():
	for i in player.MAXHEALTH:
		var new_heart = Sprite.new()
		new_heart.texture = $hearts.texture
		new_heart.hframes = $hearts.hframes
		$hearts.add_child(new_heart)

func _process(delta):
	for heart in $hearts.get_children():
		var index = heart.get_index() # gets current heart's position in array
		
		var x = (index % HEART_ROW_SIZE) * HEART_SIZE # index/amount's remainder, so 18/8 = 16 R2 so it will be the second heart on that row
		var y = (index / HEART_ROW_SIZE) * HEART_SIZE # index/amount gets where the row is
		
		heart.position = Vector2(x,y)
		
		var last_heart = floor(player.health) # last_heart is the last non-empty heart. this is logic for half hearts and stuff
		if index > last_heart: # if the current heart is greater than the last_heart, it's empty
			heart.frame = 0
		if index == last_heart:
			# works on a 5 frame heart with frame 0 being empty
			heart.frame = (player.health - last_heart) * 4 # 6.25 hearts will subtract the 6 and mult .25 * 4, giving frame 2 which is a quarter heart (.25)
		if index < last_heart: # if it's less than the last_heart it's full
			heart.frame = 4
	
	$keys.text = str(player.keys)
	$rupees.text = str(player.rupees).pad_zeros(3)