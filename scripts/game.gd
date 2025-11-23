extends Node2D
@onready var level_scenes: Node2D = $LevelScenes
@onready var game_timer: Node2D = $GameTimer
@onready var game_over_label: Label = $GameOverScreen/GameOverLabel

signal game_start
signal pause
signal unpause

var isGamePaused = false

func _ready() -> void:
	game_over_label.visible = false
	game_start.emit()
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("quit_game"):
		get_tree().quit()
	if Input.is_action_just_pressed("pause_game"):
		if isGamePaused:
			isGamePaused = false
			level_scenes.process_mode = Node.PROCESS_MODE_ALWAYS
			unpause.emit()
		else:
			isGamePaused = true
			level_scenes.process_mode = Node.PROCESS_MODE_DISABLED
			pause.emit()

func _on_killzone_game_over() -> void:
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED
	game_over_label.visible = true

func _on_game_start_timer_timeout() -> void:
	level_scenes.process_mode = Node.PROCESS_MODE_ALWAYS
	game_timer.queue_free()
