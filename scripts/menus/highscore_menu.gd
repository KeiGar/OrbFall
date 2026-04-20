extends Control
@onready var highscore_table: GridContainer = $VBoxContainer/HighscoreTable
const FILEPATH_HIGHSCORE_DATA = "user://highscores.json"
var fileHandler = HighscoreManager.HighscoreFileHandler.new()
var Highscores: Array[HighscoreManager.HighscoreData] = []

func _ready() -> void:
	# Highscores = fileHandler.Highscores
	# Highscores.sort_custom(func(a: HighscoreManager.HighscoreData,b: HighscoreManager.HighscoreData): return a.Score > b.Score)
	Highscores = HighscoreManagerAPI.Highscores_Received
	displayHighscoreData()
	
func displayHighscoreData() -> void:
	var rank = 1
	for score in Highscores:
		var lbl_rank = Label.new()
		var lbl_player_name = Label.new()
		var lbl_score = Label.new()
		lbl_rank.text = str(rank)
		lbl_player_name.text = score.Player_Name
		lbl_score.text = str(score.Score)
		highscore_table.add_child(lbl_rank)
		highscore_table.add_child(lbl_player_name)
		highscore_table.add_child(lbl_score)
		rank += 1

func clearHighscoreTable() -> void:
	for n in highscore_table.get_children():
		highscore_table.remove_child(n)
		n.queue_free()

func _on_btn_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu_controls.tscn")
	
func _on_btn_delete_pressed() -> void:
	fileHandler.deleteAllData()
	Highscores = fileHandler.Highscores
	clearHighscoreTable()
	displayHighscoreData()
	
