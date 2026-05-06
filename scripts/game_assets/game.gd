extends Node2D
@onready var level_scenes: Node2D = $LevelScenes
@onready var game_timer: Node2D = $GameTimer
@onready var game_over_screen: BoxContainer = $Menus/GameOverScreen
@onready var score_label: Label = $ScoreLabel
@onready var animation_player: AnimationPlayer = $PostEffects/AnimationPlayer
@onready var camera: Camera2D = $Camera2D
@onready var hud_game_controls: Control = $HUDGameControls
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var mobile_controls_overlay: Control = $MobileControlsOverlay


signal game_start
signal pause
signal unpause

var isGamePaused = false
var gameEnded = false
var startGameTimerRunning = false
var player_score := 0
var camera_original_pos: Vector2
var is_time_slowed_down = false

func _ready() -> void:
	game_over_screen.visible = false
	startGameTimerRunning = true
	game_start.emit()
	
	# TODO: pause scene without disabling whole scene, so that level scene nodes can be fully instantiated
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED
	
	camera_original_pos = camera.position
	show_mobile_overlay(DisplayServer.is_touchscreen_available())
	
func _process(delta: float) -> void:
	readUserInput_GeneralControls()
	if not (gameEnded or startGameTimerRunning):
		readUserInput_MenuControls()
		if not isGamePaused:
			readUserInput_GameControls()
			if is_time_slowed_down:
				camera.position = level_scenes.get_ball_position()
		 
func readUserInput_MenuControls() -> void:
	if Input.is_action_just_pressed("pause_game"):
		if isGamePaused:
			unpauseGame()
		else:
			pauseGame()	
			
func readUserInput_GeneralControls() -> void:
	if Input.is_action_just_released("toggle_hud"):
		hud_game_controls.visible = not hud_game_controls.visible
			
func readUserInput_GameControls() -> void:
	if Input.is_action_just_pressed("slow_down_time"):
		slowTime()
	if Input.is_action_just_released("slow_down_time"):
		revertTime()
			
func slowTime() -> void:
	if not is_time_slowed_down:
		Engine.set_time_scale(0.35)
		camera.position = level_scenes.get_ball_position()
		animation_player.play("camera_zoom_animation")
		is_time_slowed_down = true
		
func revertTime() -> void:
	if is_time_slowed_down:
		Engine.set_time_scale(1.0)
		camera.position = camera_original_pos
		is_time_slowed_down = false
		animation_player.play("camera_zoom_out")
		
			
func unpauseGame() -> void:
	isGamePaused = false
	level_scenes.process_mode = Node.PROCESS_MODE_ALWAYS
	show_mobile_overlay(true)
	unpause.emit()
	
func pauseGame() -> void:
	revertTime()
	isGamePaused = true
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED
	show_mobile_overlay(false)
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
	revertTime()
	audio_stream_player.play(0.1)
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED
	game_over_screen.visible = true
	show_mobile_overlay(false)
	gameEnded = true

func _on_level_scenes_increment_points(incr: int) -> void:
	player_score += incr
	score_label.text = "%d" % player_score

func _on_game_over_screen_btn_view_highscore_pressed() -> void:
	PlayerVariables.player_score = player_score
	get_tree().change_scene_to_file("res://scenes/menus/highscore_saving_screen.tscn")
	
func show_mobile_overlay(visible: bool) -> void:
	mobile_controls_overlay.visible = visible
	hud_game_controls.visible = !visible
	
