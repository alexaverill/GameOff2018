extends Node2D

var isInArea = false
var recieverId = 1 setget setId
var localRotation = 0 setget setRotation

signal noteIn(id,score)
func setId(newId):
	recieverId = newId

func setRotation(angle):
	localRotation = (angle * PI )/180
	rotate(localRotation)


func _ready():
	get_node("KinematicBody2D/Area2D").connect("area_entered",self,"handleCollisionEnter")
	get_node("KinematicBody2D/Area2D").connect("area_exited",self,"handleCollisionExit")
	#set speed values here to pass to kinematic2d
	get_node("KinematicBody2D").setSpeed(100)

func handleCollisionEnter(otherArea):
	if get_node(get_path_to(otherArea)).is_in_group("wall"):
		queue_free()
	elif get_node(get_path_to(otherArea)).is_in_group("reciever"):
		print("Hit Reciever")
	isInArea = true
	
func handleCollisionExit(otherArea):
	isInArea = false
		
func _process(delta):
	if Input.is_action_pressed("ui_right") and isInArea:
		emit_signal("noteIn",recieverId,1)

