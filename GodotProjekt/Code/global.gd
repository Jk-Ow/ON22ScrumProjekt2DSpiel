extends Node2D

var healthplant
@onready var base_level = self
@onready var player = get_node("/root/startLevel/playerCharacter")
@onready var health_plants = base_level.get_tree().get_nodes_in_group("health_plants")
@onready var enemy = base_level.get_tree().get_nodes_in_group("enemy")

func _ready():
	if(true):
		var base_level = self
		var player = get_node("/root/startLevel/playerCharacter")
		var health_plants = base_level.get_tree().get_nodes_in_group("health_plants")
		var enemy = base_level.get_tree().get_nodes_in_group("enemy")
