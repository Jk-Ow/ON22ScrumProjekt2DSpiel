extends Node2D

func _ready():
	if ($AudioStreamPlayer.playing == false):
		$AudioStreamPlayer.play()
	$Fuchs/AnimationPlayer.play("Idle")
	$Baum/AnimationPlayer.play("Idle")
	$WaitForAttack.start()

func _physics_process(_delta):
	pass#if (Input.is_action_just_pressed("attack")):


func _on_wait_for_attack_timeout():
	$QuickLight.set_frame(2)
	$Attack.start()
	$WaitForAttack.wait_time = randf() + 1.0


func _on_attack_timeout():
	$QuickLight.set_frame(1)
	$WaitForBlock.start()


func _on_wait_for_block_timeout():
	$QuickLight.set_frame(0)
	$Block.start()
	$WaitForBlock.wait_time = randf()+ 1.0


func _on_block_timeout():
	$QuickLight.set_frame(1)
	$WaitForAttack.start()


