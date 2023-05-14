extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	if(!global.player.update_health_plants.is_connected(_on_player_update_health_plants)):
		global.player.update_health_plants.connect(_on_player_update_health_plants)
	if(!global.player.update_health.is_connected(_on_player_update_health)):
		global.player.update_health.connect(_on_player_update_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_update_health_plants(amount):
	$health_plants/health_plant_amount.text = str(amount)

func _on_player_update_health(remaining_health):
	$current_health.text = "Health: " + str(remaining_health)
