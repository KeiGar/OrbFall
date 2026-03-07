extends Control
@onready var btn_mute: TextureButton = $BTN_Mute
@onready var btn_unmute: TextureButton = $BTN_Unmute

var is_muted := false

func toggle_mute() -> void:
	if !is_muted:
		btn_unmute.visible = true
		btn_mute.visible = false
		is_muted = true
	else:
		btn_unmute.visible = false
		btn_mute.visible = true
		is_muted = false
	
func _on_btn_pressed() -> void:
	toggle_mute()
