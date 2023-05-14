extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if(!global.player.update_health_plants.is_connected(_on_player_update_health_plants)):
		global.player.update_health_plants.connect(_on_player_update_health_plants)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_update_health_plants(amount):
	$health_plants/health_plant_amount.text = str(amount)
