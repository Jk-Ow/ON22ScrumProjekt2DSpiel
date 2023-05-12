extends CharacterBody2D
var player_in_range = false
var aware_of_player = false
var cooldown = true
var health = 100
var speed = 30
var direction
signal mob_attacking

func _process(_delta):
	attack_player()
	if(health <= 0):
		self.queue_free()
	if(aware_of_player):
		direction = (global.player.get_global_position() - self.get_global_position())
		direction = direction.normalized()
		velocity = direction * speed
	move_and_slide()

func attack_player():
	if(cooldown and player_in_range):
		emit_signal("mob_attacking")
		cooldown = false
		$attack_cooldown.start()

func _on_player_character_attacking():
	if(player_in_range):
		health -= 15
		$AnimationPlayer.play("hurt")

func _on_attack_cooldown_timeout():
	cooldown = true


func _on_attack_zone_body_entered(body):
	if(body.has_method("player")):
		player_in_range = true
		$AnimationTree.set()


func _on_attack_zone_body_exited(body):
	if(body.has_method("player")):
		player_in_range = false



func _on_attention_zone_body_entered(body):
	if(body.has_method("player")):
		aware_of_player = true
		#$AnimationTree.set("parameters/playback",a)


func _on_attention_zone_body_exited(body):
	if(body.has_method("player")):
		aware_of_player = false
