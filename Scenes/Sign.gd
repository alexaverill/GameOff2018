extends Node2D

var interactive = false
var animatedSprite
var popUp
var popUpActive = false
var popUpButton
func _ready():
	popUp = get_node("Popup")
	popUpButton = get_node("Popup/Button")
	popUpButton.connect("button_down",self, "buttonPressed")
	get_node("Area2D").connect("area_entered",self,"handleAreaEntered")
	get_node("Area2D").connect("area_exited",self,"handleAreaExited")
	animatedSprite = get_node("AnimatedSprite")
	animatedSprite.visible = false
	pass
func handleAreaEntered(other):
	print("In Area")
	#set input prompt to visable
	animatedSprite.visible = true
	interactive = true
	
func handleAreaExited(other):
	interactive = false
	animatedSprite.visible = false
	
func buttonPressed():
	popUp.hide()
	popUpActive = false

func _process(delta):
	if interactive and Input.is_key_pressed(KEY_E) and !popUpActive:
		popUpActive = true
		var popUpPos = Rect2(position.x - popUp.get_rect().size.x/2, position.y - popUp.get_rect().size.y * 1.2, popUp.get_rect().size.x,popUp.get_rect().size.y)
		popUp.popup(popUpPos)
		
	elif !interactive and popUpActive:
		popUp.hide()
		popUpActive = false
	pass
