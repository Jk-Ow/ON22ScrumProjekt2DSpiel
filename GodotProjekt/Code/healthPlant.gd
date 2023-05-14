extends StaticBody2D
signal give_health_plant
var blossoming = true
var player_close = false

func _ready():
	$AnimationPlayer.play("blossom")
	var harvest = get_node("harvest_area")
	var regrow = get_node("regrow_time")
	if(!global.player.attacking.is_connected(_on_player_character_attacking)):
		global.player.attacking.connect(_on_player_character_attacking)
	#connect("give_health_plant",global.player,"_on_give_health_plant")
	if(!regrow.timeout.is_connected(_on_regrow_time_timeout)):
		regrow.timeout.connect(_on_regrow_time_timeout)
	if(!harvest.body_entered.is_connected(_on_harvest_area_body_entered)):
		harvest.body_entered.connect(_on_harvest_area_body_entered)
	if(!harvest.body_exited.is_connected(_on_harvest_area_body_exited)):
		harvest.body_exited.connect(_on_harvest_area_body_exited)

func _on_player_character_attacking(_damage):
	if(blossoming && player_close):
		$AnimationPlayer.play("dead")
		$regrow_time.start()
		give_health_plant.emit()

func _on_regrow_time_timeout():
	$AnimationPlayer.play("blossom")
	blossoming = true


func _on_harvest_area_body_entered(body):
	if(body.has_method("player")):
		player_close = true


func _on_harvest_area_body_exited(body):
	if(body.has_method("player")):
		player_close = false
