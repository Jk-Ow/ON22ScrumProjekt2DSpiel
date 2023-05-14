extends CharacterBody2D

@export var walk_speed : float = 120
@export var running_speed : float = 200
var cooldown = true;
var current_weapon_damage = 20
signal attacking(damage)
var health = 100
var input_direction
var last_direction
var health_plants = 1
var heal_cooldown = true
@onready var root_node = get_node("/root/startLevel")
@onready var enemy_nodes = root_node.get_tree().get_nodes_in_group("enemy")
@onready var health_plant_nodes = root_node.get_tree().get_nodes_in_group("health_plants")

func _ready():
	if(global.player_position != Vector2.ZERO):
		self.position = global.player_position
	health_plants = global.health_plant_amount
	for item in enemy_nodes:
		if(!item.mob_attacking.is_connected(_on_mob_attacking)):
			item.mob_attacking.connect(_on_mob_attacking)
	for item in health_plant_nodes:
		if(!item.give_health_plant.is_connected(_on_give_health_plant)):
			item.give_health_plant.connect(_on_give_health_plant)

func _physics_process(_delta):
	update_hud()
	get_direction_and_speed()
	play_walk_sound()
	player()
	if(health<=0):
		die()

func attack():
	if(cooldown):
		if(Input.is_action_just_pressed("attack") and cooldown):
			$AnimationTree.get("parameters/playback").travel("Attack")
			$AttackSound.play()
			$AnimationTree.set("parameters/Attack/blend_position", last_direction)
			#play attack animation
			#start cooldown timer
			cooldown = false
			$attack_cooldown.start()
			attacking.emit(current_weapon_damage)

func heal():
	if(Input.is_action_just_pressed("heal") and health_plants > 0 and heal_cooldown):
		health_plants -= 1
		health += 30
		heal_cooldown = false
		$heal_cooldown.start()
		if(health > 100):
			health = 100

func animate():
	if cooldown:
		if input_direction == Vector2.ZERO:
			$AnimationTree.get("parameters/playback").travel("Idle")
			$WalkSound.stop()
		else:
			$AnimationTree.get("parameters/playback").travel("Walk")
			$AnimationTree.set("parameters/Idle/blend_position", input_direction)
			$AnimationTree.set("parameters/Walk/blend_position", input_direction)

func get_direction_and_speed():
	input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	if(input_direction != Vector2.ZERO):
		last_direction = input_direction
	input_direction = input_direction.normalized()
	if(Input.get_action_strength("run") != 0):
		velocity = input_direction * running_speed
	else:
		velocity = input_direction * walk_speed

func play_walk_sound():
	if(input_direction != Vector2.ZERO and !$WalkSound.playing):
		$WalkSound.play()

func update_hud():
	global.health_plant_amount = health_plants
	global.health = health

func die():
	pass

func _on_attack_cooldown_timeout():
	cooldown = true
	
func player():
	animate()
	attack()
	heal()
	move_and_slide()

func _on_mob_attacking(damage):
	health -= damage
	print(health)

func _on_give_health_plant():
	if (health_plants < 10):
		health_plants += 1
	print(health_plants)

func _on_heal_cooldown_timeout():
	heal_cooldown = true
