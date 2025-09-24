extends BoxContainer


func _on_game_pause() -> void:
	visible = true

func _on_game_unpause() -> void:
	visible = false
