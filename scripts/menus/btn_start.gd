extends Button
const GAME = preload("uid://dld6rt8cylm2")

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(GAME)
