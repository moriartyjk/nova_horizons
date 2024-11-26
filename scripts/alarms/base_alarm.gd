extends Interactable

@export var alarm_name: String
@onready var alarm_siren: AudioStreamPlayer3D = $AlarmSiren

func _ready() -> void:
	prompt_message = "Sound Alarm"
	AhsManager.connect("alarm_status_updated", _on_alarm_status_updated)
	
func _on_alarm_status_updated(updated_name: String, updated_status: int):
	
	if updated_name == alarm_name:
	
		if(updated_status == 1):
			prompt_message = "Silence Alarm"
			alarm_siren.play()
		else:
			prompt_message = "Sound Alarm"
			alarm_siren.stop()

func _on_interacted(body: Variant) -> void:
	var alarm_status = AhsManager.get_current_status(alarm_name)
	match alarm_status:
		AhsManager.AlarmStatus.SILENT:
			AhsManager.sound_alarm(alarm_name)
		AhsManager.AlarmStatus.SOUNDING:
			AhsManager.silence_alarm(alarm_name)
