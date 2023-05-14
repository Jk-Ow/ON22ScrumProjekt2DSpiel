extends CharacterBody2D
var player_in_range = false
var aware_of_player = false
var cooldown = true
var health = 100
var speed = 120
var direction
var last_direction
var alive = true
signal mob_attacking(damage)
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var start_position = self.position
@onready var solid_body = get_node("solid_body")
@onready var player = get_node("/root/startLevel/playerCharacter")

func _ready():
	var attention_zone = get_node("AttentionZone")
	var attack_zone = get_node("AttackZone")
	var attack_cooldown = get_node("attack_cooldown")
	var respawn_timer = get_node("respawn_timer")
	var animation_tree = get_node("AnimationTree")
	if(!player.attacking.is_connected(_on_player_character_attacking)):
		player.attacking.connect(_on_player_character_attacking)
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
	if(!respawn_timer.timeout.is_connected(_on_respawn_timer_timeout)):
		respawn_timer.timeout.connect(_on_respawn_timer_timeout)
	if(!animation_tree.animation_finished.is_connected(_on_animation_tree_animation_finished)):
		animation_tree.animation_finished.connect(_on_animation_tree_animation_finished)

func _process(_delta):
	if(health > 0):
		move_to_player()
		attack_player()
	else:
		if(alive):
			die()
		


func move_to_player():
	if(alive):
		if(aware_of_player):
			direction = (player.get_global_position() - self.get_global_position())
			direction = direction.normalized()
			velocity = direction * speed
			update_animation_parameters(direction)
			move_and_slide()

func attack_player():
	if(alive):
		if(cooldown and player_in_range):
			mob_attacking.emit(5)
			cooldown = false
			$attack_cooldown.start()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		$AnimationTree.set("parameters/Idle_all/blend_position", move_input)
		$AnimationTree.set("parameters/Alert_all/blend_position", move_input)
		$AnimationTree.set("parameters/Hurt_all/blend_position", move_input)

func die():
	alive = false
	state_machine.travel("death")

func _on_player_character_attacking(damage):
	if(alive):
		if(player_in_range):
			health -= damage
			state_machine.travel("Hurt_all")

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
	if(alive):
		if(body.has_method("player")):
			aware_of_player = true
			state_machine.travel("Alert_all")

func _on_attention_zone_body_exited(body):
	if(body.has_method("player")):
		aware_of_player = false

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == "death"):
		self.visible = false
		solid_body.disabled = true
		$respawn_timer.start()

func _on_respawn_timer_timeout():
	alive = true
	health = 100
	self.visible = true
	solid_body.disabled = false
	self.position = start_position
	state_machine.travel("Idle_all")
