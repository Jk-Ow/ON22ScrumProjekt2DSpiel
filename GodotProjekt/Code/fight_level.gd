extends Node2D

func _ready():
	if ($AudioStreamPlayer.playing == false):
		$AudioStreamPlayer.play()
