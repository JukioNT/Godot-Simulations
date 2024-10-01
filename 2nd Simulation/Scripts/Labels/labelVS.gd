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
	var vs = round(speed.x * pow(10.0, precision)) / pow(10.0, precision)
	label.text = "VS: " + str(vs)
