extends Sprite2D
@onready var player = get_node("/root/startLevel/playerCharacter")

func _ready():
	if(global.evil_tree_alive):
		$AnimationPlayer.play("Idle")
	else:
		self.set_frame(8)

func _on_engage_area_body_entered(body):
	if(global.evil_tree_alive):
		if (body.has_method("player")):
			global.player_position = player.position
			get_tree().change_scene_to_file("res://Levels/fight_level.tscn")
