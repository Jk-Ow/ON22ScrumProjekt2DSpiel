extends StaticBody2D
signal give_health_plant
var blossoming = true
var player_close = false

func _ready():
	$AnimationPlayer.play("blossom")
	var harvest = get_node("harvest_area")
	var regrow = get_node("regrow_time")
	global.player.attacking.connect(_on_player_character_attacking)
	#connect("give_health_plant",global.player,"_on_give_health_plant")
	regrow.timeout.connect(_on_regrow_time_timeout)
	harvest.body_entered.connect(_on_harvest_area_body_entered)
	harvest.body_exited.connect(_on_harvest_area_body_exited)

func _on_player_character_attacking():
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
