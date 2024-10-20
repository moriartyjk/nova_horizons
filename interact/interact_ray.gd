extends RayCast3D

@onready var prompt: Label = $Prompt

func _physics_process(delta: float) -> void:
	prompt.text = ""
	
	if is_colliding():
		prompt.text = "something else..."
