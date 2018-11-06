extends KinematicBody2D

export (int) var speed = 10 setget setSpeed, getSpeed
var velocity = Vector2()

func setSpeed(val):
	speed = val
	
func getSpeed():
	return speed

func setVelocity():
	velocity = Vector2()
	velocity.y -= 1
	velocity = velocity.normalized() * speed
	
func _process(delta):
	setVelocity()
	move_and_slide(velocity)

