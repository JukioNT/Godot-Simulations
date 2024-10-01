extends Control

signal pause_change(paused)

var root
var action

func _ready():
	var btn = get_node(".")
	var btnName = btn.name
	root = get_node("/root/Node2D")
	
	if btnName == "PauseButton":
		action = 1
	elif btnName == "SpeedButton":
		action = 2
	
	btn.connect("pressed", Callable(self, "_on_button_toggled"))
	
func _on_button_toggled():
	for body in root.get_children():
		if body is Area2D:
			body.press(action)
