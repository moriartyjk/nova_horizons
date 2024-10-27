extends CharacterBody3D

@export var thrust_power: float = 20.0
@export var torque_power: float = 2.0
@export var dampening: float = 0.95  # Reduces drift
@export var rotation_dampening: float = 0.92

# Camera sensitivity
@export var mouse_sensitivity: float = 0.002

# Reference to the camera
@onready var camera: Camera3D = $Neck/Camera3D
@onready var neck: Node3D = $Neck


func _input(event: InputEvent) -> void:
	# Handle mouse movement for rotation
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#neck.rotate_y(-event.relative.x * mouse_sensitivity)
		rotate_object_local(Vector3.UP, -event.relative.x * mouse_sensitivity)
		#camera.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_object_local(Vector3.RIGHT, -event.relative.y * mouse_sensitivity)
	
	## Toggle mouse capture
	#if event.is_action_pressed("ui_cancel"):
		#if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#else:
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Apply movement forces
	var thrust_dir = Vector3.ZERO
	
	# Forward/Backward thrust
	if Input.is_action_pressed("move_forward"):
		thrust_dir.z -= 1
	if Input.is_action_pressed("move_backward"):
		thrust_dir.z += 1
	
	# Left/Right thrust
	if Input.is_action_pressed("move_left"):
		thrust_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		thrust_dir.x += 1
	
	## Up/Down thrust
	#if Input.is_action_pressed("move_up"):
		#thrust_dir.y += 1
	#if Input.is_action_pressed("move_down"):
		#thrust_dir.y -= 1
	
	# Apply rotation forces
	var torque_dir = Vector3.ZERO
	
	## Roll control
	#if Input.is_action_pressed("roll_left"):
		#torque_dir.z += 1
	#if Input.is_action_pressed("roll_right"):
		#torque_dir.z -= 1
	#
	# Convert local thrust direction to global coordinates
	var global_thrust = thrust_dir.normalized() * thrust_power
	global_thrust = global_thrust.rotated(Vector3.RIGHT, rotation.x)
	global_thrust = global_thrust.rotated(Vector3.UP, rotation.y)
	global_thrust = global_thrust.rotated(Vector3.FORWARD, rotation.z)
	
	# Apply forces
	velocity += global_thrust * delta
	
	# Apply torque
	#rotate_object_local(Vector3.FORWARD, torque_dir.z * torque_power * delta)
	rotate_object_local(Vector3.FORWARD, torque_dir.z * delta)
	
	# Apply dampening
	velocity *= dampening
	
	# Move the character
	move_and_slide()
