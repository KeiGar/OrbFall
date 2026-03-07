extends Control
@onready var btn: TextureButton = $BTN
const SPEAKER_MUTE = preload("uid://dgkc5ulm7burk")
const SPEAKER_UNMUTE = preload("uid://bqqdaokqnqe1c")

var is_muted: bool
const AUDIO_BUS_MAIN := 0

func _ready() -> void:
	is_muted = GlobalSettings.sound_muted
	load_texture()

func load_texture() -> void:
	if is_muted:
		btn.texture_normal = SPEAKER_MUTE
	else:
		btn.texture_normal = SPEAKER_UNMUTE
		

func toggle_mute() -> void:
	is_muted = !is_muted
	AudioServer.set_bus_mute(AUDIO_BUS_MAIN, is_muted)
	GlobalSettings.sound_muted = is_muted
	
func _on_btn_pressed() -> void:
	toggle_mute()
	load_texture()

func _on_mouse_entered() -> void:
	btn.scale = Vector2(1.25, 1.25)

func _on_mouse_exited() -> void:
	btn.scale = Vector2(1, 1)
