extends CharacterBody2D

@export var move_speed : float = 100
@export var running_speed : float = 200


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

		
	if(Input.get_action_strength("run") > 0):
		velocity = input_direction * running_speed
	else:
		velocity = input_direction * move_speed
	move_and_slide()
