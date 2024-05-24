extends Camera2D

var zoom_speed = 0.1
var min_zoom = 0.5
var max_zoom = 10.0

var drag = false
var drag_start_position = Vector2()

func _ready():
	# Habilita o modo de arrastar
	set_process_input(true)

func _input(event):
	# Controle de zoom com a roda do mouse
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoom_speed, zoom_speed)
			zoom = clamp(zoom, Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoom_speed, zoom_speed)
			zoom = clamp(zoom, Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

	# Início do arrastar
	elif event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if not drag:
				drag = true
				drag_start_position = event.position
			else:
				var drag_offset = (drag_start_position - event.position) * zoom
				global_position += drag_offset
				drag_start_position = event.position

	# Final do arrastar
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
			drag = false
