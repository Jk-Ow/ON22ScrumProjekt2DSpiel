extends StaticBody2D
var player_in_range = false
var aware_of_player = false
var cooldown = true
var health = 100
signal mob_attacking

func _physics_process(_delta):
	attack_player()
	if(health <= 0):
		self.queue_free()

func attack_player():
	if(cooldown and aware_of_player):
		mob_attacking.emit()
		cooldown = false
		$attack_cooldown.start()

func _on_player_character_attacking():
	if(player_in_range):
		health -= 15
		$AnimationPlayer.play("hurt")

func _on_area_2d_body_entered(body):
	if(body.has_method("player")):
		player_in_range = true
		$reaction_delay.start()

func _on_area_2d_body_exited(body):
	if(body.has_method("player")):
		player_in_range = false
		aware_of_player = false

func _on_attack_cooldown_timeout():
	cooldown = true
	$attack_cooldown.stop()


func _on_reaction_delay_timeout():
	aware_of_player = true
	$reaction_delay.stop()
