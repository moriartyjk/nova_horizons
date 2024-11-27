extends Control

@onready var attempts_value: Label = $TextureRect/MarginContainer/HBoxButtons/VBoxContainer/HBoxContainer/AttemptsValue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var win_count = GameManager.win_count
	var loss_count = GameManager.loss_count
	var play_count = win_count + loss_count
	
	attempts_value.text = str(play_count)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_to_main_pressed() -> void:
	GameManager.back_to_menu()
