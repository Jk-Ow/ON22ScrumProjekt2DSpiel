extends CharacterBody2D

@export var walk_speed : float = 30
@export var running_speed : float = 50


func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	input_direction = input_direction.normalized()
	
	if input_direction == Vector2.ZERO:
		$AnimationPlayer/AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationPlayer/AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationPlayer/AnimationTree.set("parameters/Idle/blend_position", input_direction)
		$AnimationPlayer/AnimationTree.set("parameters/Walk/blend_position", input_direction)

	if(Input.get_action_strength("run") != 0):
		velocity = input_direction * running_speed
	else:
		velocity = input_direction * walk_speed
	move_and_slide()
