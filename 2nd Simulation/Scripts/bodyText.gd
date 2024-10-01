extends Node

var camera
var boxContainer
var size

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("/root/Node2D/Camera2D")
	boxContainer = get_node(".")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	size = 0.4 / camera.GetZoom().x
	
	boxContainer.scale=Vector2(size,size)
