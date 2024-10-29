extends Control

@onready var game: Node3D = $"../.."

func _on_resume_pressed() -> void:
	print('Pause Game')
	game.pauseMenu()
	
func _on_quit_pressed() -> void:
	print('Quit Game')
	get_tree().quit()


func _on_settings_pressed() -> void:
	print('View Settings Menu')
	get_tree().change_scene_to_file("res://scenes/menus/settings.tscn")
