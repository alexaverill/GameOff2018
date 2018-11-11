extends Node2D


func _ready():
	get_node("AboutScreen").hide()
	get_node("StartBtn").connect("button_down",self,"onBeginPressed")
	get_node("AboutBtn").connect("button_down",self,"onAboutPressed")
	get_node("AboutScreen/BackBtn").connect("button_down",self,"onAboutBackPressed")
	pass
func onAboutPressed():
	get_node("AboutScreen").show()
	pass
func onAboutBackPressed():
	get_node("AboutScreen").hide()
	pass
func onBeginPressed():
	get_tree().change_scene("res://Scenes/PlayerTest.tscn")
	pass
