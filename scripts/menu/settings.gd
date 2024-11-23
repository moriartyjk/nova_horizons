extends Control

var backToMain: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("game_state_changed", _on_game_state_changed)

func _on_game_state_changed(new_state):
	match new_state:
		GameManager.GameState.PAUSED:
			backToMain = false
		GameManager.GameState.MENU:
			backToMain = true

func _on_back_pressed() -> void:
	if(backToMain):
		print('Back to main Menu!')
		get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn") 
	else:
		print('Back to Pause menu')
		get_tree().change_scene_to_file("res://scenes/menus/pause_menu.tscn")
