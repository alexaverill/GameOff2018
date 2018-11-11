extends Node2D

var interactive = false
var animatedSprite
func _ready():
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
func _process(delta):
	if interactive and Input.is_key_pressed(KEY_E):
		print("e pressed")
	pass
