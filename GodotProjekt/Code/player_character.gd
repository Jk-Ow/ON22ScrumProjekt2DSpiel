extends CharacterBody2D

@export var walk_speed : float = 120
@export var running_speed : float = 200
var cooldown = true;
var current_weapon_damage = 20
signal attacking
signal update_health_plants(amount)
signal update_health(remaining_health)
var health = 100
var input_direction
var last_direction
var health_plants = 1
var heal_cooldown = true

func _ready():
	for item in global.enemy:
		if(!item.mob_attacking.is_connected(_on_mob_attacking)):
			item.mob_attacking.connect(_on_mob_attacking)
	for item in global.health_plants:
		if(!item.give_health_plant.is_connected(_on_give_health_plant)):
			item.give_health_plant.connect(_on_give_health_plant)

func _physics_process(_delta):
	update_hud()
	get_direction_and_speed()
	animate()
	attack()
	heal()
	move_and_slide()

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
			attacking.emit()

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
		else:
			$AnimationTree.get("parameters/playback").travel("Walk")
			$WalkSound.play()
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
		
func update_hud():
	update_health_plants.emit(health_plants)
	update_health.emit(health)

func _on_attack_cooldown_timeout():
	cooldown = true
	
func player():
	pass

func _on_mob_attacking(damage):
	health -= damage
	print(health)

func _on_give_health_plant():
	if (health_plants < 10):
		health_plants += 1
	print(health_plants)

func _on_heal_cooldown_timeout():
	heal_cooldown = true
