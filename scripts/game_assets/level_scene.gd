extends Node2D
signal game_over

func _on_killzone_killzone_hit() -> void:
	game_over.emit()
