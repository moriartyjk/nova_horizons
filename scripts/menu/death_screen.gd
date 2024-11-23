extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_pressed() -> void:
	print('Retry Mission')
	GameManager.start_game()
	#get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_pressed() -> void:
	print('Quit Game')
	get_tree().quit()


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
