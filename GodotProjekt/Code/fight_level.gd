extends Node2D

func _ready():
	if ($AudioStreamPlayer.playing == false):
		$AudioStreamPlayer.play()
	$Fuchs/AnimationPlayer.play("Idle")
	$Baum/AnimationPlayer.play("Idle")

func _physics_process(_delta):
	pass#if (Input.is_action_just_pressed("attack")):
		
