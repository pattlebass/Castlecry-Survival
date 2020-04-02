extends KinematicBody2D

var max_health = 100
var health = 100

#Movement
var velocity = Vector2()
var speed = 500
var acceleration = 0.2

var desired_velocity
var move_direction

func _ready():
	#global.player = self
	pass

func _physics_process(delta):
	movement()
	
func movement():
	move_direction = Vector2.ZERO
	move_direction.x = -int(Input.is_action_pressed("left")) + int(Input.is_action_pressed("right"))
	move_direction.y = -int(Input.is_action_pressed("up")) + int(Input.is_action_pressed("down"))
	
	desired_velocity = move_direction.normalized()
	
	velocity = velocity.linear_interpolate(desired_velocity, acceleration)
	
	move_and_slide(velocity * speed)
