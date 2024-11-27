extends Node

# Singleton Pattern - to access via GameManager.instance
var instance = null

## game state
enum GameState {MENU, SETTINGS, STATS, PLAYING, PAUSED, GAME_OVER, QUIT}
var current_state: int = GameState.MENU
var timer_running: bool = false

## Game Settings
var music_volume: float = 1.0
var sfx_volume: float = 1.0
var is_fullscreen: bool = false
var loss_count: int = 0
var win_count: int = 0


## Signals
signal game_state_changed
signal timer_started ## use later in ahs to start alarm timers

func _ready():
	instance = self
	load_game_data()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and current_state == GameState.PLAYING:
		pause_game()
	elif Input.is_action_just_pressed("pause") and current_state == GameState.PAUSED:
		resume_game() 
		
func save_game_data():
	var save_data = {
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"loss_count": loss_count,
		"win_count": win_count
	}
	
	var save_file = FileAccess.open("user://nova_game_data.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save_data)
	save_file.store_line(json_string)

func load_game_data():
	if not FileAccess.file_exists("user://nova_game_data.save"):
		return
	
	var save_file = FileAccess.open("user://nova_game_data.save", FileAccess.READ)
	var json_string = save_file.get_line()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result == OK:
		var save_data = json.get_data()
		music_volume = save_data.get("music_volume", 1.0)
		sfx_volume = save_data.get("sfx_volume", 1.0)
		loss_count = save_data.get("loss_count", 0)

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

func show_stats():
	print('GameManager - Show Stats Page')
	change_game_state(GameState.STATS)
	get_tree().change_scene_to_file("res://scenes/menus/stats_page.tscn")

func back_to_menu():
	print('GameManager - Back to Main Menu')
	change_game_state(GameState.MENU)
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn") 

func game_over():
	print('GameManager - Game Over')
	change_game_state(GameState.GAME_OVER)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	loss_count += 1
	get_tree().change_scene_to_file("res://scenes/menus/death_screen.tscn")
	# save game data
	
func reset_save_data():
	print("GameManager - Set Save Data to Default")
	music_volume = 1.0
	sfx_volume = 1.0
	is_fullscreen = false
	loss_count = 0
	win_count = 0
	save_game_data()

func quit_game():
	print('GameManager - Closing Window')
	save_game_data()
	get_tree().quit()

func start_timer():
	print("GameManager - Start timer")
	emit_signal("timer_started")
