extends Area2D

signal game_over

func _on_area_entered(area: Area2D) -> void:
	print("Game Over!")
	game_over.emit()
