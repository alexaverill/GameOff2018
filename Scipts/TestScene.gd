extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var note = preload("res://Scenes/SwordNote.tscn")
var timer
var verticalSwordRecieverPos
var horizontalSwordRecieverPos
var noteNode = []
var noteList = []
var noteTimingList = []

var yDist = 500

func _ready():
	#horizontalSwordRecieverPos= get_node("HorizontalSword").position
	verticalSwordRecieverPos = get_node("VerticalReciever").position
	timer = get_node("Timer");
	for x in range(0,5):
		var tmpNode = note.instance();
		tmpNode.position.x = verticalSwordRecieverPos.x + 2.8
		tmpNode.position.y = verticalSwordRecieverPos.y + yDist
		noteList.push_back(tmpNode)
		noteTimingList.push_back(randi()%6+1);
	

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
	var tmpNote = noteList.pop_front()
	add_child(tmpNote)
	tmpNote.connect("noteIn",self,"handleNoteSignal")	
	#instantiateVerticalSword()
	#instantiateHorizontalSword()
	pass
func handleNoteSignal(id,score):
	print(score)
	pass
func _on_Timer_timeout():
	if noteTimingList.count()>0:
		timer.wait_time = noteTimingList.pop_front()
	else:
		timer.stop()
	instantiateNote()