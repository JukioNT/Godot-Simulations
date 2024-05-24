extends Sprite2D

var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale.x = 1.5 / camera.zoom.x
	scale.y = 1.5 / camera.zoom.y
