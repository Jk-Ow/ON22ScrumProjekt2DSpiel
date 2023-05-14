extends CharacterBody2D
var player_in_range = false
var aware_of_player = false
var cooldown = true
var health = 100
var speed = 120
var direction
signal mob_attacking

func _ready():
	var attention_zone = get_node("AttentionZone")
	var attack_zone = get_node("AttackZone")
	var attack_cooldown = get_node("attack_cooldown")
	if(!global.player.attacking.is_connected(_on_player_character_attacking)):
		global.player.attacking.connect(_on_player_character_attacking)
	if(!attention_zone.body_entered.is_connected(_on_attention_zone_body_entered)):
		attention_zone.body_entered.connect(_on_attention_zone_body_entered)
	if(!attention_zone.body_exited.is_connected(_on_attention_zone_body_exited)):
		attention_zone.body_exited.connect(_on_attention_zone_body_exited)
	if(!attack_zone.body_entered.is_connected(_on_attack_zone_body_entered)):
		attack_zone.body_entered.connect(_on_attack_zone_body_entered)
	if(!attack_zone.body_exited.is_connected(_on_attack_zone_body_exited)):
		attack_zone.body_exited.connect(_on_attack_zone_body_exited)
	if(!attack_cooldown.timeout.is_connected(_on_attack_cooldown_timeout)):
		attack_cooldown.timeout.connect(_on_attack_cooldown_timeout)

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
		print("attacking_player")
		mob_attacking.emit()
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
		#$AnimationTree.set()


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
