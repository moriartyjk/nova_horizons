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
			ambient_bg.stream_paused = true
			pause_menu.show()
		GameManager.GameState.PLAYING:
			ambient_bg.stream_paused = false
			pause_menu.hide()
