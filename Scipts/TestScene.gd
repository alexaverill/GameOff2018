extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var note = preload("res://Scenes/SwordNote.tscn")
var verticalSwordRecieverPos
var horizontalSwordRecieverPos
var noteNode
var yDist = 500
func _ready():
	#horizontalSwordRecieverPos= get_node("HorizontalSword").position
	verticalSwordRecieverPos = get_node("VerticalReciever").position

func instantiateVerticalSword():
	noteNode = note.instance()
	noteNode.position.x = verticalSwordRecieverPos.x + 2.8
	noteNode.position.y = verticalSwordRecieverPos.y + yDist
	add_child(noteNode)
	noteNode.connect("noteIn",self,"handleNoteSignal")
	pass
func instantiateHorizontalSword():
	noteNode = note.instance()
	noteNode.setRotation(90)
	noteNode.position.x = horizontalSwordRecieverPos.x
	noteNode.position.y = horizontalSwordRecieverPos.y + yDist 
	add_child(noteNode)
	noteNode.connect("noteIn",self,"handleNoteSignal")
	pass

func instantiateNote():
	instantiateVerticalSword()
	#instantiateHorizontalSword()
	pass
func handleNoteSignal(id,score):
	print(score)
	pass
func _on_Timer_timeout():
	instantiateNote()