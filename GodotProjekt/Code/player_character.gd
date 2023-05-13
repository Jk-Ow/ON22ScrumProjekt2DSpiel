extends CharacterBody2D

@export var walk_speed : float = 30
@export var running_speed : float = 50
var cooldown = true;
var current_weapon_damage = 20
signal attacking
var health = 100
var last_direction
var health_plants = 10
var heal_cooldown = true


func _physics_process(_delta):
	if(Input.is_action_just_pressed("heal") and health_plants > 0 and heal_cooldown):
		health_plants -= 1
		health += 30
		heal_cooldown = false
		$heal_cooldown.start()
		if(health > 100):
			health = 100
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	if(input_direction != Vector2.ZERO):
		last_direction = input_direction
	input_direction = input_direction.normalized()
	if cooldown:
		if input_direction == Vector2.ZERO:
			$AnimationTree.get("parameters/playback").travel("Idle")
		else:
			$AnimationTree.get("parameters/playback").travel("Walk")
			$AnimationTree.set("parameters/Idle/blend_position", input_direction)
			$AnimationTree.set("parameters/Walk/blend_position", input_direction)
	attack()
	if(Input.get_action_strength("run") != 0):
		velocity = input_direction * running_speed
	else:
		velocity = input_direction * walk_speed
	move_and_slide()

func attack():
	if(cooldown):
		if(Input.is_action_just_pressed("attack") and cooldown):
			$AnimationTree.get("parameters/playback").travel("Attack")
			$AnimationTree.set("parameters/Attack/blend_position", last_direction)
			#play attack animation
			#start cooldown timer
			cooldown = false
			$attack_cooldown.start()
			attacking.emit()


func _on_attack_cooldown_timeout():
	cooldown = true
	
func player():
	pass


func _on_scarecrow_mob_attacking():
	health -= 10
	print(health)


func _on_slime_mob_attacking():
	health -= 10
	print(health)
	
func _on_give_health_plant():
	health_plants += 1

func _on_heal_cooldown_timeout():
	heal_cooldown = true
