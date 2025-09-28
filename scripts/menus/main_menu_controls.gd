extends BoxContainer
const GAME = preload("uid://dld6rt8cylm2")
const HIGHSCORE_MENU = preload("uid://dymimjcrkx72l")

func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_packed(GAME)

func _on_btn_quit_game_pressed() -> void:
	get_tree().quit(0)

func _on_btn_highscores_pressed() -> void:
	get_tree().change_scene_to_packed(HIGHSCORE_MENU)
