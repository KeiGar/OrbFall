extends BoxContainer

signal btn_restart_pressed
signal btn_quit_pressed
signal btn_viewHighscore_pressed

func _on_btn_restart_pressed() -> void:
	btn_restart_pressed.emit()

func _on_btn_quit_pressed() -> void:
	btn_quit_pressed.emit()

func _on_btn_view_highscore_pressed() -> void:
	btn_viewHighscore_pressed.emit()
