extends StaticBody2D

var health = 200

@onready var stateMachine = $AnimationTree.get("parameters/playback")

signal mob_attacking(damage)

func _physics_process(_delta):
	pass

func _on_fuchs_attack(damage):
	$HealthBarTree.value = health
	if (health <= 0) :
		$HealthBarTree.visible = false
		global.evil_tree_alive = false
		stateMachine.travel("Death")
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://Levels/start_level.tscn")
	else:
		health -= damage
		stateMachine.travel("Hurt")

func _on_block_timeout():
	if(health > 0):
		stateMachine.travel("Attack")
		mob_attacking.emit(20)
