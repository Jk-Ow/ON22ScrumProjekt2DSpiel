extends Node2D

func _audio():
	if ($AudioStreamPlayer.playing == false):
		$AudioStreamPlayer.play()
