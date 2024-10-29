extends Control

@onready var option_button: OptionButton = $HBoxContainer/OptionButton

const RESOLUTION_DICT: Dictionary = {
	"1920 x 1080": Vector2i(1920, 1080),
	"1280 x 720": Vector2i(1280, 720),
	"1152 x 648": Vector2i(1152, 648),
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_resolution_items()
	#pass # Replace with function body.

func add_resolution_items() -> void:
	for resolution_text in RESOLUTION_DICT:
		option_button.add_item(resolution_text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_option_button_item_selected(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICT.values()[index])
