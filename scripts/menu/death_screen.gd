extends Control

func _on_retry_pressed() -> void:
	GameManager.start_game()

func _on_quit_pressed() -> void:
	GameManager.quit_game()

func _on_exit_pressed() -> void:
	GameManager.back_to_menu()
	#get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
