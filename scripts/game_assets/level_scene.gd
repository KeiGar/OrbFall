extends Node2D
signal game_over

func _on_killzone_area_entered(area: Area2D) -> void:
	game_over.emit()
