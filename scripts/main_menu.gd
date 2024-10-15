extends Control

func _on_play_pressed() -> void:
	print('Play Game!')
	pass # Replace with function body.


func _on_options_pressed() -> void:
	print('View Options Menu')
	get_tree().change_scene_to_file("res://scenes/menus/options.tscn")
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	print('Goodbye')
	get_tree().quit()
