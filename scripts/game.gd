extends Node3D

@onready var pause_menu: Control = $UI/PauseMenu
var paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED #ensure mouse is recaptured
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
