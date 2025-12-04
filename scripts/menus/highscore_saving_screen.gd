extends Control
@onready var player_name_text_field: TextEdit = $VBoxContainer/PlayerNameTextField
@onready var lbl_score: Label = $VBoxContainer/LBLScore
@onready var save_button: Button = $VBoxContainer/SaveButton
var player_name: String = ""
var player_score: int = 0
var fileHandler:= HighscoreManager.HighscoreFileHandler.new()

func _ready() -> void:
	player_name = PlayerVariables.player_name
	player_score = PlayerVariables.player_score
	player_name_text_field.text = player_name
	if player_name == "":
		save_button.disabled = true
	lbl_score.text = "%d" % player_score
	
func _on_save_button_pressed() -> void:
	fileHandler.addHighScoreData(player_name, player_score)
	fileHandler.saveHighscoreData()
	PlayerVariables.player_name = player_name
	get_tree().change_scene_to_file("res://scenes/menus/main_menu_controls.tscn")

func _on_player_name_text_field_text_changed() -> void:
	if player_name_text_field.text != "":
		player_name = player_name_text_field.text
		save_button.disabled = false
	else:
		save_button.disabled = true

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		get_viewport().set_input_as_handled()
