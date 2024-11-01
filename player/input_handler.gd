extends Node
var steer_left = 0.0
var steer_right = 0.0
var accelerate = 0.0
var brake = 0.0
var steering = 0.0
var throttle = 0.0
var reverse = false

func _ready():
	set_process(true)

func _process(_delta):
	steer_left = Input.get_action_strength("Steer Left")
	steer_right = Input.get_action_strength("Steer Right")
	accelerate = Input.get_action_strength("Accelerate")
	brake = Input.get_action_strength("Brake")
	
	# Check for reverse toggle
	if Input.is_action_pressed("Reverse"):
		reverse = true
	else:
		reverse = false
		
	handle_input(steer_left, steer_right, accelerate, brake)

func handle_input(left, right, accel, brk):
	steering = right - left
	throttle = accel - brk

	print("Steering: %s, Throttle: %s, Reverse: %s" % [steering, throttle, reverse])