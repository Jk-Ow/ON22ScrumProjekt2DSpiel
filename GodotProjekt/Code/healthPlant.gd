extends StaticBody2D
signal give_health_plant
var blossoming = true
var player_close = false
func _ready():
	global.player.tscn.connect("character_attacking",self,"_on_player_character_attacking")
	self.connect("give_health_plant",global.player,"_on_give_health_plant")
	self.regrow_time.connect("timeout",self,"_on_regrow_time_timeout")
	self.harvest_area.connect("area_body_entered",self,"_on_harvest_area_body_entered")
	self.harvest_area.connect("area_body_exited",self,"_on_harvest_area_body_exited")

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
