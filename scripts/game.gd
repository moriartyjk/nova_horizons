extends Node3D

@onready var pause_menu: Control = $UI/PauseMenu
@onready var ambient_bg: AudioStreamPlayer = $AmbientBG

var paused = false
var playback_pos = 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.connect("game_state_changed", _on_game_state_changed)

func _on_game_state_changed(new_state):
	match new_state:
		GameManager.GameState.PAUSED:
			pause_menu.show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		GameManager.GameState.PLAYING:
			pause_menu.hide()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	pass
	
	#if Input.is_action_just_pressed("pause"):
		#playback_pos = ambient_bg.get_playback_position()
		#pauseMenu()
	
		
func pauseMenu():
	if paused:
		ambient_bg.stream_paused = false
		Engine.time_scale = 1
		pause_menu.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED #ensure mouse is recaptured
	else:
		ambient_bg.stream_paused = true
		Engine.time_scale = 0
		pause_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	paused = !paused


func _on_timer_start_interacted(body: Variant) -> void:
	pass # Replace with function body.
