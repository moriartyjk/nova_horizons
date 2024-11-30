extends RayCast3D

@onready var prompt: Label = $Prompt

func _physics_process(delta: float) -> void:
	prompt.text = ""
	
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable: ## grab prompt from interactable
			
			if collider.is_enabled == true: ## only set prompt when true
				prompt.text = collider.get_prompt()
			
				## send signal when specified key is pressed
				if Input.is_action_just_pressed(collider.prompt_input):
					collider.interact(owner)
