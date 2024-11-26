extends Node3D

@onready var pause_menu: Control = $UI/PauseMenu
@onready var ambient_bg: AudioStreamPlayer = $AmbientBG

@onready var alarm_1: StaticBody3D = %Alarm1
@onready var alarm_2: StaticBody3D = %Alarm2
@onready var alarm_3: StaticBody3D = %Alarm3
@onready var alarm_4: StaticBody3D = %Alarm4

var rng_alarm_time = Timer.new()
var rng = RandomNumberGenerator.new()

var paused = false
var playback_pos = 0.0

func _ready() -> void:
	add_child(rng_alarm_time)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.connect("game_state_changed", _on_game_state_changed)
	rng_alarm_time.timeout.connect(_on_timer_timeout)
	
func _process(delta: float) -> void:
	# randomly pick from the ahs_sounding_times

	if rng_alarm_time.is_stopped():
		print("Starting timer")
		var rand_index = rng.randi_range(0,3) # 4 indices
		
		var countdown = AhsManager.sounding_times[rand_index]
		print("Alarm will go off in ", countdown/60, " minutes")
		rng_alarm_time.wait_time = countdown
		rng_alarm_time.start()
		
	#if !rng_alarm_time.is_stopped():
		#print(rng_alarm_time.time_left)

func _on_timer_timeout():
	print("countdown has stopped, alarm will start")
	# sound the alarm
	AhsManager.sound_alarm("Alarm 1")
	
	#pass
	
func _on_game_state_changed(new_state):
	match new_state:
		GameManager.GameState.PAUSED:
			ambient_bg.stream_paused = true
			pause_menu.show()
		GameManager.GameState.PLAYING:
			ambient_bg.stream_paused = false
			pause_menu.hide()
