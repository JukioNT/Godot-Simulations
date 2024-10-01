extends Area2D

@export var vSpeed = 0
@export var hSpeed = 0
@export var mass = 1000
@export var gravMultiplyer = 10e10

@export var timeScale = 1
@export var subSteps = 4

@export var randomizeColor = false
@export var trailColor: Color
@export var trailLength = 1000

@export var randomizeStats = false

@export var randMaxVSpeed = 10
@export var randMinVSpeed = -10

@export var randMaxHSpeed = 10
@export var randMinHSpeed = -10

@export var randMaxMass = 2000
@export var randMinMass = 50

var vAcc
var hAcc

const G = 6.67430e-11
var distance
var distanceX
var direction
var gravForce
var force
var stepDelta

var instances = []

var camera
var cameraZoom

var root
var node

var trail
var trailWidth = 10
var paused = false

func _ready():
	camera = get_node("/root/Node2D/Camera2D")
	trail = get_node("./Trail2D")
	
	trail.length = trailLength
	
	if randomizeColor:
		var red = randf()
		var green = randf()
		var blue = randf()
		trail.default_color = Color(red, green, blue, 0.5)
	else:
		trail.default_color = trailColor
	
	if randomizeStats:
		vSpeed = randi_range(randMinVSpeed, randMaxVSpeed)
		hSpeed = randi_range(randMinHSpeed, randMaxHSpeed)
		mass = randi_range(randMinMass, randMaxMass)
	
	root = get_tree().root
	for child in root.get_children():
		for grandchild in child.get_children():
			if grandchild is Area2D and grandchild != self:
				instances.append(grandchild)

func _physics_process(delta):
	stepDelta = delta / subSteps
	
	if !paused:
		for instance in instances:
			CalcAcc(instance)
			
		position = Vector2(position.x + hSpeed * (stepDelta * timeScale), position.y + vSpeed * (stepDelta * timeScale))
	
	cameraZoom = camera.GetZoom()
	trailWidth = 5 / cameraZoom.x
	trail.width = trailWidth

func CalcAcc(node):
	var distanceVector = node.global_position - global_position
	distance = distanceVector.length()
	
	var direction = distanceVector.normalized()
	
	gravForce = G * (mass * node.mass / distance**2)
	
	force = direction * gravForce
	
	hAcc = (force.x / mass * gravMultiplyer) * timeScale
	vAcc = (force.y / mass * gravMultiplyer) * timeScale

	hSpeed += hAcc
	vSpeed += vAcc

func _on_area_entered(area):
	if mass == area.GetMass():
		queue_free()

func press(action: int):
	if action == 1:
		paused = !paused
	elif action == 2:
		timeScale = 4 if timeScale == 1 else 1

func GetXY():
	return position

func GetSpeed():
	return Vector2(vSpeed, hSpeed)

func GetGravForce():
	return gravForce

func GetForce():
	return force

func GetMass():
	return mass
