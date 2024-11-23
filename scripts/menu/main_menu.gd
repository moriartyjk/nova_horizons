extends Control

func _on_play_pressed() -> void:
	GameManager.start_game()

func _on_settings_pressed() -> void:
	GameManager.change_settings()

func _on_controls_pressed() -> void:
	print('View Controls Page')
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	print('Goodbye')
	get_tree().quit()
