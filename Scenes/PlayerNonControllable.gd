extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200

var velocity = Vector2()
var jumping = false
var area
var animated
var otherNode
var direction = "idle"
var movePos = 0
var moveTimer
var movement = [["idle",8],
				["left",4],
				["idle",6],
				["right",6],
				["idle",7],
				["left",2],
				["idle",5]]
func _ready():
	area = get_node("Area2D")
	animated = get_node("MovementAnimation")
	animated.set_animation("idle")
	animated.playing = true
	area.connect("area_entered",self,"handleAreaEntered")
	moveTimer = get_node("Timer")
	moveTimer.connect("timeout",self,"handleTimeout")
	direction = movement[movePos][0]
	moveTimer.wait_time = movement[movePos][1]
	moveTimer.start()
	
	
func handleTimeout():
	moveTimer.stop()
	movePos = movePos + 1 if movePos < movement.size()-1 else 0
	direction = movement[movePos][0]
	moveTimer.wait_time = movement[movePos][1]
	moveTimer.start()

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
	if jump:
		print("jump pressed")
	if jump and is_on_floor():
		print("char jumps")
		jumping = true
		animated.set_animation("jumping")
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
		animated.flip_h = false
		animated.set_animation("running")
	elif left and position.x > -300:
		velocity.x -= run_speed
		animated.flip_h = true
		animated.set_animation("running")
	else:
		animated.set_animation("idle")

func _physics_process(delta):
	if direction == "right":
		velocity.x = run_speed
		animated.flip_h = false
		animated.set_animation("running")
	elif direction == "left":
		velocity.x = -run_speed
		animated.flip_h = true
		animated.set_animation("running")
	else:
		velocity.x = 0 
		animated.set_animation("idle")
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))