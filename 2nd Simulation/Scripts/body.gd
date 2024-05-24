extends Area2D

@export var vSpeed = 0
@export var hSpeed = 0
@export var mass = 1000
@export var staticPosition = false

@export var randomizeColor = false
@export var trailColor: Color
@export var trailLength = 8000

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

var instances = []

var root
var node

var trail

# Called when the node enters the scene tree for the first time.
func _ready():
	var objects = self.get_children()
	for object in objects:
		if object is Line2D:
			trail = object
			break
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
		
		print("Rand Stats: \n VSpeed: ", vSpeed, " HSpeed: ", hSpeed, " Mass: ", mass)
	
	root = get_tree().root
	for child in root.get_children():
		for grandchild in child.get_children():
			if grandchild is Area2D and grandchild != self:
				instances.append(grandchild)
				


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !staticPosition:
		for instance in instances:
			CalcAcc(instance)
	else:
		pass
		
	position = Vector2(position.x + hSpeed * delta, position.y + vSpeed * delta)
	
func CalcAcc(node):
	var distanceVector = node.global_position - global_position
	distance = distanceVector.length()
	
	var direction = distanceVector.normalized()
	
	gravForce = G * (mass * node.mass / distance**2)
	
	force = direction * gravForce
	
	hAcc = force.x / mass * 10e10
	vAcc = force.y / mass * 10e10

	hSpeed += hAcc
	vSpeed += vAcc
	
