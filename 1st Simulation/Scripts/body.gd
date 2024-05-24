extends Area2D

@export var vSpeed = 10
@export var hSpeed = 10

@export var earthMass = 10e15

var vAcc
var hAcc

const G = 6.67430e-11
var distance
var angle
var gravForce
var forceX
var forceY

var collided = false

# Called when the node enters the scene tree for the first time.
func _ready():
	distance = sqrt(position.x**2 + position.y**2)
	angle = atan2(position.x, position.y)
	gravForce = G * (earthMass / distance**2)
	
	forceX = -1 * gravForce * sin(angle)
	forceY = -1 * gravForce * cos(angle)
	
	
	print("X: ", position.x, " Y: ", position.y)
	print("vSpeed: ", vSpeed, " hSpeed: ", hSpeed)
	print("G: ", G)
	print("Distance: ", distance)
	print("Angle: ", angle)
	print("Force: ", gravForce)
	print("ForceX: ", forceX, " ForceY: ", forceY)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !collided:
		distance = sqrt(position.x**2 + position.y**2)
		angle = rad_to_deg(atan2(position.x, position.y))
		gravForce = G * (earthMass / distance**2)
		
		forceX = gravForce * sin(atan2(position.x, position.y))
		forceY = gravForce * cos(atan2(position.x, position.y))
		
		hAcc = -1 * forceX
		vAcc = -1 * forceY
		
		hSpeed += hAcc
		vSpeed += vAcc
		
		position = Vector2(position.x + hSpeed * delta, position.y + vSpeed * delta)
		
		print("X: ", position.x, " Y: ", position.y)
		print("vSpeed: ", vSpeed, " hSpeed: ", hSpeed)
		print("G: ", G)
		print("Distance: ", distance)
		print("Angle: ", angle)
		print("Force: ", gravForce)
		print("ForceX: ", forceX, " ForceY: ", forceY)

func _on_area_entered(area):
	print("Collided")
	collided = true
