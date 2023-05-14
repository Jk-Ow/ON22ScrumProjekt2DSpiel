extends StaticBody2D

var health = 200

@onready var stateMachine = $AnimationTree.get("parameters/playback")

signal mob_attacking(damage)

func _physics_process(_delta):
	pass

func _on_fuchs_attack(damage):
	health -= damage
	stateMachine.travel("Hurt")
	print(health)
	if (health <= 0) :
		stateMachine.travel("Death")
