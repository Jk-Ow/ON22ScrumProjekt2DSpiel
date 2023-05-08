extends StaticBody2D
var hit_cooldown
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_character_attacking():
	
	print("dealt_damage")
	$AnimationPlayer.play("hurt")
