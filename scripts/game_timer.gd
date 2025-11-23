extends Node2D
@onready var game_start_timer: Timer = $Game_Start_Timer
@onready var timer_display: Label = $Game_Start_Timer/TimerDisplay

const GAME_START_COUNTDOWN := 4

signal pause
signal unpause


func _process(delta: float) -> void:
	if game_start_timer.time_left > .8:
		timer_display.text = "%.0f" % game_start_timer.time_left
	else:
		timer_display.text = "START!" 


func game_pause() -> void:
	game_start_timer.start(GAME_START_COUNTDOWN)
	print("Game paused!")
	pause.emit()

func game_unpause() -> void:
	print("Game unpaused!")
	unpause.emit()


func _on_game_start_timer_timeout() -> void:
	game_unpause()


func _on_game_game_start() -> void:
	game_pause() 
