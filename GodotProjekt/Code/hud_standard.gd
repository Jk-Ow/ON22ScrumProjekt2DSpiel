extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if(!global.update_health_plants.is_connected(_on_player_update_health_plants)):
		global.update_health_plants.connect(_on_player_update_health_plants)
	if(!global.update_health.is_connected(_on_player_update_health)):
		global.update_health.connect(_on_player_update_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print(get_tree().current_scene.name)
	if(get_tree().current_scene.name == "Fight_level"):
		$HealthBar.visible = false
		$MiniMap.visible = false
	else:
		$HealthBar.visible = true
		$MiniMap.visible = true
	if(global.show_menu):
		self.visible = false
	else:
		self.visible = true

func _on_player_update_health_plants(amount):
	$health_plants/health_plant_amount.text = str(amount)

func _on_player_update_health(remaining_health):
	$current_health.text = str(remaining_health)
	if(remaining_health <= 0):
		$HealthBar/Sprite2D.set_frame(10)
	else:
		$HealthBar/Sprite2D.set_frame(10 - floor(remaining_health/10))


func _on_menu_pressed():
	self.visible = false
	global.show_menu = true
