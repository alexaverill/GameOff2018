extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var note = preload("res://SwordNote.tscn")
var verticalSwordRecieverX
var horizontalSwordRecieverX
var noteNode
func _ready():
	horizontalSwordRecieverX = get_node("HorizontalSword").position.x
	print(horizontalSwordRecieverX)
	verticalSwordRecieverX = get_node("VerticalSword").position.x 

func instantiateVerticalSword():
	noteNode = note.instance()
	noteNode.position.x = verticalSwordRecieverX + 2.8
	add_child(noteNode)
	noteNode.connect("noteIn",self,"handleNoteSignal")
	pass
func instantiateHorizontalSword():
	noteNode = note.instance()
	noteNode.setRotation(90)
	noteNode.position.x = horizontalSwordRecieverX 
	add_child(noteNode)
	noteNode.connect("noteIn",self,"handleNoteSignal")
	pass

func instantiateNote():
	instantiateVerticalSword()
	instantiateHorizontalSword()
	pass
func handleNoteSignal(id,score):
	print(id)
func _on_Timer_timeout():
	instantiateNote()