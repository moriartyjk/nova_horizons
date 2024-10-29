extends Control

@onready var option_button: OptionButton = $HBoxContainer/OptionButton


const WINDOW_MODE_ARR : Array[String] = [
	"Fullscreen",
	"Windowed",
	"Borderless Windowed",
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_window_mode_items()
	#_on_option_button_item_selected()
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_window_mode_items() -> void:
	for mode in WINDOW_MODE_ARR:
		option_button.add_item(mode)

func _on_option_button_item_selected(index: int) -> void:
	match index:
		0: #fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		1: #windowed mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #borderless windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	#pass # Replace with function body.
