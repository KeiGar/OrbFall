extends BoxContainer

@onready var highscore_table: GridContainer = $HighscoreTable
const FILEPATH_HIGHSCORE_DATA = "user://highscores.json"
var Highscores = [
	HighscoreData.new("Kei", 1000),
	HighscoreData.new("SuMario", 9999),
	HighscoreData.new("Chana", 10000),
	]

func _ready() -> void:
	# Highscores = readHighscoreData()
	Highscores.sort_custom(func(a: HighscoreData,b: HighscoreData): return a.Score > b.Score)
	displayHighscoreData()
	
func readHighscoreData() -> Array:
	if FileAccess.file_exists(FILEPATH_HIGHSCORE_DATA):
		var file = FileAccess.open(FILEPATH_HIGHSCORE_DATA, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			file.close()
			var jsonData = JSON.parse_string(content)
			if jsonData is Array:
				print("Highscore loaded successfully!")
				return jsonData
			else:
				print("Error parsing save file.")
		else:
			print("Error opening highscore save file.")
	else:
		print("Highscore save file not found.")
	return []


func saveHighscoreData() -> void:
	var file = FileAccess.open(FILEPATH_HIGHSCORE_DATA,FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(Highscores))
		file.close()
		print("Highscore saved successfully!")
	else:
		print("Error occurred while saving the highscore.")

func addHighScoreData(player_name: String, score: int) -> void:
	Highscores.append(HighscoreData.new(player_name, score))


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

func _on_btn_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu_controls.tscn")
	
	
class HighscoreData:
	var Player_Name = ""
	var Score = 0
	
	func _init(player_name: String, score: int):
		self.Player_Name = player_name
		self.Score = score
