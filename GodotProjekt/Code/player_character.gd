extends CharacterBody2D

@export var walk_speed : float = 30
@export var running_speed : float = 50
var cooldown = true;
var current_weapon_damage = 20
signal attacking


func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	input_direction = input_direction.normalized()
	
	if input_direction == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position", input_direction)
		$AnimationTree.set("parameters/Walk/blend_position", input_direction)
	attack()
	print(cooldown)
	if(Input.get_action_strength("run") != 0):
		velocity = input_direction * running_speed
	else:
		velocity = input_direction * walk_speed
	move_and_slide()

func attack():
	if(Input.is_action_just_pressed("attack") and cooldown):
		#play attack animation
		#start cooldown timer
		cooldown = false
		$attack_cooldown.start()
		#set atack variable in global
		emit_signal("attacking")


func _on_attack_cooldown_timeout():
	$attack_cooldown.stop()
	cooldown = true
	
func player():
	pass
