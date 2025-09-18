extends Node2D
@onready var level_scenes: Node2D = $LevelScenes
@onready var game_timer: Node2D = $GameTimer

signal game_start

func _ready() -> void:
	game_start.emit()
	
func _process(delta: float) -> void:
	pass


func _on_game_timer_pause() -> void:
	level_scenes.process_mode = Node.PROCESS_MODE_DISABLED


func _on_game_timer_unpause() -> void:
	level_scenes.process_mode = Node.PROCESS_MODE_ALWAYS
	game_timer.queue_free()
