extends Node

# Singleton Pattern - to access via GameManager.instance
var instance = null

## game state
enum GameState {MENU, SETTINGS, PLAYING, PAUSED, GAME_OVER, QUIT}
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
		pause_game()
	elif Input.is_action_just_pressed("pause") and current_state == GameState.PAUSED:
		resume_game() 
	
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

func change_settings():
	print('GameManager - View Setings')
	change_game_state(GameState.SETTINGS)
	get_tree().change_scene_to_file("res://scenes/menus/settings.tscn")

func back_to_menu():
	print('GameManager - Back to Main Menu')
	change_game_state(GameState.MENU)
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn") 

func game_over():
	print('GameManager - Game Over')
	change_game_state(GameState.GAME_OVER)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://scenes/menus/death_screen.tscn")
	# save game data

func quit_game():
	print('GameManager - Closing Window')
	get_tree().quit()
