extends CollisionObject3D
class_name Interactable 

signal interacted(body)
signal enabled(body)
signal disabled(body)

@export_group("Interact Prompt")
@export var prompt_message = "Interact"
@export var prompt_input = "interact"

var is_enabled:bool = true ## everything starts as enabled

func get_prompt():
	var key_name = ""
	
	for action in InputMap.action_get_events(prompt_input):
		if action is InputEventKey:
			key_name = action.as_text_physical_keycode()
			break
			
	return prompt_message + "\n[" + key_name + "]"

func interact(body):
	print("An object has been interacted with")
	interacted.emit(body)

func enable(body):
	print("Objects interactable abilities have been enabled")
	is_enabled = true
	enabled.emit(body)

func disable(body):
	print("Objects interactable abilities have been disabled")
	is_enabled = false
	disabled.emit(body)
