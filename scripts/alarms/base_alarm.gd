extends Interactable

@export var alarm_name: String

func _on_interacted(body: Variant) -> void:
	#pass # Replace with function body.
	AhsManager.update_alarm_status(alarm_name, AhsManager.AlarmStatus.SOUNDING)
