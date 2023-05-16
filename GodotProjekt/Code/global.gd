extends Node2D

var health_plant_amount
var start_new_game = true
var health
var show_menu = true
var start_position = Vector2(-191, 830.75)
var player_position = Vector2.ZERO
var evil_tree_alive = true
signal update_health_plants(amount:int)
signal update_health(health_remaining:int)
@onready var base_level = self
@onready var player = get_node("/root/startLevel/playerCharacter")
@onready var health_plants = base_level.get_tree().get_nodes_in_group("health_plants")
@onready var enemy = base_level.get_tree().get_nodes_in_group("enemy")

func _ready():
	randomize()
	new_game()
	
func _process(_delta):
	new_game()
	update_hud()

func update_hud():
	update_health_plants.emit(health_plant_amount)
	update_health.emit(health)

func new_game():
	if(start_new_game):
		player_position = Vector2.ZERO
		get_tree().change_scene_to_file("res://Levels/start_level.tscn")
		health_plant_amount = 0
		health = 100
		evil_tree_alive = true
		start_new_game = false
