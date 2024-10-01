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
	var x = round(position.x * pow(10, precision)) / pow(10, precision)
	label.text = "X: " + str(x)
