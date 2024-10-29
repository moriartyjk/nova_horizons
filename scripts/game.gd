extends Node3D

@onready var pause_menu: Control = $UI/PauseMenu
var paused = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
		
func pauseMenu():
	if paused:
		Engine.time_scale = 1
		pause_menu.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED #ensure mouse is recaptured
	else:
		Engine.time_scale = 0
		pause_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	paused = !paused


func _on_timer_start_interacted(body: Variant) -> void:
	pass # Replace with function body.
