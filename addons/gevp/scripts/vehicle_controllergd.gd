extends Node3D
@export var vehicle_node : Vehicle
@export var cam: Camera3D

@export var sens := 1.0

func _ready():
	cam.current = true

func _physics_process(_delta):
	var input_handler = get_node("/root/InputHandler")
	
	# Handle reverse state
	vehicle_node.set_reverse(input_handler.reverse)
	
	# Handle other inputs
	vehicle_node.brake_input = input_handler.brake
	# Invert steering when not in reverse
	vehicle_node.steering_input = input_handler.steering * sens * (-1 if !input_handler.reverse else 1)
	vehicle_node.throttle_input = pow(input_handler.accelerate, 2.0)
	vehicle_node.handbrake_input = 0.0
