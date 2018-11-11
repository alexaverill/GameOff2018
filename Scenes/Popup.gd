extends Popup

func _ready():
	get_node("Button").connect("button_down",self, "handleButtonPressed")
	pass

func handleButtonPressed():
	hide()
	get_parent().popUpActive = false
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
