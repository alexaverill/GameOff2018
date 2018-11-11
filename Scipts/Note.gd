extends Node2D

var isInArea = false
var isActive = false setget setActive, getActive
func setActive():
	isActive = true
	print(str(noteId) + str(isActive))
func setInactive():
	isActive = false;
func getActive():
	return isActive

var noteId = 1 setget setId
func setId(newId):
	print(newId)
	noteId = newId

var localRotation = 0 setget setRotation
var inputType ="ui_up"
var otherNode

signal noteIn(id,score)
signal noteOut(id)
signal destroyed()



func setRotation(angle):
	localRotation = (angle * PI )/180
	rotate(localRotation)

var score = 0
var area_to_score  = {"good": 1, "great": 2, "perfect":5}
func _ready():
	var rotation = get_node("KinematicBody2D/Sprite").get_rotation()
	if rotation !=0:
		inputType = "ui_right"
	get_node("KinematicBody2D/Area2D").connect("area_entered",self,"handleCollisionEnter")
	get_node("KinematicBody2D/Area2D").connect("area_exited",self,"handleCollisionExit")
	#set speed values
	get_node("KinematicBody2D").setSpeed(100)

func handleCollisionEnter(otherArea):
	otherNode = get_node(get_path_to(otherArea))
	if otherNode.is_in_group("wall"):
		emit_signal("destroyed",noteId)
		queue_free()
	elif otherNode.is_in_group("good"):
		isInArea = true
		score = area_to_score["good"]
		#print("good")
	elif otherNode.is_in_group("great"):
		isInArea = true;
		score = area_to_score["great"]
		#print("great")
	elif otherNode.is_in_group("perfect"):
		isInArea = true;
		score = area_to_score["perfect"]
		#print("perfect")
	
	
func handleCollisionExit(otherArea):
	otherNode = get_node(get_path_to(otherArea))
	if otherNode.is_in_group("perfect"):
		isInArea = false
		
func _process(delta):
	
	if Input.is_action_pressed(inputType) and isActive:
		if isInArea:
			print("in and signalling")
			emit_signal("noteIn",noteId,score)
		else:
			print("Pressed and out" + inputType)
			emit_signal("noteOut", noteId)
		isActive = false

