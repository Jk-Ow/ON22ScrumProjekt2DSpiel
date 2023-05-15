extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(global.show_menu):
		self.visible = global.show_menu
		get_tree().paused = true
	else:
		self.visible = global.show_menu


func _on_start_pressed():
	global.start_new_game = true
	global.show_menu = false
	get_tree().paused = false


func _on_continue_pressed():
	global.show_menu = false
	get_tree().paused = false

