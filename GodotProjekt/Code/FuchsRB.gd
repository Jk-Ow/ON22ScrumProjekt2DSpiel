extends StaticBody2D

signal attack(damage)

var player_alive = true

@onready var stateMachine = $AnimationTree.get("parameters/playback")

func _physics_process(_delta):
	$HealthBarFox.value = global.health
	if (Input.is_action_just_pressed("attack") and player_alive):
		stateMachine.travel("Attack")
		attack.emit(15)
	if (Input.is_action_just_pressed("heal") and player_alive and global.health_plant_amount>0):
		global.health += 30
		global.health_plant_amount -= 1

func _on_baum_mob_attacking(damage):
	global.health -= damage
	stateMachine.travel("Hurt")
	if (global.health <= 0 and player_alive) :
		player_alive = false
		stateMachine.travel("Death")
