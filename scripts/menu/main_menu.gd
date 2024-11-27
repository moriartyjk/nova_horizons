extends Control

func _on_play_pressed() -> void:
	GameManager.start_game()

func _on_settings_pressed() -> void:
	GameManager.change_settings()

func _on_exit_pressed() -> void:
	GameManager.quit_game()

func _on_stats_pressed() -> void:
	GameManager.show_stats()
