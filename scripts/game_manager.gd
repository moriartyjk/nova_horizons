extends Node

# Singleton Pattern - to access via GameManager.instance
var instance = null

## game state
enum GameState {MENU, PLAYING, PAUSED, GAME_OVER}
var current_state: int = GameState.MENU

## Game Settings
var music_volume: float = 1.0
var sfx_volume: float = 1.0
var is_fullscreen: bool = false
var first_load: bool = true


## Signals
signal game_state_changed

func _ready():
	instance = self
	load_game_data()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and current_state == GameState.PLAYING:
		print('GameManager - Esc Pressed')
		pause_game()
	
func load_game_data():
	# save data here
	pass

func change_game_state(new_state: int):
	current_state = new_state
	emit_signal("game_state_changed", new_state)
	
func start_game():
	print('GameManager - Start Game')
	change_game_state(GameState.PLAYING)
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func pause_game():
	if current_state == GameState.PLAYING:
		print('GameManager - Game Paused')
		change_game_state(GameState.PAUSED)
		Engine.time_scale = 0
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func resume_game():
	if current_state == GameState.PAUSED:
		print('GameManager - Game Resumed')
		change_game_state(GameState.PLAYING)
		Engine.time_scale = 1
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func game_over():
	change_game_state(GameState.GAME_OVER)
	# save game data
