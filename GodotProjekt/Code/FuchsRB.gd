extends StaticBody2D

signal attack(damage)
var block_now = false
var attack_now = false
var blocked_on_time = false
var attacked_on_time = false
var attack_cooldown = true
var healing_cooldown = true
var weapon_damage = 10

@onready var stateMachine = $AnimationTree.get("parameters/playback")

func _ready():
	if(!$AnimationTree.animation_finished.is_connected(_on_animation_tree_animation_finished)):
		$AnimationTree.animation_finished.connect(_on_animation_tree_animation_finished)

func _physics_process(_delta):
	$HealthBarFox.value = global.health
	quick_attack()
	quick_block()
	healing()

func _on_baum_mob_attacking(damage):
	if(blocked_on_time):
		damage -= (randi() % 5 + 13)
		stateMachine.travel("Block")
	global.health -= damage
	if(global.health > 0):
		stateMachine.travel("Hurt")
	else:
		stateMachine.travel("Death")

func attacking():
	if (global.health > 0):
		var dealt_damage = weapon_damage
		stateMachine.travel("Attack")
		if(attacked_on_time):
			dealt_damage = weapon_damage + (randi() % 3 + 7)
		attack.emit(dealt_damage)

func healing():
	if (Input.is_action_just_pressed("heal") and global.health > 0 and global.health_plant_amount>0):
		global.health += 30
		global.health_plant_amount -= 1
		healing_cooldown = false
		$HealCooldown.start()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == "Death"):
		global.start_new_game = true

func quick_block():
	if(Input.is_action_just_pressed("block") and block_now):
		blocked_on_time = true

func quick_attack():
	if(Input.is_action_just_pressed("attack") and attack_now):
		attacked_on_time = true

func _on_wait_for_attack_timeout():
	blocked_on_time = false
	attacked_on_time = false
	attack_now = true

func _on_attack_timeout():
	attack_now = false
	attacking()

func _on_wait_for_block_timeout():
	blocked_on_time = false
	attacked_on_time = false
	block_now = true

func _on_block_timeout():
	block_now = false

func _on_heal_cooldown_timeout():
	healing_cooldown = true
