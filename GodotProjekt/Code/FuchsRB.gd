extends StaticBody2D

signal attack(damage)

@onready var stateMachine = $AnimationTree.get("parameters/playback")

func _ready():
	if(!$AnimationTree.animation_finished.is_connected(_on_animation_tree_animation_finished)):
		$AnimationTree.animation_finished.connect(_on_animation_tree_animation_finished)

func _physics_process(_delta):
	$HealthBarFox.value = global.health
	if (Input.is_action_just_pressed("attack") and global.health > 0):
		stateMachine.travel("Attack")
		attack.emit(15)
	if (Input.is_action_just_pressed("heal") and global.health > 0 and global.health_plant_amount>0):
		global.health += 30
		global.health_plant_amount -= 1

func _on_baum_mob_attacking(damage):
	global.health -= damage
	if(global.health > 0):
		stateMachine.travel("Hurt")
	else:
		stateMachine.travel("Death")


func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == "Death"):
		global.start_new_game = true
