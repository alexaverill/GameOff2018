
var _filePath;
var noteArray = [] setget setNoteArray,getNoteArray

func _init(filePath):
	_filePath = filePath
	
func getNoteArray():
	loadFile()
	return noteArray;
func setNoteArray():
	pass
func loadFile():
	var file = File.new()
	file.open(_filePath, file.READ)
	while !file.eof_reached():
		var strIn = file.get_line()
		var strArray = strIn.split(",")
		var tmpArray = [strArray[0], int(strArray[1])]
		noteArray.push_back(tmpArray)
	file.close()


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
