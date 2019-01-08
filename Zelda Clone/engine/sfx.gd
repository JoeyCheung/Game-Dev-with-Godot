extends Node

func play(sound):
	var sfx = AudioStreamPlayer.new()
	get_tree().get_root().add_child(sfx)
	sfx.set_stream(sound)
	sfx.set_volume_db(-30) # FIX THIS LATER
	sfx.connect("finished",sfx,"queue_free")
	sfx.play()