extends Node
var CSVReader = load("res://Scipts/CSVReader.gd")
var csv = CSVReader.new("res://noteFiles/test.csv")
var verticalNote = preload("res://Scenes/SwordNote.tscn")
var horizontalNote = preload("res://Scenes/HorizontalNote.tscn")
var timer
var verticalSwordRecieverPos
var horizontalSwordRecieverPos
var noteNode = []
var noteList = []
var noteTimingList = []
var inputList
var yDist = 500

func _ready():
	horizontalSwordRecieverPos= get_node("HorizontalReciever").position
	verticalSwordRecieverPos = get_node("VerticalReciever").position
	timer = get_node("Timer")
	inputList = csv.getNoteArray()
	for x in inputList:
		print(x)
		# load in time first its easier
		noteTimingList.push_back(x[1])
		var dir = x[0]
		if dir == "up":
			var tmpNode = verticalNote.instance();
			tmpNode.position.x = verticalSwordRecieverPos.x + 2.8
			tmpNode.position.y = verticalSwordRecieverPos.y + yDist
			noteList.push_back(tmpNode)
		elif dir == "right":
			var tmpNode = horizontalNote.instance();
			tmpNode.position.x = horizontalSwordRecieverPos.x 
			tmpNode.position.y = horizontalSwordRecieverPos.y + yDist
			noteList.push_back(tmpNode)
	noteTimingList.pop_front()

func instantiateNote():
	var tmpNote = noteList.pop_front()
	if tmpNote != null:
		add_child(tmpNote)
		tmpNote.connect("tmpNote",self,"handleNoteSignal")	
	#instantiateVerticalSword()
	#instantiateHorizontalSword()
	pass
func handleNoteSignal(id,score):
	print(score)
	pass
func _on_Timer_timeout():
	timer.stop();
	print(timer.wait_time);
	if noteTimingList.size()>0:
		timer.wait_time = noteTimingList.pop_front()
		timer.start()
	else:
		timer.stop()
	instantiateNote()