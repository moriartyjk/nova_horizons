extends Control

@onready var game: Node3D = $"../.."


func _on_resume_pressed() -> void:
	game.pauseMenu()
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
