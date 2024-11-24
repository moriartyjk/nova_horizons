extends Node

var alarm_dict = {}
enum AlarmStatus {SILENT, SOUNDING, OFF}
var sounding_count: int = 0

signal alarm_status_updated(alarm_name, alarm_status)

func _ready() -> void:
	alarm_dict = {
		"Alarm 1": AlarmStatus.SILENT,
		"Alarm 2": AlarmStatus.SILENT,
		"Alarm 3": AlarmStatus.SILENT,
		"Alarm 4": AlarmStatus.SILENT,
	}
	sounding_count = get_sounding_count()

func get_sounding_count() -> int:
	
	var count: int = 0
	
	for key in alarm_dict.keys():
		if(alarm_dict[key] == AlarmStatus.SOUNDING):
			count += 1
	
	print('Num Sounding Alarms: ', count)
	return count
	
func sound_alarm(alarm_name: String):
	alarm_dict[alarm_name] = AlarmStatus.SOUNDING
	emit_signal("alarm_status_updated", alarm_name, AlarmStatus.SOUNDING)
	print("AHSManager - ", alarm_name, " is Sounding")
	
func silence_alarm(alarm_name: String):
	alarm_dict[alarm_name] = AlarmStatus.SILENT
	emit_signal("alarm_status_updated", alarm_name, AlarmStatus.SILENT)
	print("AHSManager - ", alarm_name, " is Silent")

func update_alarm_status(alarm_name: String, new_status: int):
	alarm_dict[alarm_name] = new_status
	emit_signal("alarm_status_updated", alarm_name, new_status)
	match alarm_dict[alarm_name]:
		AlarmStatus.SILENT:
			print("AHSManager - ", alarm_name, " is Silent")
		AlarmStatus.SOUNDING:
			print("AHSManager - ", alarm_name, " is Sounding")

func get_current_status(alarm_name: String) -> int:
	return alarm_dict[alarm_name]
