extends Node

var speed
var body
var label
@export var precision = 3

func _ready():
	label = get_node(".")
	body = get_parent().get_parent()

func _process(delta):
	speed = body.GetSpeed()
	var hs = round(speed.y * pow(10.0, precision)) / pow(10.0, precision)
	label.text = "HS: " + str(hs)
