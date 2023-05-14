extends StaticBody2D
var player_in_range = false

func _physics_process(_delta):
	pass

func _on_player_character_attacking():
	if(player_in_range):
		$AnimationPlayer.play("hurt")

func _on_area_2d_body_entered(body):
	if(body.has_method("player")):
		player_in_range = true
		$reaction_delay.start()

func _on_area_2d_body_exited(body):
	if(body.has_method("player")):
		player_in_range = false
