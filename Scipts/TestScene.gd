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
var noteListPos = 0;
var noteTimingList = []
var inputList
var scoreVal = 0
var scoreLabel
var yDist = 500

func updateScore():
	scoreLabel.text = "Score: " + str(scoreVal)
	
func _ready():
	horizontalSwordRecieverPos = get_node("HorizontalReciever").position
	verticalSwordRecieverPos = get_node("VerticalReciever").position
	scoreLabel = get_node("ScoreLabel")
	updateScore()
	timer = get_node("Timer")
	inputList = csv.getNoteArray()
	for x in inputList:
		#print(x)
		# load in time first its easier
		noteTimingList.push_back(x[1])
		var dir = x[0]
		if dir == "up":
			var tmpNode = verticalNote.instance();
			tmpNode.setId(noteList.size())
			tmpNode.position.x = verticalSwordRecieverPos.x + 2.8
			tmpNode.position.y = verticalSwordRecieverPos.y + yDist
			noteList.push_back(tmpNode)
		elif dir == "right":
			var tmpNode = horizontalNote.instance();
			tmpNode.setId(noteList.size())
			tmpNode.position.x = horizontalSwordRecieverPos.x 
			tmpNode.position.y = horizontalSwordRecieverPos.y + yDist
			noteList.push_back(tmpNode)
	noteTimingList.pop_front()

func instantiateNote():
	var tmpNote = noteList[noteListPos]
	if noteListPos == 0:
		setNoteActive(0)
	noteListPos += 1
	if tmpNote != null:
		add_child(tmpNote)
		tmpNote.connect("noteIn",self,"handleNoteInSignal")	
		tmpNote.connect("noteOut",self,"handleNoteOutSignal")
		tmpNote.connect("destroyed", self, "handleNoteDestroyed")
	#instantiateVerticalSword()
	#instantiateHorizontalSword()
	pass
func handleNoteInSignal(id,score):
	scoreVal += score
	setNoteInactive(id)
	setNoteActive(id+1)
	updateScore()
	pass
func handleNoteOutSignal(id):
	print(id)
	pass
func handleNoteDestroyed(id):
	setNoteActive(id+1)
	pass
func setNoteActive(id):
	if id < noteList.size():
		noteList[id].setActive()
func setNoteInactive(id):
	if id < noteList.size():
		noteList[id].setInactive()
	
func _on_Timer_timeout():
	timer.stop();
	if noteTimingList.size()>0:
		timer.wait_time = noteTimingList.pop_front()
		timer.start()
	else:
		timer.stop()
	instantiateNote()