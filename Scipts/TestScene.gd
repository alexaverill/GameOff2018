extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var note = preload("res://Note.tscn")
var noteNode
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	instantiateNote();
	pass
func instantiateNote():
	noteNode = note.instance()
	add_child(noteNode)
	noteNode.connect("noteIn",self,"handleNoteSignal")
	pass
func handleNoteSignal(id,score):
	print("SIGNAL RECIEVED")
	print(id)
func _on_Timer_timeout():
	instantiateNote()