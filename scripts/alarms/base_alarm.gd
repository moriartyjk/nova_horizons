extends Interactable

@export var alarm_name: String

func _ready() -> void:
	prompt_message = "Sound Alarm"
	AhsManager.connect("alarm_status_updated", _on_alarm_status_updated)
	
func _on_alarm_status_updated(alarm_name: String, alarm_status: int):
	
	if(alarm_status == 1):
		prompt_message = "Silence Alarm"
	else:
		prompt_message = "Sound Alarm"
	pass

func _on_interacted(body: Variant) -> void:
	#pass # Replace with function body.
	var alarm_status = AhsManager.get_current_status(alarm_name)
	match alarm_status:
		AhsManager.AlarmStatus.SILENT:
			AhsManager.update_alarm_status(alarm_name, AhsManager.AlarmStatus.SOUNDING)
		AhsManager.AlarmStatus.SOUNDING:
			AhsManager.update_alarm_status(alarm_name, AhsManager.AlarmStatus.SILENT)
			
	
	
