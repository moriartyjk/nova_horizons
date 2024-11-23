extends Control

func _on_play_pressed() -> void:
	GameManager.start_game()
	#print('Play Game!')


func _on_settings_pressed() -> void:
	print('View Settings Menu')
	get_tree().change_scene_to_file("res://scenes/menus/settings.tscn")

func _on_controls_pressed() -> void:
	print('View Controls Page')
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	print('Goodbye')
	get_tree().quit()
