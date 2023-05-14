extends Node2D

func _audio():
	if ($BackgroundMusic.playing == false):
		$BackgroundMusic.play()
