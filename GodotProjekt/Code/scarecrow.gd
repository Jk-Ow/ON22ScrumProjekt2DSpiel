extends StaticBody2D
var player_in_range = false
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_player_character_attacking():
	if(player_in_range):
		print("dealt_damage")
		$AnimationPlayer.play("hurt")


func _on_area_2d_body_entered(body):
	if(body.has_method("player")):
		player_in_range = true


func _on_area_2d_body_exited(body):
	if(body.has_method("player")):
		player_in_range = false
