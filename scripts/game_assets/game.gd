extends Node2D
@onready var level_scenes: Node2D = $LevelScenes
@onready var game_timer: Node2D = $GameTimer
@onready var game_over_screen: BoxContainer = $Menus/GameOverScreen
@onready var score_label: Label = $ScoreLabel

signal game_start
signal pause
signal unpause

var isGamePaused = false
var gameEnded = false
var startGameTimerRunning = false
var player_score := 0

func _ready() -> void:
	game_over_screen.visible = false
	startGameTimerRunning = true
	game_start.emit()
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED
	
func _process(delta: float) -> void:
	if not (gameEnded or startGameTimerRunning):
		readUserInput()
		
func readUserInput() -> void:
	if Input.is_action_pressed("quit_game"):
		get_tree().quit(0)
	if Input.is_action_just_pressed("pause_game"):
		if isGamePaused:
			unpauseGame()
		else:
			pauseGame()	
			
func unpauseGame() -> void:
	isGamePaused = false
	level_scenes.process_mode = Node.PROCESS_MODE_ALWAYS
	unpause.emit()
	
func pauseGame() -> void:
	isGamePaused = true
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED
	pause.emit()
	
func quitGame() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu_controls.tscn")

func _on_game_start_timer_timeout() -> void:
	startGameTimerRunning = false
	level_scenes.process_mode = Node.PROCESS_MODE_ALWAYS
	game_timer.queue_free()

func _on_pause_menu_btn_quit_pressed() -> void:
	quitGame()
	
func _on_pause_menu_btn_continue_pressed() -> void:
	unpauseGame()

func _on_game_over_screen_btn_quit_pressed() -> void:
	quitGame()
	

func _on_game_over_screen_btn_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_level_scenes_game_over() -> void:
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED
	game_over_screen.visible = true
	gameEnded = true

func _on_level_scenes_increment_points(incr: int) -> void:
	player_score += incr
	score_label.text = "%d" % player_score

func _on_game_over_screen_btn_view_highscore_pressed() -> void:
	PlayerVariables.player_score = player_score
	get_tree().change_scene_to_file("res://scenes/menus/highscore_saving_screen.tscn")
