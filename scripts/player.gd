extends CharacterBody3D

@export var thrust_power: float = 10.0
@export var dampening: float = 0.95  # Reduces drift
@export var mouse_sensitivity: float = 0.002

# Reference to the camera
#@onready var camera: Camera3D = $Camera3D
@onready var camera_3d: Camera3D = $Neck/Camera3D

func _ready() -> void:
	# Capture mouse for first-person control
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	# Handle mouse movement for rotation
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_object_local(Vector3.UP, -event.relative.x * mouse_sensitivity)
		rotate_object_local(Vector3.RIGHT, -event.relative.y * mouse_sensitivity)
	#
	## Toggle mouse capture
	#if event.is_action_pressed("ui_cancel"):
		#if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#else:
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Get input direction
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
	
	# Normalize thrust direction and apply power
	if thrust_dir.length() > 0:
		thrust_dir = thrust_dir.normalized() * thrust_power
	
	# Transform thrust direction to local space
	var local_thrust = transform.basis * thrust_dir
	
	# Apply thrust to velocity
	velocity += local_thrust * delta
	
	# Apply dampening
	velocity *= dampening
	
	# Move the character
	move_and_slide()
