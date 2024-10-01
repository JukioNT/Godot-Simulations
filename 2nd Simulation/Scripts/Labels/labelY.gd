extends Node

var position
var body
var label
@export var precision = 3

func _ready():
	label = get_node(".")
	body = get_parent().get_parent()

func _process(delta):
	position = body.GetXY()
	var y = round(position.y * pow(10.0, precision)) / pow(10.0, precision)
	label.text = "Y: " + str(y)
