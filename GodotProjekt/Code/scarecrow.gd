extends StaticBody2D
var player_in_range = false

func _ready():
	var player = get_node("/root/startLevel/playerCharacter")
	if(!player.attacking.is_connected(_on_player_character_attacking)):
		player.attacking.connect(_on_player_character_attacking)

func _physics_process(_delta):
	pass

func _on_player_character_attacking(_damage):
	if(player_in_range):
		$AnimationPlayer.play("hurt")

func _on_area_2d_body_entered(body):
	if(body.has_method("player")):
		player_in_range = true

func _on_area_2d_body_exited(body):
	if(body.has_method("player")):
		player_in_range = false
