extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if(global.evil_tree_alive):
		self.set_frame(0)
	else:
		self.set_frame(1)
		$broken/CollisionShape2D.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
