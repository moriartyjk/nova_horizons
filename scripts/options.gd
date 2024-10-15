extends Control

func _on_back_pressed() -> void:
	print('Back to main Menu!')
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
