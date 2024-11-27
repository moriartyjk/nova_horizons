extends Interactable

@export var alarm_name: String
@onready var alarm_siren: AudioStreamPlayer3D = $AlarmSiren
@onready var alarm_timer: Timer = $AlarmTimer

var rng = RandomNumberGenerator.new()
var is_timer_started : bool = false

func _ready() -> void:
	prompt_message = "Sound Alarm"
	alarm_timer.stop() # ensure the timer isn't going
	AhsManager.connect("alarm_status_updated", _on_alarm_status_updated)
	GameManager.connect("timer_started", _on_game_timer_started)

func _process(delta: float) -> void:
	
	if alarm_timer.is_stopped() and is_timer_started == true:
		var rand_index = rng.randi_range(0,3) # 4 indices
		
		var countdown = AhsManager.sounding_times[rand_index]
		print(alarm_name, " will go off in ", countdown, " seconds")
		alarm_timer.wait_time = countdown
		alarm_timer.start()

func _on_alarm_timer_timeout() -> void:
	print("countdown has stopped, alarm will start")
	# sound the alarm
	AhsManager.sound_alarm(alarm_name)

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

func _on_game_timer_started():
	is_timer_started = true
