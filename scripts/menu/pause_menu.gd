extends Control

func _on_resume_pressed() -> void:
	GameManager.resume_game()
	
func _on_quit_pressed() -> void:
	GameManager.quit_game()

func _on_settings_pressed() -> void:
	GameManager.change_settings()
