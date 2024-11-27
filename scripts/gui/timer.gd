extends Control

@onready var timer_label: Label = $CountdownText
@onready var timer: Timer = $CountdownText/Countdown
@onready var ambient_bg: AudioStreamPlayer = $"../../AmbientBG"

var time_left: float = 3600.0 #seconds
#var time_left: float = 15.0
var base_speed: float = 1.0 #normal multiplier
var current_speed: float = 1.0 # current speed multiplier
var isRunning: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_start_timer() # test ready function
	timer.one_shot = false
	timer.wait_time = 0.1 # update every 0.1 seconds -> triggered by time out
	timer_label.hide()
	AhsManager.connect("alarm_status_updated", _on_alarm_status_updated)
	
func _on_countdown_timeout() -> void:
	## uncapture mouse
	if time_left > 0:
		# decrease time based on current speed
		#time_left -= timer.wait_time * current_speed
		time_left -= timer.wait_time * current_speed
		timer_label.text = _format_seconds(time_left, false)
	else:
		ambient_bg.stream_paused = true # turn off music for now
		GameManager.game_over()
		#get_tree().change_scene_to_file("res://scenes/menus/death_screen.tscn")

func _on_alarm_status_updated(alarm_name, alarm_status):
	#print("Updating speed??")
	var num_alarms = AhsManager.get_sounding_count()
	if current_speed > 0:
	# Tnew = Tremaining/1.33n   T=Time, 1.33=SpeedUp Factor, n=number of alarms
		current_speed = pow(1.33, num_alarms)
	else:
		current_speed = base_speed

# Starts timer
func _start_timer() -> void:
	timer_label.show()
	timer.start()
	isRunning = !isRunning
	GameManager.start_timer()

# Formats UI
func _format_seconds(time : float, use_milliseconds : bool) -> String:
	#var minutes := time / 60
	#var seconds := fmod(time, 60)
	var minutes := time_left / 60
	var seconds := fmod(time_left , 60)

	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]

	var milliseconds := fmod(time, 1) * 100

	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]


func _on_start_button_interacted(body: Variant) -> void:
	if !isRunning:
		_start_timer()
	#pass # Replace with function body.
