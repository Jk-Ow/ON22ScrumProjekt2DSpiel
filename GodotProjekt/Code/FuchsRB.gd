extends StaticBody2D

signal attack(damage)

var player_health = 100

@onready var stateMachine = $AnimationTree.get("parameters/playback")

func _physics_process(_delta):
	if (Input.is_action_just_pressed("attack")):
		stateMachine.travel("Attack")
		attack.emit(10)
		
func _on_baum_mob_attacking(damage):
	player_health -= damage
	stateMachine.travel("Hurt")
	print(player_health)
	if (player_health <= 0) :
		stateMachine.travel("Death")
