extends Node2D

var interactive = false
export (String, FILE) var scene
func _ready():
	get_node("Area2D").connect("area_entered",self,"handleAreaEntered")
	get_node("Area2D").connect("area_exited",self,"handleAreaExited")
	pass
func handleAreaEntered(other):
	interactive = true
	
func handleAreaExited(other):
	interactive = false
	

func _process(delta):
	if interactive and Input.is_key_pressed(KEY_E):
		get_tree().change_scene(scene)
	pass