extends Sprite2D

func _ready():
	$AnimationPlayer.play("Idle")

func _on_engage_area_body_entered(body):
	if (body.has_method("player")):
		get_tree().change_scene_to_file("res://Levels/fight_level.tscn")
