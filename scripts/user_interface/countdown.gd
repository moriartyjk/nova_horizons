extends Label

@onready var countdown: Timer = $Countdown

var isRunning: bool = false


func _process(_delta : float) -> void:
	#
	if countdown.is_stopped():
		_start_timer()
		
	if isRunning:
		text = _format_seconds(countdown.time_left, false)
	

func _start_timer() -> void:
	countdown.start()
	isRunning = !isRunning

func _format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)

	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]

	var milliseconds := fmod(time, 1) * 100

	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]


func _on_countdown_timeout() -> void:
	get_tree().reload_current_scene()
	#pass # Replace with function body.
