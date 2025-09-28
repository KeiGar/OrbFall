extends BoxContainer
const GAME = preload("uid://dld6rt8cylm2")

func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_packed(GAME)


func _on_btn_quit_game_pressed() -> void:
	get_tree().quit(0)
