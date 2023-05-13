extends Node2D

var player_attacking = true

@onready var player = get_node("/root/startLevel/playerCharacter")
var rng = RandomNumberGenerator.new()

func _audio():
	if ($AudioStreamPlayer.playing == false):
		$AudioStreamPlayer.play()
