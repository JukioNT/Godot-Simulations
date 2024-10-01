extends Camera2D

var dragging = false
var last_mouse_position = Vector2()

# Zoom factors
var zoom_factor = 1
var min_zoom = Vector2(0.0001, 0.0001)
var max_zoom = Vector2(10, 10)

var dragSpeed

func _input(event):
	# Controle de arrasto da câmera
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				last_mouse_position = event.position
			else:
				dragging = false

	# Movimento da câmera
	if dragging and event is InputEventMouseMotion:
		var delta = event.position - last_mouse_position
		dragSpeed = delta / zoom
		position -= dragSpeed
		last_mouse_position = event.position

	# Controle de zoom
	zoom_factor = zoom.x / 10
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoom_factor, zoom_factor)
			zoom = clamp(zoom, min_zoom, max_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoom_factor, zoom_factor)
			zoom = clamp(zoom, min_zoom, max_zoom)

func GetZoom():
	return zoom
	
func GetPos():
	return position
