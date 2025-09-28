extends BoxContainer
const MAIN_MENU_CONTROLS = preload("uid://b3ceglkuwrcgy")

signal btn_quit_pressed
signal btn_continue_pressed

func _on_game_pause() -> void:
	visible = true

func _on_game_unpause() -> void:
	visible = false

func _on_btn_continue_pressed() -> void:
	btn_continue_pressed.emit()

func _on_btn_quit_pressed() -> void:
	btn_quit_pressed.emit()
