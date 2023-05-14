extends Node2D

@onready var base_level = get_node("/root/startLevel")
@onready var player = get_node("/root/startLevel/playerCharacter")
@onready var health_plants = base_level.get_tree().get_nodes_in_group("health_plants")
@onready var enemy_slimes = base_level.get_tree().get_nodes_in_group("enemy_slimes")
var rng = RandomNumberGenerator.new()
func _ready():
	#var enemy_crabs = get_tree().get_nodes_in_group("enemy_crabs")
	pass
	

func _audio():
	if ($AudioStreamPlayer.playing == false):
		$AudioStreamPlayer.play()
