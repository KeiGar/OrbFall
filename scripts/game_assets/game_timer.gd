extends Node2D
@onready var game_start_timer: Timer = $Game_Start_Timer
@onready var timer_display: Label = $Game_Start_Timer/TimerDisplay

const GAME_START_COUNTDOWN := 4

func _process(delta: float) -> void:
	if game_start_timer.time_left > .8:
		timer_display.text = "%.0f" % game_start_timer.time_left
	else:
		timer_display.text = "START!" 

func _on_game_start_timer_timeout() -> void:
	print("Game unpaused!")

func _on_game_game_start() -> void:
	game_start_timer.start(GAME_START_COUNTDOWN)
	print("Game start!")
