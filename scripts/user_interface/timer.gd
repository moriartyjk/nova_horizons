extends Control

@onready var timer_label: Label = $CountdownText
@onready var countdown: Timer = $CountdownText/Countdown

var isRunning: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_start_timer() # test ready function
	timer_label.hide()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if isRunning:	
		timer_label.text = _format_seconds(countdown.time_left, false)

# Starts timer
func _start_timer() -> void:
	timer_label.show()
	countdown.start()
	isRunning = !isRunning

# Formats UI
func _format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)

	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]

	var milliseconds := fmod(time, 1) * 100

	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]


func _on_countdown_timeout() -> void:
	get_tree().reload_current_scene()


func _on_start_button_interacted(body: Variant) -> void:
	_start_timer()
	#pass # Replace with function body.
