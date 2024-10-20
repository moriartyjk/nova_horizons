extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D

func _unhandled_input(event: InputEvent) -> void:
	
	# Hiding mouse on any keypress, unhiding mouse on escpae
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"): # pressing escape
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# set movement of neck and camera
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01) #neck left if mouse left
			camera.rotate_x(-event.relative.y * 0.01) # camera up if mouse up
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60)) # limit how far up and down


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
