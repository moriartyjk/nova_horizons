extends Control

#@onready var game: Node3D = $"../.."

func _on_resume_pressed() -> void:
	GameManager.resume_game()
	
func _on_quit_pressed() -> void:
	print('Quit Game')
	get_tree().quit()


func _on_settings_pressed() -> void:
	GameManager.change_settings()
