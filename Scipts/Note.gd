extends Node2D

var isInArea = false
var recieverId = 1 setget setId
var localRotation = 0 setget setRotation
var otherNode
signal noteIn(id,score)
func setId(newId):
	recieverId = newId

func setRotation(angle):
	localRotation = (angle * PI )/180
	rotate(localRotation)
var score = 0
var area_to_score  = {"good": 1, "great": 2, "perfect":5}
func _ready():
	get_node("KinematicBody2D/Area2D").connect("area_entered",self,"handleCollisionEnter")
	get_node("KinematicBody2D/Area2D").connect("area_exited",self,"handleCollisionExit")
	#set speed values here to pass to kinematic2d
	get_node("KinematicBody2D").setSpeed(100)

func handleCollisionEnter(otherArea):
	otherNode = get_node(get_path_to(otherArea))
	if otherNode.is_in_group("wall"):
		queue_free()
	elif otherNode.is_in_group("good"):
		isInArea = true
		score = area_to_score["good"]
		print("good")
	elif otherNode.is_in_group("great"):
		isInArea = true;
		score = area_to_score["great"]
		print("great")
	elif otherNode.is_in_group("perfect"):
		isInArea = true;
		score = area_to_score["perfect"]
		print("perfect")
	
	
func handleCollisionExit(otherArea):
	otherNode = get_node(get_path_to(otherArea))
	if otherNode.is_in_group("perfect"):
		isInArea = false
		
func _process(delta):
	if Input.is_action_pressed("ui_right") and isInArea:
		emit_signal("noteIn",recieverId,score)

