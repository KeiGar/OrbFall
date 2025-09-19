extends Node2D
@onready var level_scenes: Node2D = $LevelScenes
@onready var game_timer: Node2D = $GameTimer
@onready var game_over_label: Label = $GameOverScreen/GameOverLabel

signal game_start

func _ready() -> void:
	game_over_label.visible = false
	game_start.emit()
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("quit_game"):
		get_tree().quit()


func _on_game_timer_pause() -> void:
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED


func _on_game_timer_unpause() -> void:
	level_scenes.process_mode = Node.PROCESS_MODE_ALWAYS
	game_timer.queue_free()


func _on_killzone_game_over() -> void:
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED
	game_over_label.visible = true
	
	
