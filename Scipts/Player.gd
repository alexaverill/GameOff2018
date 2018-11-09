extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200

var velocity = Vector2()
var jumping = false
var area
var otherNode 
func _ready():
	area = get_node("Area2D")
	area.connect("area_entered",self,"handleAreaEntered")

func handleAreaEntered(other):
	otherNode = get_node(get_path_to(other))
	if otherNode.is_in_group("enemies"):
		print("enemies")
	if otherNode.is_in_group("ui"):
		print("ui")
	print("entered area")
func get_input():
    velocity.x = 0
    var right = Input.is_action_pressed('ui_right')
    var left = Input.is_action_pressed('ui_left')
    var jump = Input.is_action_just_pressed('ui_select')

    if jump and is_on_floor():
        jumping = true
        velocity.y = jump_speed
    if right:
        velocity.x += run_speed
    if left and position.x > -300:
        velocity.x -= run_speed

func _physics_process(delta):
    get_input()
    velocity.y += gravity * delta
    if jumping and is_on_floor():
        jumping = false
    velocity = move_and_slide(velocity, Vector2(0, -1))